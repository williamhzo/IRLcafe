defmodule SvoenixWeb.AppLive do
  use SvoenixWeb, :live_view

  alias Svoenix.Cities
  alias Svoenix.Places

  def render(assigns) do
    ~H"""

    <section class="container flex flex-col">

    <h1 class="text-brand font-bold"><%= @city.name %></h1>


    <ul>
    <li :for={place <- @places}>
    <%= place.label %>
    </li>
    </ul>
    </section>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"slug" => slug} = _params, _url, socket) do
    socket =
      assign(socket,
        city: Cities.get_city_by_slug!(slug),
        places: Places.list_places() |> Enum.filter(&(&1.city == slug))
      )

    {:noreply, socket}
  end
end
