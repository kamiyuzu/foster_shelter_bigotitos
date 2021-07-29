defmodule FosterShelterBigotitos.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :name, :string
      add :last_name, :string
      add :address, :string
      add :phone_number, :string
      add :email, :string
      add :age, :integer

      timestamps()
    end

    create unique_index(:customers, [:email])
  end
end
