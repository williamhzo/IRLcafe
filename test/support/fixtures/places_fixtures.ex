defmodule Svoenix.PlacesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Svoenix.Places` context.
  """

  alias Svoenix.Repo

  def unique_slug do
    "cafe-#{Ecto.UUID.generate()}"
  end

  def place_attrs(attrs \\ %{}, city_id \\ nil)

  def place_attrs(attrs, nil) do
    city = Svoenix.CitiesFixtures.city_fixture()
    place_attrs(attrs, city.id)
  end

  def place_attrs(attrs, city_id) do
    Enum.into(attrs, %{
      city_id: city_id,
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
  def place_fixture(attrs \\ %{}, city_id \\ nil)

  def place_fixture(attrs, nil) do
    city = Svoenix.CitiesFixtures.city_fixture()
    place_fixture(attrs, city.id)
  end

  def place_fixture(attrs, city_id) do
    {:ok, place} =
      attrs
      |> place_attrs(city_id)
      |> Svoenix.Places.create_place()

    place
    |> Repo.preload(:city)
  end
end
