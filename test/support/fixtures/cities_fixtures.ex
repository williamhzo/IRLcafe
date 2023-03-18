defmodule Svoenix.CitiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Svoenix.Cities` context.
  """

  def unique_name do
    "City #{Ecto.UUID.generate()}"
  end

  def city_attrs(attrs \\ %{}) do
    name = unique_name()

    Enum.into(attrs, %{
      name: name,
      slug: slugify(name)
    })
  end

  @doc """
  Generate a city.
  """
  def city_fixture(attrs \\ %{}) do
    {:ok, city} =
      attrs
      |> city_attrs()
      |> Svoenix.Cities.create_city()

    city
  end

  def slugify(name) do
    name
    |> String.downcase()
    |> String.replace(" ", "-")
  end
end
