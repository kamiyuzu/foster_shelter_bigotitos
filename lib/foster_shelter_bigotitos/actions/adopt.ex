defmodule FosterShelterBigotitos.Actions.Adopt do

  alias FosterShelterBigotitos.Repo
  alias FosterShelterBigotitos.Customers
  alias FosterShelterBigotitos.Animals
  alias FosterShelterBigotitos.Animals.Animal

  def call(adopt_params) do
    {animal_id, update_attrs, customer_email} = parse_params(adopt_params)
    animal = animal_id |> Animals.get_animal!() |> Repo.preload([:customer])
    customer = Customers.get_customer_by_email(customer_email)
    animal_changeset = Ecto.Changeset.cast(%Animal{}, update_attrs, [:name, :species, :age])

    updated_animal =
      animal
      |> Ecto.Changeset.change(animal_changeset.changes)
      |> Ecto.Changeset.put_assoc(:customer, customer)
      |> Repo.update()

      with %Customers.Customer{} <- customer,
         {:ok, %Animal{} = animal} <- updated_animal do
      animal
    end
  end

  defp parse_params(adopt_params) do
    %{"id" => animal_id, "animal" => update_attrs, "customer_email" => customer_email} = adopt_params
    {animal_id, update_attrs, customer_email}
  end
end
