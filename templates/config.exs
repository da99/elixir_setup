

defmodule Mini.Config do
  def get! name do
    val = System.get_env(name)
    case val do
      nil -> raise "System env variable not set: #{inspect name}"
      _ -> val
    end
  end
end # === defmodule Mini.Config

is_dev = !!System.get_env("IS_DEV")

use Mix.Config

config :{{app_name}}, {{App_Name}}.Endpoint,
  secret_key_base: Mini.Config.get!("SESSION_SECRET"),
  url:  [host: (is_dev && "localhost") || "www.{{app_name}}.com", port: (is_dev && System.get_env("PORT")) || 80],
  http: [port: (is_dev && System.get_env("PORT")) || 80],
  root: Path.dirname(__DIR__),
  cache_static_lookup: !is_dev,
  check_origin:        !is_dev,

  render_errors: is_dev && [accepts: ~w(html json)],
  pubsub:        is_dev && [name: App.PubSub, adapter: Phoenix.PubSub.PG2],
  debug_errors:  is_dev,
  code_reloader: is_dev,
  watchers:      is_dev && [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin"]],
  live_reload:   is_dev && [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]


# Configure your database
config :app, App.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: Mini.Config.get!("DB_USER"),
  password: Mini.Config.get!("DB_PASSWORD"),
  database: Mini.Config.get!("DB_NAME"),
  pool_size: 10


# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

if is_dev do
  # Do not include metadata nor timestamps in development logs
  config :logger, :console, format: "[$level] $message\n"
  config :phoenix, :stacktrace_depth, 10

  config :phoenix, :generators,
    migration: true,
    binary_id: false
else
  config :logger, level: :info # Do not print debug messages in production
end


