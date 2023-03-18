defmodule SvoenixWeb.PlaceLive do
  use SvoenixWeb, :live_view

  alias Svoenix.Cities
  alias Svoenix.Places

  def render(assigns) do
    ~H"""
    <section class="flex flex-col items-center gap-5 py-8 md:gap-12 md:py-16 md:px-8">
      <p><%= @place.label %></p>
      <p><%= @place.description %></p>
      <img src={@place.img_url} alt="some picture" class="rounded-2xl" />
    </section>
    """
  end

  ### Server

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(
        %{"city_slug" => city_slug, "place_slug" => place_slug} = _params,
        _url,
        socket
      ) do
    socket =
      assign(socket,
        city: Cities.get_city_by_slug!(city_slug),
        place: Places.get_place_by_slug!(place_slug)
      )

    {:noreply, socket}
  end
end
