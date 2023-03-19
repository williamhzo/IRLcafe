defmodule SvoenixWeb.AppLive do
  use SvoenixWeb, :live_view

  alias Svoenix.Cities
  alias Svoenix.Places
  alias Svoenix.Bookings
  alias Svoenix.Bookings.Booking

  alias SvoenixWeb.UserAuth
  alias SvoenixWeb.Components.Svelte

  def render(assigns) do
    ~H"""
    <section class="flex flex-col md:px-8 w-full max-w-[min(100%,60rem)]">
      <Svelte.render id="places" name="Places" props={%{places: @places}} />
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

  def handle_event("submit_bookings", _payload, socket) when socket.assigns.current_user == nil do
    {:noreply,
     socket
     |> put_flash(:error, "You must log in to book a slot.")
     |> UserAuth.maybe_store_return_to()
     |> redirect(to: ~p"/log_in")}
  end

  def handle_event(
        "submit_bookings",
        %{"place_id" => place_id, "slots" => slots} = _payload,
        socket
      ) do
    bookings =
      slots
      |> Enum.map(
        &(&1
          |> Map.put("user_id", socket.assigns.current_user.id)
          |> Map.put("place_id", place_id))
      )
      |> Enum.map(&Bookings.create_booking/1)
      |> Enum.map(fn
        {:ok, %Booking{} = booking} -> booking
        {:error, _changeset} -> nil
      end)

    {:reply, %{bookings: bookings}, socket}
  end

  def handle_event("toggle_slots", _value, socket) do
    {:noreply, update(socket, :show_slots, &(not &1))}
  end
end
