use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with webpack to recompile .js and .css sources.
config :ash_server, AshServerWeb.Endpoint,
  http: [port: 4000],
  https: [
    port: 4001,
    cipher_suite: :strong,
    certfile: "priv/cert/selfsigned.pem",
    keyfile: "priv/cert/selfsigned_key.pem"
  ],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

# Test watcher
config :mix_test_watch,
  clear: true

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

# Configure your database
config :ash_server, AshServer.Repo,
  username: "postgres",
  password: "postgres",
  database: "lambda_forms_dev",
  hostname: "localhost",
  pool_size: 10
