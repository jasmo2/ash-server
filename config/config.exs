# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ash_server,
  namespace: AshServer,
  ecto_repos: [AshServer.Repo]

# Configures the endpoint
config :ash_server, AshServerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "A24l/9hCJ5nTx5kfO1S3sEQzEXmT6AZW2MEhIVZN6tmAafuJeP9Lm6JiLY/VJL8n",
  render_errors: [view: AshServerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: AshServer.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Authorization with Pow
config :ash_server, :pow,
  user: AshServer.Accounts.User,
  repo: AshServer.Repo

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
