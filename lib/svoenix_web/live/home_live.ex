defmodule SvoenixWeb.HomeLive do
  use SvoenixWeb, :live_view

  alias Svoenix.Cities
  alias Svoenix.Cities.City

  def render(assigns) do
    ~H"""
    <section class="flex flex-col items-center gap-12 px-4 py-12 container">
      <header class="flex flex-col gap-1 items-center">
        <h1 class="tracking widest text-3xl font-semibold">IRL.café</h1>
        <h2 class="text-lg text-slate-500">find the best spots near you</h2>
      </header>

      <.simple_form for={@form} id="city-form" phx-submit="save">
        <.input field={@form[:name]} type="text" label="Name" />

        <:actions>
          <.button phx-disable-with="Saving...">Next</.button>
        </:actions>
      </.simple_form>
    </section>
    """
  end

  ### Server

  def mount(_params, _session, socket) do
    socket = assign(socket, :form, to_form(%{"name" => nil}))
    {:ok, socket}
  end

  def handle_event("save", %{"name" => name}, socket) do
    case name |> String.capitalize() |> get_city() do
      nil -> {:noreply, socket}
      %City{slug: slug} -> {:noreply, push_navigate(socket, to: ~p"/city/#{slug}")}
    end
  end

  ### Helpers

  defp get_city(name) do
    Cities.get_city_by_name(name)
  end
end
