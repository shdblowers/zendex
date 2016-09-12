defmodule Zendex.Mixfile do
  use Mix.Project

  def project do
    [app: :zendex,
     version: "0.4.0",
     elixir: "~> 1.3",
     description: description(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     package: package()]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [{:httpoison, "~> 0.9"},
     {:poison, "~> 2.2"},
     {:ex_doc, ">= 0.0.0", only: :dev},
     {:credo, "~> 0.4", only: :dev},
     {:dialyxir, "~> 0.3", only: :dev}]
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
