defmodule FosterShelterBigotitosWeb.AnimalView do
  use FosterShelterBigotitosWeb, :view
  alias FosterShelterBigotitosWeb.AnimalView

  def render("index.json", %{animals: animals}) do
    %{data: render_many(animals, AnimalView, "animal.json")}
  end

  def render("show.json", %{animal: animal}) do
    %{data: render_one(animal, AnimalView, "animal.json")}
  end

  def render("animal.json", %{animal: animal}) do
    %{
      id: animal.id,
      name: animal.name,
      species: animal.species,
      age: animal.age,
      customer_id: animal.customer_id
    }
  end
end
