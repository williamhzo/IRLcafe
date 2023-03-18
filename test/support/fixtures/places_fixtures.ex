defmodule Svoenix.PlacesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Svoenix.Places` context.
  """

  def unique_slug do
    "cafe-#{Ecto.UUID.generate()}"
  end

  def place_attrs(attrs \\ %{}) do
    Enum.into(attrs, %{
      city: "some city",
      slug: unique_slug(),
      label: "some label",
      description: "some description",
      x: "some x",
      y: "some y"
    })
  end

  @doc """
  Generate a place.
  """
  def place_fixture(attrs \\ %{}) do
    {:ok, place} =
      attrs
      |> place_attrs()
      |> Svoenix.Places.create_place()

    place
  end
end
