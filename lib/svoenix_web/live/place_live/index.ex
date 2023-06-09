defmodule SvoenixWeb.PlaceLive.Index do
  use SvoenixWeb, :live_view

  alias Svoenix.Cities
  alias Svoenix.Places
  alias Svoenix.Places.Place

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :places, Places.list_places())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id} = _params) do
    socket
    |> assign(:page_title, "Edit Place")
    |> assign(:city, nil)
    |> assign(:place, Places.get_place!(id))
  end

  defp apply_action(socket, :new, %{"city_slug" => city_slug} = _params) do
    socket
    |> assign(:page_title, "New Place")
    |> assign(:city, Cities.get_city_by_slug!(city_slug))
    |> assign(:place, %Place{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Places")
    |> assign(:city, nil)
    |> assign(:place, nil)
  end

  @impl true
  def handle_info({SvoenixWeb.PlaceLive.FormComponent, {:saved, place}}, socket) do
    {:noreply, stream_insert(socket, :places, place)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    place = Places.get_place!(id)
    {:ok, _} = Places.delete_place(place)

    {:noreply, stream_delete(socket, :places, place)}
  end
end
