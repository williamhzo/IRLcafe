defmodule Svoenix.Places.Place do
  use Ecto.Schema
  import Ecto.Changeset

  alias Svoenix.Bookings.Booking

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "places" do
    field :city, :string

    field :slug, :string
    field :label, :string
    field :description, :string

    field :x, :string
    field :y, :string

    has_many :bookings, Booking

    timestamps()
  end

  @doc false
  def changeset(place, attrs) do
    place
    |> cast(attrs, [:city, :slug, :label, :description, :x, :y])
    |> validate_required([:city, :slug, :label, :description, :x, :y])
  end
end
