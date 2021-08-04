defmodule FosterShelterBigotitos.Actions.Adopt do

  alias FosterShelterBigotitos.Repo
  alias FosterShelterBigotitos.Customers
  alias FosterShelterBigotitos.Customers.Customer
  alias FosterShelterBigotitos.Animals
  alias FosterShelterBigotitos.Animals.Animal

  def call(adopt_params, opts \\ []) do
    {animals_module, customers_module, repo_module} = required_modules(opts)
    {animal_id, update_attrs, customer_email} = parse_params(adopt_params)
    animal = animal_id |> animals_module.get_animal!() |> repo_module.preload([:customer])
    customer = customers_module.get_customer_by_email(customer_email)
    animal_changeset = Ecto.Changeset.cast(%Animal{}, update_attrs, [:name, :species, :age])

    updated_animal =
      animal
      |> Ecto.Changeset.change(animal_changeset.changes)
      |> Ecto.Changeset.put_assoc(:customer, customer)
      |> repo_module.update()

      with %Customer{} <- customer,
         {:ok, %Animal{} = animal} <- updated_animal do
      animal
    end
  end

  defp parse_params(adopt_params) do
    %{"id" => animal_id, "animal" => update_attrs, "customer_email" => customer_email} = adopt_params
    {animal_id, update_attrs, customer_email}
  end

  defp required_modules(opts) do
    animals_module = Keyword.get(opts, :animals, Animals)
    customers_module = Keyword.get(opts, :customers, Customers)
    repo_module = Keyword.get(opts, :repo, Repo)
    {animals_module, customers_module, repo_module}
  end
end
