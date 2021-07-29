# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :foster_shelter_bigotitos,
  ecto_repos: [FosterShelterBigotitos.Repo]

# Configures the endpoint
config :foster_shelter_bigotitos, FosterShelterBigotitosWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1gxjSa2fLON+PBMFl0jVr5Myj0e8oQaLmoPYfX8pNpsODld14hJndBUR7kIH6Z/x",
  render_errors: [
    view: FosterShelterBigotitosWeb.ErrorView,
    accepts: ~w(html json),
    layout: false
  ],
  pubsub_server: FosterShelterBigotitos.PubSub,
  live_view: [signing_salt: "2vpth/nB"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
