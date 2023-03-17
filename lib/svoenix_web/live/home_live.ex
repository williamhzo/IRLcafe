defmodule SvoenixWeb.HomeLive do
  use SvoenixWeb, :live_view

  alias SvoenixWeb.Components.Svelte

  def render(assigns) do
    ~H"""
    <Svelte.render id="example-svelte" name="Example" />
    """
  end

  def handle_event("set_number", %{"number" => number}, socket) do
    {:noreply, assign(socket, :number, number)}
  end

  def mount(_params, _session, socket) do
    socket = assign(socket, :number, 0)
    {:ok, socket}
  end
end
