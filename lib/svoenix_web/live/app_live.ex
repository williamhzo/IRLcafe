defmodule SvoenixWeb.AppLive do
  use SvoenixWeb, :live_view

  alias Svoenix.Cities
  alias Svoenix.Places
  alias Svoenix.Bookings
  alias SvoenixWeb.Components.Svelte

  def render(assigns) do
    ~H"""
    <section class="flex flex-col md:px-8 w-full max-w-[min(100%,60rem)]">
      <Svelte.render id="places" name="Places" props={%{"places" => @places}} />
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
