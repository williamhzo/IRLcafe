defmodule Svoenix.PlacesTest do
  use Svoenix.DataCase, async: true

  alias Svoenix.Places

  describe "places" do
    alias Svoenix.Places.Place

    import Svoenix.PlacesFixtures
    import Svoenix.CitiesFixtures, only: [city_fixture: 0]

    @invalid_attrs %{city: nil, description: nil, label: nil, x: nil, y: nil}

    test "list_places/0 returns all places" do
      place = place_fixture()
      assert Places.list_places() == [place]
    end

    test "list_places_of_city_slug/1 returns all places of given city" do
      city = city_fixture()
      place = place_fixture(%{}, city.id) |> Svoenix.Repo.preload(:bookings)
      assert Places.list_places_of_city_slug(city.slug) == [place]
    end

    test "get_place!/1 returns the place with given id" do
      place = place_fixture()
      assert Places.get_place!(place.id) == place
    end

    test "get_place_by_slug!/1 returns the place with given slug" do
      place = place_fixture()
      assert Places.get_place_by_slug!(place.slug) == place
    end

    test "create_place/1 with valid data creates a place" do
      valid_attrs = place_attrs()

      assert {:ok, %Place{} = place} = Places.create_place(valid_attrs)
      assert place.city_id == valid_attrs.city_id
      assert place.slug == valid_attrs.slug
      assert place.label == valid_attrs.label
      assert place.description == valid_attrs.description
      assert place.x == valid_attrs.x
      assert place.y == valid_attrs.y
    end

    test "create_place/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Places.create_place(@invalid_attrs)
    end

    test "update_place/2 with valid data updates the place" do
      place = place_fixture()

      update_attrs = %{
        # city: "some updated city",
        description: "some updated description",
        label: "some updated label",
        x: "some updated x",
        y: "some updated y"
      }

      assert {:ok, %Place{} = place} = Places.update_place(place, update_attrs)
      # assert place.city == "some updated city"
      assert place.description == "some updated description"
      assert place.label == "some updated label"
      assert place.x == "some updated x"
      assert place.y == "some updated y"
    end

    test "update_place/2 with invalid data returns error changeset" do
      place = place_fixture()
      assert {:error, %Ecto.Changeset{}} = Places.update_place(place, @invalid_attrs)
      assert place == Places.get_place!(place.id)
    end

    test "delete_place/1 deletes the place" do
      place = place_fixture()
      assert {:ok, %Place{}} = Places.delete_place(place)
      assert_raise Ecto.NoResultsError, fn -> Places.get_place!(place.id) end
    end

    test "change_place/1 returns a place changeset" do
      place = place_fixture()
      assert %Ecto.Changeset{} = Places.change_place(place)
    end
  end
end
