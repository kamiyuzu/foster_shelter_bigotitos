defmodule FosterShelterBigotitosWeb.AnimalControllerTest do
  use FosterShelterBigotitosWeb.ConnCase

  alias FosterShelterBigotitos.Animals
  alias FosterShelterBigotitos.Animals.Animal

  @create_attrs %{
    age: 42,
    name: "some name",
    species: "some species"
  }
  @update_attrs %{
    age: 43,
    name: "some updated name",
    species: "some updated species"
  }
  @invalid_attrs %{age: nil, name: nil, species: nil}

  def fixture(:animal) do
    {:ok, animal} = Animals.create_animal(@create_attrs)
    animal
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all animals", %{conn: conn} do
      conn = get(conn, Routes.animal_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create animal" do
    test "renders animal when data is valid", %{conn: conn} do
      conn = post(conn, Routes.animal_path(conn, :create), animal: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.animal_path(conn, :show, id))

      assert %{
               "id" => id,
               "age" => 42,
               "name" => "some name",
               "species" => "some species"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.animal_path(conn, :create), animal: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete animal" do
    setup [:create_animal]

    test "deletes chosen animal", %{conn: conn, animal: animal} do
      conn = delete(conn, Routes.animal_path(conn, :delete, animal))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.animal_path(conn, :show, animal))
      end
    end
  end

  defp create_animal(_) do
    animal = fixture(:animal)
    %{animal: animal}
  end
end
