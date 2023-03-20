defmodule SvoenixWeb.BookingLive.FormComponent do
  use SvoenixWeb, :live_component

  alias Svoenix.Bookings
  alias Svoenix.Bookings.Booking

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage booking records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="booking-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:place_id]} type="text" label="Place ID" />
        <.input field={@form[:user_id]} type="text" label="User ID" />
        <.input field={@form[:date]} type="date" label="Date" />
        <.input
          field={@form[:slots]}
          type="select"
          multiple
          options={Ecto.Enum.mappings(Booking, :slots)}
          label="Slots"
        />
        <:actions>
          <.button phx-disable-with="Saving...">Save Booking</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{booking: booking} = assigns, socket) do
    changeset = Bookings.change_booking(booking)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"booking" => booking_params}, socket) do
    changeset =
      socket.assigns.booking
      |> Bookings.change_booking(booking_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"booking" => booking_params}, socket) do
    save_booking(socket, socket.assigns.action, booking_params)
  end

  defp save_booking(socket, :edit, booking_params) do
    case Bookings.update_booking(socket.assigns.booking, booking_params) do
      {:ok, booking} ->
        notify_parent({:saved, booking})

        {:noreply,
         socket
         |> put_flash(:info, "Booking updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_booking(socket, :new, booking_params) do
    case Bookings.create_booking(booking_params) do
      {:ok, booking} ->
        notify_parent({:saved, booking})

        {:noreply,
         socket
         |> put_flash(:info, "Booking created successfully")
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
