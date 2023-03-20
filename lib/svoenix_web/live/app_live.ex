defmodule SvoenixWeb.AppLive do
  use SvoenixWeb, :live_view

  alias Svoenix.Cities
  alias Svoenix.Places
  alias Svoenix.Places.Place
  alias Svoenix.Bookings
  alias Svoenix.Bookings.Booking

  alias SvoenixWeb.Components.Svelte

  def render(assigns) do
    ~H"""
    <section class="flex flex-col md:px-8 w-full max-w-[min(100%,60rem)] mx-auto">
      <Svelte.render id="places" name="Places" props={%{places: @places}} />
      <%!-- FIXME --%>
      <%!-- <div class="abosulute h-full inset-0 w-12 debug sm:w-32 md:w-48 right-0 bg-gradient-to-l from-background via-background/75 to-transparent"></div> --%>
    </section>
    """
  end

  ### Server

  def mount(_params, _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(Svoenix.PubSub, "bookings:all")
    end

    {:ok, socket}
  end

  def handle_params(%{"city_slug" => city_slug} = _params, _url, socket) do
    socket =
      assign(socket,
        city: Cities.get_city_by_slug!(city_slug),
        places: Places.list_places_of_city_slug(city_slug)
      )

    {:noreply, socket}
  end

  def handle_event("submit_bookings", _payload, socket)
      when socket.assigns.current_user == nil do
    {:noreply,
     socket
     |> put_flash(:error, "you must log in to book a slot")
     |> redirect(to: ~p"/log_in")}
  end

  def handle_event(
        "submit_bookings",
        %{"place_id" => place_id, "bookings" => bookings} = _payload,
        socket
      ) do
    user_id = socket.assigns.current_user.id

    new_bookings =
      bookings
      |> Enum.map(fn {date, slots} -> Bookings.upsert_booking(place_id, user_id, date, slots) end)
      |> Enum.map(fn
        {:ok, %Booking{} = booking} -> booking
      end)

    {:reply, %{bookings: new_bookings}, socket}
  end

  def handle_info({:bookings_updated, bookings, place_id}, socket) do
    places =
      Enum.map(socket.assigns.places, fn
        %Place{id: ^place_id} = p -> %{p | bookings: bookings}
        %Place{} = p -> p
      end)

    {:noreply, assign(socket, :places, places)}
  end
end
