defmodule FosterShelterBigotitosWeb.PageController do
  use FosterShelterBigotitosWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
