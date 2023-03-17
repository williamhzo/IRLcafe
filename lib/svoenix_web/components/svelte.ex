defmodule SvoenixWeb.Components.Svelte do
  use SvoenixWeb, :live_component

  attr :id, :string, required: true
  attr :name, :string, required: true
  attr :props, :map, default: %{}
  attr :class, :string, default: nil

  def render(assigns) do
    ~H"""
    <div
      id={@id || @name}
      data-name={@name}
      data-props={json(@props)}
      phx-update="ignore"
      phx-hook="SvelteHook"
      class={@class}
    />
    """
  end

  ### Helpers

  defp json(nil), do: ""
  defp json(props), do: Jason.encode!(props)
end
