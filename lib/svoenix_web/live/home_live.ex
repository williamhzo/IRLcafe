defmodule SvoenixWeb.HomeLive do
  use SvoenixWeb, :live_view

  alias SvoenixWeb.Components.Svelte

  def render(assigns) do
    ~H"""
    <section class="flex flex-col items-center gap-12 px-4 py-12 container">
      <header class="flex flex-col gap-1 items-center">
        <h1 class="tracking widest text-3xl font-semibold">coffree</h1>
        <h2 class="text-lg text-slate-500">find the best spots near you</h2>
      </header>

      <form for={@form} phx-submit="update_city">
        <label for={@form}>
          <input
            field={@form[:city]}
            type="text"
            placeholder="Lisbon, Portugal"
            label="City"
            autocomplete="new-password"
          />
        </label>

        <button type="submit">find some spots</button>
      </form>
    </section>
    """
  end

  def mount(_params, _session, socket) do
    socket = assign(socket, city_form: %{}, toForm(:city_form))

    {:ok, socket}
  end
end
