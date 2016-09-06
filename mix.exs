defmodule Zendex.Mixfile do
  use Mix.Project

  def project do
    [app: :zendex,
     version: "0.0.1",
     elixir: "~> 1.3",
     description: description(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     package: package()]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    []
  end

  defp description do
    """
    An Elixir wrapper for the Zendesk API.
    """
  end

  defp package do
    [name: :zendex,
     maintainers: ["Steven Blowers"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/shdblowers/zendex"}]
  end
end
