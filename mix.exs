defmodule ExPoloniex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_poloniex,
      version: "0.0.1",
      elixir: "~> 1.5",
      start_permanent: Mix.env() == :prod,
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
      {:httpoison, "~> 1.1"},
      {:timex, "~> 3.1"},
      {:exvcr, "~> 0.10", only: [:dev, :test]},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:mix_test_watch, "~> 0.5", only: :dev, runtime: false},
      {:ex_unit_notifier, "~> 0.1", only: :test}
    ]
  end
end
