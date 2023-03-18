defmodule SvoenixWeb.Header do
  use SvoenixWeb, :html

  alias Svoenix.Cities.City

  attr :city, City, default: nil

  def render(assigns) do
    ~H"""
    <header class="h-[52px] bg-opacity-[0.75] sticky top-0 z-20 flex items-center border-b border-gray-100 bg-white px-4 backdrop-blur-lg">
      <div class="w-main-content mx-auto flex items-center justify-between">
        <.link class="text-lg font-bold hover:text-gray-700" navigate={~p"/"}>
          IRLcafé
        </.link>

        <.link :if={@city} navigate={"/#{@city.slug}"} class="font-semibold hover:text-gray-700">
          <%= @city.name %>
        </.link>
      </div>
    </header>
    """
  end
end
