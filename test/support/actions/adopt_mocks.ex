defmodule FosterShelterBigotitos.Actions.Adopt.Mocks.CustomersOk do
  alias FosterShelterBigotitos.Customers.Customer

  def get_customer_by_email(_email) do
    %Customer{
      address: "some address",
      age: 42,
      email: "some email",
      id: 1,
      inserted_at: ~N[2021-08-04 17:45:56],
      last_name: "some last_name",
      name: "some name",
      phone_number: "some phone_number",
      updated_at: ~N[2021-08-04 17:45:56]
    }
  end
end

defmodule FosterShelterBigotitos.Actions.Adopt.Mocks.CustomersError do
  def get_customer_by_email(_email) do
    nil
  end
end

defmodule FosterShelterBigotitos.Actions.Adopt.Mocks.Animals do
  alias FosterShelterBigotitos.Animals.Animal

  def get_animal!(_params) do
    %Animal{
      age: 43,
      customer_id: nil,
      id: 1,
      inserted_at: ~N[2021-08-04 17:41:40],
      name: "some name",
      species: "some species",
      updated_at: ~N[2021-08-04 17:41:40]
    }
  end
end

defmodule FosterShelterBigotitos.Actions.Adopt.Mocks.RepoError do
  alias FosterShelterBigotitos.Animals.Animal

  def preload(_animal, [:customer]) do
    %Animal{
      age: 43,
      customer: nil,
      customer_id: nil,
      id: 1,
      inserted_at: ~N[2021-08-04 17:41:40],
      name: "some name",
      species: "some species",
      updated_at: ~N[2021-08-04 17:41:40]
    }
  end

  def update(_params) do
    {:ok,
     %Animal{
       age: 43,
       customer: nil,
       customer_id: nil,
       id: 1,
       inserted_at: ~N[2021-08-04 17:45:26],
       name: "some name",
       species: "some species",
       updated_at: ~N[2021-08-04 17:45:31]
     }}
  end
end

defmodule FosterShelterBigotitos.Actions.Adopt.Mocks.RepoOk do
  alias FosterShelterBigotitos.Customers.Customer
  alias FosterShelterBigotitos.Animals.Animal

  def preload(_animal, [:customer]) do
    %Animal{
      age: 43,
      customer: %Customer{
        address: "some address",
        age: 42,
        email: "some email",
        id: 1,
        inserted_at: ~N[2021-08-04 17:45:56],
        last_name: "some last_name",
        name: "some name",
        phone_number: "some phone_number",
        updated_at: ~N[2021-08-04 17:45:56]
      },
      customer_id: 1,
      id: 1,
      inserted_at: ~N[2021-08-04 17:45:56],
      name: "some name",
      species: "some species",
      updated_at: ~N[2021-08-04 17:45:31]
    }
  end

  def update(_params) do
    {:ok,
     %Animal{
       age: 43,
       customer: %Customer{
         address: "some address",
         age: 42,
         email: "some email",
         id: 1,
         inserted_at: ~N[2021-08-04 17:45:56],
         last_name: "some last_name",
         name: "some name",
         phone_number: "some phone_number",
         updated_at: ~N[2021-08-04 17:45:56]
       },
       customer_id: 1,
       id: 1,
       inserted_at: ~N[2021-08-04 17:45:56],
       name: "some updated name",
       species: "some updated species",
       updated_at: ~N[2021-08-04 17:46:04]
     }}
  end
end
