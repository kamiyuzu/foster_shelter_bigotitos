defmodule FosterShelterBigotitos.CustomersTest do
  use FosterShelterBigotitos.DataCase

  alias FosterShelterBigotitos.Customers

  describe "customers" do
    alias FosterShelterBigotitos.Customers.Customer

    @valid_attrs %{
      address: "some address",
      age: 42,
      email: "some email",
      last_name: "some last_name",
      name: "some name",
      phone_number: "some phone_number"
    }
    @update_attrs %{
      address: "some updated address",
      age: 43,
      email: "some updated email",
      last_name: "some updated last_name",
      name: "some updated name",
      phone_number: "some updated phone_number"
    }
    @invalid_attrs %{
      address: nil,
      age: nil,
      email: nil,
      last_name: nil,
      name: nil,
      phone_number: nil
    }

    def customer_fixture(attrs \\ %{}) do
      {:ok, customer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Customers.create_customer()

      customer
    end

    test "list_customers/0 returns all customers" do
      customer = customer_fixture()
      assert Customers.list_customers() == [customer]
    end

    test "get_customer!/1 returns the customer with given id" do
      customer = customer_fixture()
      assert Customers.get_customer!(customer.id) == customer
    end

    test "create_customer/1 with valid data creates a customer" do
      assert {:ok, %Customer{} = customer} = Customers.create_customer(@valid_attrs)
      assert customer.address == "some address"
      assert customer.age == 42
      assert customer.email == "some email"
      assert customer.last_name == "some last_name"
      assert customer.name == "some name"
      assert customer.phone_number == "some phone_number"
    end

    test "create_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Customers.create_customer(@invalid_attrs)
    end

    test "update_customer/2 with valid data updates the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{} = customer} = Customers.update_customer(customer, @update_attrs)
      assert customer.address == "some updated address"
      assert customer.age == 43
      assert customer.email == "some updated email"
      assert customer.last_name == "some updated last_name"
      assert customer.name == "some updated name"
      assert customer.phone_number == "some updated phone_number"
    end

    test "update_customer/2 with invalid data returns error changeset" do
      customer = customer_fixture()
      assert {:error, %Ecto.Changeset{}} = Customers.update_customer(customer, @invalid_attrs)
      assert customer == Customers.get_customer!(customer.id)
    end

    test "delete_customer/1 deletes the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{}} = Customers.delete_customer(customer)
      assert_raise Ecto.NoResultsError, fn -> Customers.get_customer!(customer.id) end
    end

    test "change_customer/1 returns a customer changeset" do
      customer = customer_fixture()
      assert %Ecto.Changeset{} = Customers.change_customer(customer)
    end
  end
end
