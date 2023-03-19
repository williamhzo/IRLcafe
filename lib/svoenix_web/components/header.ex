defmodule SvoenixWeb.Header do
  use SvoenixWeb, :html

  alias Svoenix.Cities.City
  alias Svoenix.Accounts.User

  attr :current_user, User, default: nil
  attr :city, City, default: nil

  def render(assigns) do
    ~H"""
    <header class="bg-opacity-[0.75] py-2 sticky top-0 z-20 flex items-center border-b border-gray-100 bg-white px-4 backdrop-blur-lg">
      <div class="w-main-content mx-auto flex items-center justify-between">
        <.link class="text-lg font-bold hover:text-brand-text-hover" navigate={~p"/"}>
          IRL café 👨‍💻☕
        </.link>

        <.link
          :if={@current_user}
          class="py-2 px-2 text-dark-700 select-none"
          href={~p"/log_out"}
          method="delete"
        >
          Log out
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
