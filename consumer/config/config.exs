# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :consumer,
  ecto_repos: [Consumer.Repo]

# Configures the endpoint
config :consumer, ConsumerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1hZDuS7Q3+pqA4xGWq9DJMtJzh8HCZimmEwbfTGMKfr3FtttQMz/zkttYLHSoH+h",
  render_errors: [view: ConsumerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Consumer.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :lapin, :connections, [
  [
    module: Consumer.LapinWorker,
    channels: [
      [
        pattern: Lapin.Pattern.PubSub,
        role: :consumer,
        exchange: "Mra.Events:Event",
        queue: "Lapin.consumer"
      ],
      [
        role: :producer,
        exchange: "some_exchange",
        queue: "some_queue"
      ]
    ]
  ]
]


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
