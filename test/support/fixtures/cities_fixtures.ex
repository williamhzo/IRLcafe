defmodule Svoenix.CitiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Svoenix.Cities` context.
  """

  @doc """
  Generate a city.
  """
  def city_fixture(attrs \\ %{}) do
    {:ok, city} =
      attrs
      |> Enum.into(%{
        name: "some name",
        slug: "some slug"
      })
      |> Svoenix.Cities.create_city()

    city
  end
end
