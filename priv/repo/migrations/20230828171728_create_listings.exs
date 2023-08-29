defmodule Alquimia.Repo.Migrations.CreateListings do
  use Ecto.Migration

  def change do
    create table(:listings) do
      add :title, :string
      add :description, :text
      add :price, :decimal
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:listings, [:user_id])
  end
end
