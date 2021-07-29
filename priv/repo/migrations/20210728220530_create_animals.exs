defmodule FosterShelterBigotitos.Repo.Migrations.CreateAnimals do
  use Ecto.Migration

  def change do
    create table(:animals) do
      add :name, :string
      add :species, :string
      add :age, :integer
      add :customer_id, references(:customers, on_delete: :nothing)

      timestamps()
    end

    create index(:animals, [:customer_id])
  end
end
