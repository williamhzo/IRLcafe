defmodule Svoenix.Repo.Migrations.AddPlaceImgUrl do
  use Ecto.Migration

  def change do
    alter table(:places) do
      add :img_url, :string, null: true
    end
  end
end
