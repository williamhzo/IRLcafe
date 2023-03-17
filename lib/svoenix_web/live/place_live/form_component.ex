defmodule SvoenixWeb.PlaceLive.FormComponent do
  use SvoenixWeb, :live_component

  alias Svoenix.Places

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage place records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="place-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:label]} type="text" label="Label" />
        <.input field={@form[:x]} type="text" label="X" />
        <.input field={@form[:y]} type="text" label="Y" />
        <.input field={@form[:city]} type="text" label="City" />
        <.input field={@form[:description]} type="text" label="Description" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Place</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{place: place} = assigns, socket) do
    changeset = Places.change_place(place)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"place" => place_params}, socket) do
    changeset =
      socket.assigns.place
      |> Places.change_place(place_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"place" => place_params}, socket) do
    save_place(socket, socket.assigns.action, place_params)
  end

  defp save_place(socket, :edit, place_params) do
    case Places.update_place(socket.assigns.place, place_params) do
      {:ok, place} ->
        notify_parent({:saved, place})

        {:noreply,
         socket
         |> put_flash(:info, "Place updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_place(socket, :new, place_params) do
    case Places.create_place(place_params) do
      {:ok, place} ->
        notify_parent({:saved, place})

        {:noreply,
         socket
         |> put_flash(:info, "Place created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
