use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :shovik_com, ShovikComWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :shovik_com, ShovikCom.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "alexk",
  password: "",
  database: "shovik_com_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
  
config :comeonin, bcrypt_log_rounds: 4