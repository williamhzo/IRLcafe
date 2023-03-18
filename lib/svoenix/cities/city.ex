defmodule Svoenix.Cities.City do
  use Ecto.Schema
  import Ecto.Changeset

  alias Svoenix.Places.Place

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "cities" do
    field :name, :string
    field :slug, :string

    has_many :places, Place

    timestamps()
  end

  @doc false
  def changeset(city, attrs) do
    city
    |> cast(attrs, [:name, :slug])
    |> validate_required([:name, :slug])
    |> unique_constraint(:name)
    |> unique_constraint(:slug)
  end
end
