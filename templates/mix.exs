defmodule {{App_Name}}.Mixfile do
  use Mix.Project

  def project do
    [app: :{{app_name}},
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: { {{App_Name}}, [] },
      applications: [
        :phoenix, :cowboy, :logger,
        :postgrex,
        :poison, :comeonin, :tzdata
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix  , "~> 1.0.3"},
     {:postgrex , ">= 0.0.0"},
     {:cowboy   , "~> 1.0"},
     {:poison   , "~> 1.5.0"},
     {:comeonin , "> 1.1.0"},
     {:timex    , "~> 0.19.5"}
   ]
  end

end
