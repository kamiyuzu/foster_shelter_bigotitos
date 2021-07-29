defmodule FosterShelterBigotitosWeb.AnimalController do
  use FosterShelterBigotitosWeb, :controller

  alias FosterShelterBigotitos.Repo
  alias FosterShelterBigotitos.Customers
  alias FosterShelterBigotitos.Animals
  alias FosterShelterBigotitos.Animals.Animal

  action_fallback FosterShelterBigotitosWeb.FallbackController

  def index(conn, _params) do
    animals = Animals.list_animals()
    render(conn, "index.json", animals: animals)
  end

  def create(conn, %{"animal" => animal_params}) do
    with {:ok, %Animal{} = animal} <- Animals.create_animal(animal_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.animal_path(conn, :show, animal))
      |> render("show.json", animal: animal)
    end
  end

  def show(conn, %{"id" => id}) do
    animal = Animals.get_animal!(id)
    render(conn, "show.json", animal: animal)
  end

  def update(conn, %{"id" => id, "animal" => animal_params, "customer_email" => email}) do
    animal = id |> Animals.get_animal!() |> Repo.preload([:customer])
    customer = Customers.get_customer_by_email!(email)
    animal_changeset = Animal.changeset(%Animal{}, animal_params)
    updated_animal = animal
      |> Ecto.Changeset.change(animal_changeset.changes)
      |> Ecto.Changeset.put_assoc(:customer, customer)
      |> Repo.update!()

    with {:ok, %Animal{} = animal} <- updated_animal do
      render(conn, "show.json", animal: animal)
    end
  end

  def delete(conn, %{"id" => id}) do
    animal = Animals.get_animal!(id)

    with {:ok, %Animal{}} <- Animals.delete_animal(animal) do
      send_resp(conn, :no_content, "")
    end
  end
end
