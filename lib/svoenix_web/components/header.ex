defmodule SvoenixWeb.Header do
  use SvoenixWeb, :html

  alias Svoenix.Cities.City

  attr(:city, City, default: nil)

  def render(assigns) do
    ~H"""
    <header class="bg-opacity-[0.75] py-2 sticky top-0 z-20 flex items-center border-b border-gray-100 bg-white px-4 backdrop-blur-lg">
      <div class="w-main-content mx-auto flex items-center justify-between">
        <.link class="text-lg font-bold hover:text-brand-text-hover" navigate={~p"/"}>
          IRL café 👨‍💻☕
        </.link>

        <div :if={@city} class="flex flex-col items-end">
          <small class="text-muted">city</small>

          <.link navigate={"/#{@city.slug}"} class="font-semibold hover:text-brand-text-hover">
            <%= @city.name %>
          </.link>
        </div>
      </div>
    </header>
    """
  end
end
