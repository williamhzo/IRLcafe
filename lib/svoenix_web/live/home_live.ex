defmodule SvoenixWeb.HomeLive do
  use SvoenixWeb, :live_view

  alias Svoenix.Cities
  alias Svoenix.Cities.City

  def render(assigns) do
    ~H"""
    <section class="container flex flex-col items-center gap-12 px-4 py-12">
      <header class="flex flex-col items-center gap-1">
        <p class="text-4xl">👨‍💻☕️</p>
        <h1 class="tracking widest text-4xl font-bold">IRL café</h1>
        <h2 class="mt-2 text-center text-slate-500">
          find the best spots near you & <br /> meet coffee buddies
        </h2>
      </header>

      <div class="flex items-center space-x-4">
        <.form id="city-form" for={@form} class="relative" phx-submit="save">
          <input
            id="city-name-input"
            name="name"
            type="text"
            placeholder="lisbon"
            class={[
              "w-[12ch] py-4 px-5 text-5xl placeholder:text-gray-400 hover:bg-gray-100 rounded-md",
              "border-none ring-none outline-none",
              "focus:border-transparent focus:ring-transparent focus:shadow-none"
            ]}
            autocomplete="off"
            required
          />
        </.form>

        <button
          class="flex items-baseline bg-brand text-white px-4 py-2.5 rounded shadow-lg group"
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
