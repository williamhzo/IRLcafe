defmodule SvoenixWeb.AppLive do
  use SvoenixWeb, :live_view

  alias Svoenix.Cities
  alias Svoenix.Places

  def render(assigns) do
    ~H"""
    <section class="container flex max-w-lg flex-col items-center gap-12 px-4 py-12">
      <h1 class="text-brand self-start text-lg font-bold uppercase tracking-tight">
        <%= @city.name %> 🇵🇹
      </h1>

      <div class="flex flex-col items-start">
        <ul class="scrollbar-none flex snap-x snap-mandatory gap-2 overflow-x-scroll">
          <li
            :for={place <- @places}
            class="rounded-base relative grid grid-rows-[auto,1fr,auto] border p-5 border-gray-200 h-full w-full shrink-0 bg-white snap-start gap-4"
          >
            <div class="items-items flex justify-between">
              <h2 class="text-xl font-bold md:text-lg"><%= place.label %></h2>

              <span class="relative flex h-3 w-3 shrink-0">
                <span class="absolute inline-flex h-full w-full animate-ping rounded-full bg-green-400 opacity-75" />
                <span class="relative inline-flex h-3 w-3 rounded-full bg-green-500" />
              </span>
            </div>

            <div>
              <p class="prose"><%= place.description %></p>
              <small class="text-muted text-base">John and 7 others are meeting there</small>
            </div>

            <img
              src="https://images.unsplash.com/photo-1417325384643-aac51acc9e5d?q=75&fm=jpg&w=1080&fit=max"
              class="w-full rounded-sm object-contain"
            />

            <p class="text-muted text-center">420m from your location</p>
          </li>
        </ul>
      </div>

      <button phx-click={JS.navigate(~p"/")}>change city</button>
    </section>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"slug" => slug} = _params, _url, socket) do
    socket =
      assign(socket,
        city: Cities.get_city_by_slug!(slug),
        places: Places.list_places() |> Enum.filter(&(&1.city == slug))
      )

    {:noreply, socket}
  end
end
