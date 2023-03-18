defmodule Svoenix.Repo.Migrations.CreateBookings do
  use Ecto.Migration

  def change do
    create table(:bookings, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :user, references(:users, on_delete: :nothing, type: :binary_id)
      add :place, references(:places, on_delete: :nothing, type: :binary_id)

      add :date, :date, null: false
      add :slot, :string, null: false

      timestamps()
    end

    create index(:bookings, [:user])
    create index(:bookings, [:place])
    create index(:bookings, [:date, :slot])

    create unique_index(:bookings, [:user, :place, :date, :slot])
  end
end
