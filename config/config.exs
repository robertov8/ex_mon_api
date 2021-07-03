# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ex_mon,
  ecto_repos: [ExMon.Repo]

# Configures the endpoint
config :ex_mon, ExMonWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "tYHlrK8IWM6cOGQOyD44dEXP/mqMx1j2uzoH4OSbkEtwTSMzX6Ap9AAec3DSgmTu",
  render_errors: [view: ExMonWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ExMon.PubSub,
  live_view: [signing_salt: "e06KhPWU"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ex_mon, ExMonWeb.Auth.Guardian,
  issuer: "ex_mon",
  secret_key: "hkZPs7MwpQJBWhhxuFfx6slLL6mcrHgIgMni1D39nAzh74Jwr6GHBK/iHAYMRLow"

config :ex_mon, ExMonWeb.Auth.Pipeline,
  module: ExMonWeb.Auth.Guardian,
  error_handler: ExMonWeb.Auth.ErrorHandler

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
