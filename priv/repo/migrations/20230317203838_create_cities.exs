defmodule Svoenix.Repo.Migrations.CreateCities do
  use Ecto.Migration

  def change do
    create table(:cities, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :slug, :string, null: false

      timestamps()
    end

    create unique_index(:cities, [:name])
    create unique_index(:cities, [:slug])

    alter table(:places) do
      add :city_id, references(:cities, on_delete: :nothing, type: :binary_id)
    end
  end
end
