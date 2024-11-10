defmodule Blog.MixProject do
  use Mix.Project

  def project do
    [
      app: :blog,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:esbuild, "~> 0.5"},
      {:floki, "~> 0.36.2"},
      {:mdex, "~> 0.2.0"},
      {:nimble_publisher, "~> 1.1"},
      {:phoenix_live_view, "~> 0.18.2"},
      {:tailwind, "~> 0.1.8"},
      {:yaml_elixir, "~> 2.11"}
    ]
  end

  defp aliases do
    [
      "site.build": ["build", "tailwind default --minify", "esbuild default --minify"]
    ]
  end
end
