defmodule Svoenix.BookingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Svoenix.Bookings` context.
  """

  @doc """
  Generate a booking.
  """
  def booking_fixture(user_id, place_id, attrs \\ %{}) do
    {:ok, booking} =
      booking_attrs(user_id, place_id, attrs)
      |> Svoenix.Bookings.create_booking()

    booking
  end

  def booking_attrs(user_id, place_id, attrs \\ %{}) do
    attrs
    |> Enum.into(%{
      place_id: place_id,
      user_id: user_id,
      date: ~D[2023-03-17],
      slots: ["morning"]
    })
  end
end
