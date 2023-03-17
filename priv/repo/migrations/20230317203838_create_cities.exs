defmodule Svoenix.Repo.Migrations.CreateCities do
  use Ecto.Migration

  def change do
    create table(:cities, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, unique: true
      add :slug, :string, unique: true

      timestamps()
    end
  end
end
