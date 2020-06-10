defmodule AnalyticsElixir.Mixfile do
  use Mix.Project

  def project do
    [
      app: :segment,
      version: "1.1.1",
      elixir: "~> 1.5",
      deps: deps(),
      description: "analytics_elixir",
      package: package()
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      mod: {Segment.Application, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.7.0"},
      {:poison, "~> 4.0"},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:mox, ">= 0.0.0", only: :test}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Martin Stannard"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/expert360/analytics-elixir"},
      organization: "expert360"
    ]
  end
end
