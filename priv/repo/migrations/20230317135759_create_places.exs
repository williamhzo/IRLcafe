defmodule Svoenix.Repo.Migrations.CreatePlaces do
  use Ecto.Migration

  def change do
    create table(:places, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :label, :string
      add :description, :text

      add :x, :string
      add :y, :string

      timestamps()
    end
  end
end
