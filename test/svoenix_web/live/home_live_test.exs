defmodule SvoenixWeb.HomeLiveTest do
  use SvoenixWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "/", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")
    assert has_element?(view, "h1", "Welcome")
  end
end
