defmodule SvoenixWeb.CityLive.Show do
  use SvoenixWeb, :live_view

  alias Svoenix.Cities

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"slug" => slug}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:city, Cities.get_city_by_slug!(slug))}
  end

  defp page_title(:show), do: "Show City"
  defp page_title(:edit), do: "Edit City"
end
