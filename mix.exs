defmodule MWSClient.Mixfile do
  use Mix.Project

  def project do
    [app: :mws_client,
     version: "0.0.1",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: "An Amazon MWS API client in Elixir",
     package: package(),
     deps: deps()]
  end

  defp package do
    [
      maintainers: ["Homan Chou"],
      licenses: ["MIT"],
      links: %{github: "https://github.com/homanchou/elixir-amazon-mws-client" }
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison, :timex]]
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
    [ {:csv, "~> 1.4.2"},
      {:elixir_xml_to_map, github: "retgoat/elixir-xml-to-map", tag: "0.1.2"},
      {:httpoison, "~> 0.11.0"},
      {:inflex, "~> 1.7.0" }, #camelize
      {:html_sanitize_ex, "~> 1.0.0"},
      {:timex, "~> 3.0"},
      {:ex_doc, "~> 0.10", only: :dev},
      {:exsync, "~> 0.1", only: :dev}
    ]
  end
end
