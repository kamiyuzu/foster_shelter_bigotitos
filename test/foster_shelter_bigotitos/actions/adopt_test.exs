defmodule FosterShelterBigotitos.Actions.AdoptTest do
  use FosterShelterBigotitos.DataCase

  alias FosterShelterBigotitos.Actions.Adopt
  alias FosterShelterBigotitos.Animals.Animal
  alias FosterShelterBigotitos.Actions.Adopt.Mocks

  @update_attrs %{
    age: 43,
    name: "some updated name",
    species: "some updated species"
  }

  describe "call/1" do
    setup do
      %{
        adopt_params: %{"id" => 1, "animal" => @update_attrs, "customer_email" => "some email"},
        custom_opts: [animals: Mocks.Animals]
      }
    end

    test "customer_email doesnt exist", %{adopt_params: adopt_params, custom_opts: custom_opts} do
      non_valid_email_params = %{adopt_params | "customer_email" => "non_valid"}
      testing_opts = custom_opts ++ [repo: Mocks.RepoError, customers: Mocks.CustomersError]

      expected_response = nil
      assert Adopt.call(non_valid_email_params, testing_opts) == expected_response
    end

    test "valid params", %{adopt_params: adopt_params, custom_opts: custom_opts} do
      testing_opts = custom_opts ++ [repo: Mocks.RepoOk, customers: Mocks.CustomersOk]

      animal = Adopt.call(adopt_params, testing_opts)
      assert %Animal{} = animal
      expected_age = 43
      assert animal.age == expected_age
      expected_name = "some updated name"
      assert animal.name == expected_name
      expected_species = "some updated species"
      assert animal.species == expected_species
    end
  end
end
