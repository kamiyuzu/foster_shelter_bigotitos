defmodule FosterShelterBigotitos.Customers.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  alias FosterShelterBigotitos.Animals.Animal

  schema "customers" do
    field :address, :string
    field :age, :integer
    field :email, :string
    field :last_name, :string
    field :name, :string
    field :phone_number, :string
    has_many :animals, Animal

    timestamps()
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:name, :last_name, :address, :phone_number, :email, :age])
    |> validate_required([:name, :last_name, :address, :phone_number, :email, :age])
    |> unique_constraint(:email)
  end
end
