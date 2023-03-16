defmodule SvoenixWeb.HomeLive do
  use SvoenixWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="flex flex-col space-y-8">
      <h1 class="font-bold text-2xl">Welcome</h1>

      <LiveSvelte.render name="Example" props={%{number: @number}} />
    </div>
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
