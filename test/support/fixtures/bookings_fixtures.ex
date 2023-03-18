defmodule Svoenix.BookingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Svoenix.Bookings` context.
  """

  @doc """
  Generate a booking.
  """
  def booking_fixture(attrs \\ %{}) do
    {:ok, booking} =
      attrs
      |> Enum.into(%{
        date: ~D[2023-03-17],
        slot: "morning"
      })
      |> Svoenix.Bookings.create_booking()

    booking
  end
end
