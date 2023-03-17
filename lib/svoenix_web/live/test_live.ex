defmodule SvoenixWeb.TestLive do
  use SvoenixWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        page_title: "Page title",
        count: 0
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1><%= @page_title %></h1>
    <button phx-click="increment">Click me</button>
    <p>Count: <%= @count %></p>
    """
  end

  def handle_event("increment", _params, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end
end
