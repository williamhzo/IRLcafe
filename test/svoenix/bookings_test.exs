defmodule Svoenix.BookingsTest do
  use Svoenix.DataCase, async: true

  alias Svoenix.Bookings

  describe "bookings" do
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
