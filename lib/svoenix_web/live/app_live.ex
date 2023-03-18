defmodule SvoenixWeb.AppLive do
  use SvoenixWeb, :live_view

  alias Svoenix.Cities
  alias Svoenix.Places

  def render(assigns) do
    ~H"""
    <section class="container flex max-w-lg flex-col items-center gap-12 px-4 py-12">
      <header class="flex flex-col items-center">
        <p class="text-muted">current city</p>
        <h1 class="text-brand text-xl font-bold uppercase tracking-tight">
          <%= @city.name %>
        </h1>
      </header>

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

            <p class="prose lowercase"><%= place.description %></p>
            <small class="text-muted text-base">John and 7 others are meeting there</small>

            <img
              src="https://images.unsplash.com/photo-1417325384643-aac51acc9e5d?q=75&fm=jpg&w=1080&fit=max"
              class="max-h-[50vh] w-full rounded-lg object-cover object-center"
            />

            <div class="flex flex-col items-center">
              <p class="text-muted text-center">420 m from your location</p>
              <a href="https://goo.gl/maps/MB5bAcswpUryWinm9" class="text-sm font-normal underline">
                see in Google Maps
              </a>
            </div>
          </li>
        </ul>
      </div>
    </section>
    """
  end

  ### Server

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"city_slug" => city_slug} = _params, _url, socket) do
    socket =
      assign(socket,
        city: Cities.get_city_by_slug!(city_slug),
        places: list_places_of_city(city_slug)
      )

    {:noreply, socket}
  end

  ### Helpers

  defp list_places_of_city(city_slug) do
    # TODO: proper filtering with db query
    Places.list_places()
    |> Enum.filter(&(&1.city == city_slug))
  end
end
