defmodule Svoenix.BookingsTest do
  use Svoenix.DataCase, async: true

  alias Svoenix.Bookings

  describe "bookings" do
    alias Svoenix.Places.Place
    alias Svoenix.Bookings.Booking

    import Svoenix.PlacesFixtures
    import Svoenix.BookingsFixtures
    import Svoenix.AccountsFixtures

    @invalid_attrs %{user_id: nil, place_id: nil, date: nil, slot: nil}

    setup do
      user = user_fixture()
      place = place_fixture()

      {:ok, user: user, place: place}
    end

    test "list_bookings/0 returns all bookings", %{user: user, place: place} do
      booking = booking_fixture(user.id, place.id)
      assert Bookings.list_bookings() == [booking]
    end

    test "get_booking!/1 returns the booking with given id", %{user: user, place: place} do
      booking = booking_fixture(user.id, place.id)
      assert Bookings.get_booking!(booking.id) == booking
    end

    test "create_booking/1 with valid data creates a booking", %{user: user, place: place} do
      valid_attrs = booking_attrs(user.id, place.id, %{date: ~D[2023-03-17], slot: "afterwork"})

      assert {:ok, %Booking{} = booking} = Bookings.create_booking(valid_attrs)
      assert booking.date == ~D[2023-03-17]
      assert booking.slot == :afterwork
    end

    test "create_booking/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bookings.create_booking(@invalid_attrs)
    end

    test "update_bookings/4 with valid data updates bookings", %{user: user, place: place} do
      user_id = user.id
      place_id = place.id

      fixture = fn attrs -> booking_fixture(user_id, place_id, attrs) end

      # Prepare Place with 2 bookings
      existing_booking_1 = fixture.(%{date: ~D[2023-03-17], slot: "morning"})
      existing_booking_2 = fixture.(%{date: ~D[2023-03-17], slot: "lunch"})

      assert %Place{bookings: [^existing_booking_1, ^existing_booking_2]} =
               Svoenix.Repo.preload(place, :bookings)

      # Update bookings
      assert {:ok,
              %Place{
                bookings: [
                  %Booking{user_id: ^user_id, date: ~D[2023-03-17], slot: :lunch} = _booking_1,
                  %Booking{user_id: ^user_id, date: ~D[2023-03-17], slot: :afternoon} = _booking_2
                ]
              }} =
               Bookings.update_bookings(place_id, user_id, ~D[2023-03-17], [:lunch, :afternoon])

      assert {:ok, %Place{bookings: []}} =
               Bookings.update_bookings(place_id, user_id, ~D[2023-03-17], [])

      assert {:ok,
              %Place{
                bookings: [
                  %Booking{user_id: ^user_id, date: ~D[2023-03-17], slot: :morning} = _booking_1,
                  %Booking{user_id: ^user_id, date: ~D[2023-03-17], slot: :afterwork} = _booking_2
                ]
              }} =
               Bookings.update_bookings(place_id, user_id, ~D[2023-03-17], [:morning, :afterwork])
    end

    test "update_bookings/4 with invalid data returns error changeset",
         %{user: user, place: place} do
      assert {:error, %Ecto.Changeset{valid?: false}} =
               Bookings.update_bookings(place.id, user.id, ~D[2023-03-17], ["invalid"])
    end

    test "update_booking/2 with valid data updates the booking", %{user: user, place: place} do
      booking = booking_fixture(user.id, place.id)
      update_attrs = %{date: ~D[2023-03-18], slot: "afternoon"}

      assert {:ok, %Booking{} = booking} = Bookings.update_booking(booking, update_attrs)
      assert booking.date == ~D[2023-03-18]
      assert booking.slot == :afternoon
    end

    test "update_booking/2 with invalid data returns error changeset", %{user: user, place: place} do
      booking = booking_fixture(user.id, place.id)
      assert {:error, %Ecto.Changeset{}} = Bookings.update_booking(booking, @invalid_attrs)
      assert booking == Bookings.get_booking!(booking.id)
    end

    test "delete_booking/1 deletes the booking", %{user: user, place: place} do
      booking = booking_fixture(user.id, place.id)
      assert {:ok, %Booking{}} = Bookings.delete_booking(booking)
      assert_raise Ecto.NoResultsError, fn -> Bookings.get_booking!(booking.id) end
    end

    test "change_booking/1 returns a booking changeset", %{user: user, place: place} do
      booking = booking_fixture(user.id, place.id)
      assert %Ecto.Changeset{} = Bookings.change_booking(booking)
    end
  end
end
