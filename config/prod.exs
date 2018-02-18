use Mix.Config

config :shovik_com, ShovikComWeb.Endpoint,
  http: [port: {:system, "SHOVIK_PORT"}],
  url: [host: "${SHOVIK_HOST}", port: {:system, "SHOVIK_PORT"}],
  secret_key_base: "${SECRET_KEY_BASE}",
  cache_static_manifest: "priv/static/cache_manifest.json",
  server: true,
  root: ".",
  version: Application.spec(:shovik_com, :vsn)

config :logger, level: :debug

config :shovik_com, ShovikCom.Repo,
  adapter: Ecto.Adapters.Postgres,
  hostname: "${DB_HOST}",
  database: "${DB_NAME}",
  username: "${DB_USER}",
  password: "${DB_PASSWORD}",
  pool_size: 15
