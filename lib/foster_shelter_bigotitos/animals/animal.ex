defmodule FosterShelterBigotitos.Animals.Animal do
  use Ecto.Schema
  import Ecto.Changeset

  alias FosterShelterBigotitos.Customers.Customer

  @derive {Jason.Encoder, only: [:name, :age, :species, :customer_id]}
  schema "animals" do
    field :age, :integer
    field :name, :string
    field :species, :string
    belongs_to :customer, Customer, on_replace: :nilify

    timestamps()
  end

  @doc false
  def changeset(animal, attrs) do
    animal
    |> cast(attrs, [:name, :species, :age])
    |> validate_required([:name, :species, :age])
  end
end
