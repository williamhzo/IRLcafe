defmodule Svoenix.CitiesTest do
  use Svoenix.DataCase

  alias Svoenix.Cities

  describe "cities" do
    alias Svoenix.Cities.City

    import Svoenix.CitiesFixtures

    @invalid_attrs %{name: nil, slug: nil}

    test "list_cities/0 returns all cities" do
      city = city_fixture()
      assert Cities.list_cities() == [city]
    end

    test "get_city!/1 returns the city with given id" do
      city = city_fixture()
      assert Cities.get_city!(city.id) == city
    end

    test "get_city_by_slug!/1 returns the city with given slug" do
      city = city_fixture()
      assert Cities.get_city_by_slug!(city.slug) == city
    end

    test "get_city_by_name/1 returns the city with given name" do
      city = city_fixture()
      assert Cities.get_city_by_name(city.name) == city
    end

    test "create_city/1 with valid data creates a city" do
      valid_attrs = %{name: "some name", slug: "some slug"}

      assert {:ok, %City{} = city} = Cities.create_city(valid_attrs)
      assert city.name == "some name"
      assert city.slug == "some slug"
    end

    test "create_city/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cities.create_city(@invalid_attrs)
    end

    test "update_city/2 with valid data updates the city" do
      city = city_fixture()
      update_attrs = %{name: "some updated name", slug: "some updated slug"}

      assert {:ok, %City{} = city} = Cities.update_city(city, update_attrs)
      assert city.name == "some updated name"
      assert city.slug == "some updated slug"
    end

    test "update_city/2 with invalid data returns error changeset" do
      city = city_fixture()
      assert {:error, %Ecto.Changeset{}} = Cities.update_city(city, @invalid_attrs)
      assert city == Cities.get_city!(city.id)
    end

    test "delete_city/1 deletes the city" do
      city = city_fixture()
      assert {:ok, %City{}} = Cities.delete_city(city)
      assert_raise Ecto.NoResultsError, fn -> Cities.get_city!(city.id) end
    end

    test "change_city/1 returns a city changeset" do
      city = city_fixture()
      assert %Ecto.Changeset{} = Cities.change_city(city)
    end
  end
end
