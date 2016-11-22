defmodule Zendex.Mixfile do
  use Mix.Project

  def project do
    [app: :zendex,
     source_url: "https://github.com/shdblowers/zendex",
     version: "0.7.0",
     elixir: "~> 1.3",
     description: description(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     package: package(),
     dialyzer: [plt_add_apps: [:httpoison], plt_add_deps: :transitive],
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: ["coveralls": :test, "coveralls.travis": :test],
     docs: [extras: ["README.md"]]]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [{:httpoison, "~> 0.9"},
     {:poison, "~> 2.2"},
     {:ex_doc, ">= 0.0.0", only: :dev},
     {:credo, "~> 0.4", only: :dev},
     {:dialyxir, "~> 0.3", only: :dev},
     {:excoveralls, "~> 0.5", only: :test},
     {:meck, "~> 0.8", only: :test},
     {:exvcr, "~> 0.8.4", only: :test}]
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
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/shdblowers/zendex"}]
  end
end
