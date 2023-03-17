defmodule Svoenix.PlacesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Svoenix.Places` context.
  """

  @doc """
  Generate a place.
  """
  def place_fixture(attrs \\ %{}) do
    {:ok, place} =
      attrs
      |> Enum.into(%{
        city: "some city",
        description: "some description",
        label: "some label",
        x: "some x",
        y: "some y"
      })
      |> Svoenix.Places.create_place()

    place
  end
end
