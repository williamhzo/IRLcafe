defmodule Svoenix.Repo.Migrations.AddPlaceSlug do
  use Ecto.Migration

  def change do
    alter table(:places) do
      add :slug, :string, null: false
    end

    create unique_index(:places, [:slug])
  end
end
