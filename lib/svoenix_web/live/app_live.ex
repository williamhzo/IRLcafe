defmodule SvoenixWeb.AppLive do
  use SvoenixWeb, :live_view

  alias Svoenix.Cities
  alias Svoenix.Places
  alias Svoenix.Bookings
  alias SvoenixWeb.Components.Svelte

  def render(assigns) do
    ~H"""
    <section class="flex flex-col items-center gap-5 md:gap-12 md:px-8">
      <div class=" w-full flex flex-col items-start max-w-[min(100%,60rem)]">
        <ul class="first:pl-[10%] scrollbar-none flex w-full last:pr-[10%] snap-x snap-mandatory py-2 items-start gap-2 overflow-x-scroll">
          <li
            :for={place <- @places}
            class="relative p-3 border rounded-base xs:p-4 bg-gray-50/75 sm:p-5 group overflow-hidden border-gray-100 h-full w-[90%] shrink-0 snap-center"
          >
            <button
              phx-click="toggle_slots"
              class="grid grid-rows-[auto,1fr,auto] gap-8 outline-transparent ring-offset-2 focus-visible:ring-brand focus-visible:ring-2"
            >
              <div class="items-items flex justify-between">
                <h3 class="text-xl font-bold md:text-lg"><%= place.label %></h3>

                <span class="relative flex h-3 w-3 shrink-0 z-20">
                  <span class="absolute inline-flex h-full w-full animate-ping rounded-full bg-green-400 opacity-75" />
                  <span class="relative inline-flex h-3 w-3 rounded-full bg-green-500" />
                </span>
              </div>

              <p class="prose lowercase text-start"><%= place.description %></p>

              <small class="text-muted text-base lowercase text-start">
                John and 7 others are meeting there
              </small>

              <img
                src="https://images.unsplash.com/photo-1417325384643-aac51acc9e5d?q=75&fm=jpg&w=1080&fit=max"
                class="w-full max-w-full rounded-lg object-cover object-center aspect-video"
              />

              <div class="flex flex-col items-center">
                <p class="text-muted text-center">420m from your location</p>
                <a
                  href="https://goo.gl/maps/MB5bAcswpUryWinm9"
                  class="text-center text-sm font-normal underline"
                >
                  see in google maps
                </a>
              </div>
            </button>

            <Svelte.render :if={@show_slots} id="slots" name="Slots" />
          </li>
        </ul>
      </div>
    </section>
    """
  end

  ### Server

  def mount(_params, _session, socket) do
    {:ok, assign(socket, show_slots: false)}
  end

  def handle_params(%{"city_slug" => city_slug} = _params, _url, socket) do
    socket =
      assign(socket,
        city: Cities.get_city_by_slug!(city_slug),
        places: Places.list_places_of_city_slug(city_slug)
      )

    {:noreply, socket}
  end

  def handle_event("submit_bookings", %{"slots" => slots}, socket) do
    slots
    |> Enum.map(fn booking_params ->
      Bookings.create_booking(booking_params)
    end)

    {:noreply, push_navigate(socket, to: ~p"/#{socket.assigns.city.slug}")}
  end

  def handle_event("toggle_slots", _value, socket) do
    {:noreply, update(socket, :show_slots, &(not &1))}
  end
end
