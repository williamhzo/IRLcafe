defmodule Svoenix.Places.Place do
  use Ecto.Schema
  import Ecto.Changeset

  alias Svoenix.Cities.City
  alias Svoenix.Bookings.Booking

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "places" do
    belongs_to :city, City

    field :slug, :string
    field :label, :string
    field :description, :string
    field :img_url, :string

    field :x, :string
    field :y, :string

    has_many :bookings, Booking

    timestamps()
  end

  @doc false
  def changeset(place, attrs) do
    place
    |> cast(attrs, [:city_id, :slug, :label, :description, :img_url, :x, :y])
    |> validate_required([:city_id, :slug, :label, :description, :x, :y])
  end
end
