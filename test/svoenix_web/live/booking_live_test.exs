defmodule SvoenixWeb.BookingLiveTest do
  use SvoenixWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  import Svoenix.PlacesFixtures
  import Svoenix.BookingsFixtures
  import Svoenix.AccountsFixtures

  @update_attrs %{date: "2023-03-18", slot: "afternoon"}
  @invalid_attrs %{date: nil, slot: nil}

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end

  defp create_place(_) do
    place = place_fixture()
    %{place: place}
  end

  defp create_booking(%{user: user, place: place}) do
    booking = booking_fixture(user.id, place.id)
    %{booking: booking}
  end

  describe "Index" do
    setup [:create_user, :create_place, :create_booking]

    test "lists all bookings", %{conn: conn, booking: booking} do
      {:ok, _index_live, html} = live(conn, ~p"/bookings")

      assert html =~ "Listing Bookings"
      assert html =~ "#{booking.slot}"
    end

    test "saves new booking", %{conn: conn, user: user, place: place} do
      {:ok, index_live, _html} = live(conn, ~p"/bookings")

      assert index_live |> element("a", "New Booking") |> render_click() =~
               "New Booking"

      assert_patch(index_live, ~p"/bookings/new")

      assert index_live
             |> form("#booking-form", booking: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#booking-form",
               booking: booking_attrs(user.id, place.id) |> Map.drop([:user_id, :place_id])
             )
             |> render_submit()

      assert_patch(index_live, ~p"/bookings")

      html = render(index_live)
      assert html =~ "Booking created successfully"
      assert html =~ "morning"
    end

    test "updates booking in listing", %{conn: conn, booking: booking} do
      {:ok, index_live, _html} = live(conn, ~p"/bookings")

      assert index_live |> element("#bookings-#{booking.id} a", "Edit") |> render_click() =~
               "Edit Booking"

      assert_patch(index_live, ~p"/bookings/#{booking}/edit")

      assert index_live
             |> form("#booking-form", booking: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#booking-form", booking: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/bookings")

      html = render(index_live)
      assert html =~ "Booking updated successfully"
      assert html =~ "afternoon"
    end

    test "deletes booking in listing", %{conn: conn, booking: booking} do
      {:ok, index_live, _html} = live(conn, ~p"/bookings")

      assert index_live |> element("#bookings-#{booking.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#bookings-#{booking.id}")
    end
  end

  describe "Show" do
    setup [:create_user, :create_place, :create_booking]

    test "displays booking", %{conn: conn, booking: booking} do
      {:ok, _show_live, html} = live(conn, ~p"/bookings/#{booking}")

      assert html =~ "Show Booking"
      assert html =~ "#{booking.slot}"
    end

    test "updates booking within modal", %{conn: conn, booking: booking} do
      {:ok, show_live, _html} = live(conn, ~p"/bookings/#{booking}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Booking"

      assert_patch(show_live, ~p"/bookings/#{booking}/show/edit")

      assert show_live
             |> form("#booking-form", booking: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#booking-form", booking: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/bookings/#{booking}")

      html = render(show_live)
      assert html =~ "Booking updated successfully"
      assert html =~ "afternoon"
    end
  end
end
