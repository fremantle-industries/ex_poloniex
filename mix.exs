defmodule ExPoloniex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_poloniex,
      version: "0.0.2",
      elixir: "~> 1.5",
      package: package(),
      start_permanent: Mix.env() == :prod,
      description: description(),
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
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:mix_test_watch, "~> 0.5", only: :dev, runtime: false},
      {:exvcr, "~> 0.10", only: [:dev, :test]},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:ex_unit_notifier, "~> 0.1", only: :test}
    ]
  end

  defp description do
    "Elixir library for the Poloniex Public & Trade API"
  end

  defp package do
    %{
      licenses: ["MIT"],
      maintainers: ["Alex Kwiatkowski"],
      links: %{"GitHub" => "https://github.com/fremantle-capital/ex_poloniex"}
    }
  end
end
