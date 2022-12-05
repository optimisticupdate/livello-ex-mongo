defmodule ExMongoTest.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_mongo_test,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ExMongoTest.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mongodb_driver, "~> 0.9.0"}
    ]
  end
end
