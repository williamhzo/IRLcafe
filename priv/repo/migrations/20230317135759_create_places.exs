defmodule Svoenix.Repo.Migrations.CreatePlaces do
  use Ecto.Migration

  def change do
    create table(:places, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :label, :string
      add :x, :string
      add :y, :string
      add :city, :string
      add :description, :text

      timestamps()
    end
  end
end
