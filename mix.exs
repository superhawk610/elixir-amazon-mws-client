defmodule MWSClient.Mixfile do
  use Mix.Project

  def project do
    [
      app: :mws_client,
      version: "0.0.1",
      elixir: "~> 1.6",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: "An Amazon MWS API client in Elixir",
      package: package(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: ["coveralls.html": :test, coveralls: :test]
    ]
  end

  defp package do
    [
      maintainers: ["Homan Chou"],
      licenses: ["MIT"],
      links: %{github: "https://github.com/homanchou/elixir-amazon-mws-client"}
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:csv, "~> 2.4"},
      {:elixir_xml_to_map, github: "addico/elixir-xml-to-map", branch: "master"},
      {:httpoison, "~> 1.7"},
      {:inflex, "~> 2.1"},
      {:html_sanitize_ex, "~> 1.4"},
      {:erlsom, "~> 1.4"},

      # DEV/TEST deps
      {:ex_doc, "~> 0.23", only: :dev},
      {:excoveralls, "~> 0.13", only: :test}
    ]
  end
end
