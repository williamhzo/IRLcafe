defmodule Svoenix.Bookings.Booking do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "bookings" do
    field :user, :binary_id
    field :place, :binary_id

    field :date, :date
    field :slot, Ecto.Enum, values: [:morning, :lunch, :afternoon, :afterwork]

    timestamps()
  end

  @doc false
  def changeset(booking, attrs) do
    booking
    |> cast(attrs, [:date, :slot])
    |> validate_required([:date, :slot])
    |> unique_constraint([:user, :place, :date, :slot])
  end
end
