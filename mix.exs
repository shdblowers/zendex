defmodule Zendex.Mixfile do
  use Mix.Project

  def project do
    [app: :zendex,
     version: "0.4.1",
     elixir: "~> 1.3",
     description: description(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     package: package(),
     dialyzer: [plt_add_apps: [:httpoison], plt_add_deps: :transitive]]
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
     files: ["lib/zendex", "mix.exs", "README.md", "LICENSE"],
     maintainers: ["Steven Blowers"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/shdblowers/zendex"}]
  end
end
