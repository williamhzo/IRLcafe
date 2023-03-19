defmodule SvoenixWeb.HomeLive do
  use SvoenixWeb, :live_view

  alias Svoenix.Cities
  alias Svoenix.Cities.City

  def render(assigns) do
    ~H"""
    <section class="container flex flex-col items-center gap-28 px-4 py-12">
      <header class="flex flex-col items-center gap-1">
        <p class="text-4xl">👨‍💻☕️</p>
        <h1 class="tracking widest text-4xl font-bold">IRL café</h1>
        <h2 class="mt-2 text-center text-slate-500">
          find the best spots near you & <br /> meet coffee buddies
        </h2>
      </header>

      <div class="flex flex-wrap justify-center items-center gap-6">
        <.form id="city-form" for={@form} class="relative" phx-submit="save">
          <input
            id="city-name-input"
            name="name"
            type="text"
            placeholder={Enum.random(["🇵🇹 lisbon", "🇫🇷 paris", "🇬🇧 london"])}
            class={[
              "w-full sm:w-[12ch] py-4 px-5 text-4xl placeholder:text-3xl placeholder:text-opacity-50 placeholder:text-gray-400 bg-gray-100/75 shadow-inner hover:bg-gray-100 rounded-md",
              "border border-gray-50 ring-transparent outline-transparent",
              "focus:border-gray-200 focus:bg-gray-100 focus:ring-transparent",
              "transition duration-75 text-center"
            ]}
            autocomplete="off"
            required
          />
        </.form>

        <button
          class="w-full sm:w-[12ch] flex justify-center items-baseline bg-brand text-white px-6 py-3.5 rounded group"
          phx-disable-with="exploring..."
        >
          <span class="text-lg font-semibold">explore</span>
          <.icon
            name="hero-arrow-right-mini"
            class="h-4 w-4 translate-y-0.5 ml-3 group-hover:translate-x-1 transition-transform"
          />
        </button>
      </div>
    </section>
    """
  end

  ### Server

  def mount(_params, _session, socket) do
    socket = assign(socket, :form, to_form(%{"name" => nil}))
    {:ok, socket}
  end

  def handle_event("save", %{"name" => name}, socket) do
    case name |> String.trim() |> String.capitalize() |> get_city() do
      nil -> {:noreply, socket}
      %City{slug: slug} -> {:noreply, push_navigate(socket, to: ~p"/#{slug}")}
    end
  end

  ### Helpers

  defp get_city(name) do
    Cities.get_city_by_name(name)
  end
end
