defmodule PlugSessionArangodb.MixProject do
  use Mix.Project

  def project do
    [
      app: :plug_session_arangodb,
      build_embedded: Mix.env() == :prod,
      version: "0.9.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: [
        maintainers: ["kmakita13714"],
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/kmakita13714/plug_session_arangodb"}
      ],
      description: "A ArangoDB adapter for Plug.Session",
      source_url: "https://github.com/kmakita13714/plug_session_arangodb",
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {PlugSessionArangodb.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:plug, "~> 1.1"},
      {:arangox, "~> 0.5.4"},
      {:velocy, "~> 0.1.5"},
      {:jason, "~> 1.1"},
      {:mint, "~> 0.4.0"}
    ]
  end
end
