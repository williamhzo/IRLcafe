defmodule Svoenix.Places.Place do
  use Ecto.Schema
  import Ecto.Changeset

  alias Svoenix.Cities.City
  alias Svoenix.Bookings.Booking

  @derive {Jason.Encoder,
           only: [:id, :city_id, :slug, :label, :description, :img_url, :x, :y, :bookings]}
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

    # NOTE: on_conflict set for update_bookings bulk insert
    has_many :bookings, Booking, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(place, attrs) do
    place
    |> cast(attrs, [:city_id, :slug, :label, :description, :img_url, :x, :y])
    |> validate_required([:city_id, :slug, :label, :description, :x, :y])
  end
end
