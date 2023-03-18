defmodule SvoenixWeb.CityLiveTest do
  use SvoenixWeb.ConnCase, async: true

  import Phoenix.LiveViewTest
  import Svoenix.CitiesFixtures

  @update_attrs %{name: "some updated name", slug: "some updated slug"}
  @invalid_attrs %{name: nil, slug: nil}

  defp create_city(_) do
    city = city_fixture()
    %{city: city}
  end

  describe "Index" do
    setup [:create_city]

    test "lists all cities", %{conn: conn, city: city} do
      {:ok, _index_live, html} = live(conn, ~p"/cities")

      assert html =~ "Listing Cities"
      assert html =~ city.name
    end

    test "saves new city", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/cities")

      assert index_live |> element("a", "New City") |> render_click() =~
               "New City"

      assert_patch(index_live, ~p"/cities/new")

      assert index_live
             |> form("#city-form", city: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      city_attrs = city_attrs()
      name = city_attrs.name

      assert index_live
             |> form("#city-form", city: city_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/cities")

      html = render(index_live)
      assert html =~ "City created successfully"
      assert html =~ name
    end

    test "updates city in listing", %{conn: conn, city: city} do
      {:ok, index_live, _html} = live(conn, ~p"/cities")

      assert index_live |> element("#cities-#{city.id} a", "Edit") |> render_click() =~
               "Edit City"

      assert_patch(index_live, ~p"/cities/#{city}/edit")

      assert index_live
             |> form("#city-form", city: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#city-form", city: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/cities")

      html = render(index_live)
      assert html =~ "City updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes city in listing", %{conn: conn, city: city} do
      {:ok, index_live, _html} = live(conn, ~p"/cities")

      assert index_live |> element("#cities-#{city.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#cities-#{city.id}")
    end
  end

  describe "Show" do
    setup [:create_city]

    test "displays city", %{conn: conn, city: city} do
      {:ok, _show_live, html} = live(conn, ~p"/cities/#{city}")

      assert html =~ "Show City"
      assert html =~ city.name
    end

    test "updates city within modal", %{conn: conn, city: city} do
      {:ok, show_live, _html} = live(conn, ~p"/cities/#{city}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit City"

      assert_patch(show_live, ~p"/cities/#{city}/show/edit")

      assert show_live
             |> form("#city-form", city: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#city-form", city: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/cities/#{city}")

      html = render(show_live)
      assert html =~ "City updated successfully"
      assert html =~ "some updated name"
    end
  end
end
