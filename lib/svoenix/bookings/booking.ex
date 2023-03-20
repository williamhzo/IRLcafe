defmodule Svoenix.Bookings.Booking do
  use Ecto.Schema
  import Ecto.Changeset

  alias Svoenix.Places.Place
  alias Svoenix.Accounts.User

  @derive {Jason.Encoder, only: [:id, :user_id, :place_id, :date, :slots]}
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "bookings" do
    belongs_to :user, User
    belongs_to :place, Place

    field :date, :date
    field :slots, {:array, Ecto.Enum}, values: [:morning, :lunch, :afternoon, :afterwork]

    timestamps()
  end

  @doc false
  def changeset(booking, attrs) do
    booking
    |> cast(attrs, [:user_id, :place_id, :date, :slots])
    |> validate_required([:user_id, :place_id, :date, :slots])
    |> unique_constraint([:user_id, :place_id, :date])
  end
end
