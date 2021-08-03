defmodule FosterShelterBigotitos.Actions.AdoptTest do
  use FosterShelterBigotitos.DataCase

  alias FosterShelterBigotitos.Actions.Adopt
  alias FosterShelterBigotitos.Customers
  alias FosterShelterBigotitos.Animals
  alias FosterShelterBigotitos.Animals.Animal

  @create_attrs %{
    age: 42,
    name: "some name",
    species: "some species"
  }
  @create_customer_attrs %{
    address: "some address",
    age: 42,
    email: "some email",
    last_name: "some last_name",
    name: "some name",
    phone_number: "some phone_number"
  }
  @update_attrs %{
    age: 43,
    name: "some updated name",
    species: "some updated species"
  }

  describe "call/1" do
    setup do
      %{animal: animal, customer: customer} = create_fixtures()
      %{adopt_params: %{"id" => animal.id, "animal"=> @update_attrs, "customer_email" => customer.email}}
    end

    test "customer_email doesnt exist", %{adopt_params: adopt_params} do
      non_valid_email_params = %{adopt_params | "customer_email" => "non_valid"}
      expected_response = nil
      assert Adopt.call(non_valid_email_params) == expected_response
    end

    test "valid params", %{adopt_params: adopt_params} do
      animal = Adopt.call(adopt_params)
      assert %Animal{} = animal
      expected_age = 43
      assert animal.age == expected_age
      expected_name = "some updated name"
      assert animal.name == expected_name
      expected_species = "some updated species"
      assert animal.species == expected_species
    end
  end

  defp create_fixtures do
    {animal, customer} = fixtures()
    %{animal: animal, customer: customer}
  end

  defp fixtures do
    {:ok, customer} = Customers.create_customer(@create_customer_attrs)
    {:ok, animal} = Animals.create_animal(@create_attrs)
    {animal, customer}
  end
end
