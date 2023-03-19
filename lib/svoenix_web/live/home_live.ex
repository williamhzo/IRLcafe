defmodule SvoenixWeb.HomeLive do
  use SvoenixWeb, :live_view

  alias Svoenix.Cities
  alias Svoenix.Cities.City

  def render(assigns) do
    ~H"""
    <section class="container flex flex-col items-center gap-28 px-4 py-12">
      <header class="flex flex-col items-center gap-1">
        <p class="text-4xl">👨‍💻☕️</p>
        <h1 class="mt-1 tracking widest text-4xl font-bold">IRL café</h1>
        <h2 class="mt-2 text-center text-slate-500">
          find the best spots near you & <br /> meet coffee buddies
        </h2>
      </header>

      <.form
        id="city-form"
        for={@form}
        class="flex flex-wrap justify-center items-center gap-6"
        phx-submit="save"
      >
        <input
          id="city-name-input"
          name="name"
          type="text"
          tabindex="1"
          placeholder={Enum.random(["🇵🇹 lisbon", "🇫🇷 paris", "🇬🇧 london"])}
          class={[
            "w-full sm:w-[15ch] p-3",
            "text-left text-4xl placeholder:text-center placeholder:text-3xl placeholder:text-opacity-50 placeholder:text-gray-400",
            "bg-gray-100/75 hover:bg-gray-100 rounded-md shadow-inner",
            "border-2 border-gray-50 ring-transparent outline-transparent",
            "focus:border-brand focus:bg-gray-100 focus:ring-transparent",
            "transition duration-75"
          ]}
          autocomplete="off"
          required
        />

        <button class={[
          "flex justify-center items-center p-2.5",
          "text-white font-medium bg-brand rounded-full shadow",
          "phx-submit-loading:opacity-75 phx-submit-loading:animate-spin",
          "hover:translate-x-1 transition-transform"
        ]}>
          <.icon name="hero-arrow-right-mini" class="block phx-submit-loading:hidden h-6 w-6" />
          <.icon name="hero-lifebuoy-mini" class="hidden phx-submit-loading:block h-6 w-6" />
        </button>
      </.form>
    </section>
    """
  end

  ### Server

  def mount(_params, _session, socket) do
    socket = assign(socket, :form, to_form(%{"name" => nil}))
    {:ok, socket, layout: {SvoenixWeb.Layouts, :landing}}
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
