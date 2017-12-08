defmodule ExPoloniex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_poloniex,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 0.12"},
      {:json, "~> 1.0"},
      {:timex, "~> 3.1"},
      {:exvcr, "~> 0.8", only: :test},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:mix_test_watch, "~> 0.5", only: :dev, runtime: false}
    ]
  end
end
