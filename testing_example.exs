defmodule FosterShelterBigotitosWeb.AnimalController1Test do
  use FosterShelterBigotitosWeb.ConnCase

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
  @invalid_attrs %{age: nil, name: nil, species: nil}

  def fixture(:fixtures) do
    {:ok, customer} = Customers.create_customer(@create_customer_attrs)
    {:ok, animal} = Animals.create_animal(@create_attrs)
    {animal, customer}
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "update animal" do
    setup [:create_fixtures]

    test "renders animal when data is valid", %{conn: conn, animal: %Animal{id: id} = animal, customer: customer} do
      conn = put(conn, Routes.animal_path(conn, :update, animal), animal: @update_attrs, customer_email: customer.email)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.animal_path(conn, :show, id))

      assert %{
               "id" => _id,
               "age" => 43,
               "name" => "some updated name",
               "species" => "some updated species"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, animal: animal} do
      conn = put(conn, Routes.animal_path(conn, :update, animal), animal: @invalid_attrs, customer_email: nil)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_fixtures(_) do
    {animal, customer} = fixture(:fixtures)
    %{animal: animal, customer: customer}
  end
end
