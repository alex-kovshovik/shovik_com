defmodule ShovikCom.Mixfile do
  use Mix.Project

  def project do
    [
      app: :shovik_com,
      version: "0.1.0",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {ShovikCom.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},
      {:comeonin, "~> 3.0"},
      {:credo, "~> 0.5.2", runtime: false},
      {:mix_test_watch, "~> 0.2.6"},
      {:ex_machina, "~> 1.0"},
      {:timex, "~> 3.1"},
      {:timex_ecto, "~> 3.2"},
      {:tzdata, "~> 0.5.14"},
      {:cachex, "~> 2.1"},
      {:scrivener_ecto, "~> 1.3"},
      {:scrivener_html, "~> 1.7"},
      {:earmark, "~> 1.0"},

      # File attachments
      {:arc, "~> 0.8.0"},
      {:arc_ecto, "~> 0.7.0"},
      {:ex_aws, "~> 1.1"},
      {:hackney, "~> 1.10"},
      {:poison, "~> 3.1"},
      {:sweet_xml, "~> 0.6.5"},

      # Deployment
      {:distillery, "~> 1.5", runtime: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "ecto.seed": ["run priv/repo/seeds.exs"],
      "test": ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
