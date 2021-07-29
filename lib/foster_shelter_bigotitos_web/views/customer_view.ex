defmodule FosterShelterBigotitosWeb.CustomerView do
  use FosterShelterBigotitosWeb, :view
  alias FosterShelterBigotitosWeb.CustomerView

  def render("index.json", %{customers: customers}) do
    %{data: render_many(customers, CustomerView, "customer.json")}
  end

  def render("show.json", %{customer: customer}) do
    %{data: render_one(customer, CustomerView, "customer.json")}
  end

  def render("customer.json", %{customer: customer}) do
    %{id: customer.id,
      name: customer.name,
      last_name: customer.last_name,
      address: customer.address,
      phone_number: customer.phone_number,
      email: customer.email,
      age: customer.age}
  end
end
