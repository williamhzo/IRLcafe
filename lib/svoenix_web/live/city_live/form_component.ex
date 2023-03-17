defmodule SvoenixWeb.CityLive.FormComponent do
  use SvoenixWeb, :live_component

  alias Svoenix.Cities

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage city records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="city-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:slug]} type="text" label="Slug" />
        <:actions>
          <.button phx-disable-with="Saving...">Save City</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{city: city} = assigns, socket) do
    changeset = Cities.change_city(city)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"city" => city_params}, socket) do
    changeset =
      socket.assigns.city
      |> Cities.change_city(city_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"city" => city_params}, socket) do
    save_city(socket, socket.assigns.action, city_params)
  end

  defp save_city(socket, :edit, city_params) do
    case Cities.update_city(socket.assigns.city, city_params) do
      {:ok, city} ->
        notify_parent({:saved, city})

        {:noreply,
         socket
         |> put_flash(:info, "City updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_city(socket, :new, city_params) do
    case Cities.create_city(city_params) do
      {:ok, city} ->
        notify_parent({:saved, city})

        {:noreply,
         socket
         |> put_flash(:info, "City created successfully")
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
