defmodule Redelix.Mixfile do
  use Mix.Project

  def project do
    [app: :redelix,
     version: "0.0.4",
     elixir: "~> 1.3-rc",
     author: "Paolo Freuli",
     email: "paolo.freuli@gmail.com",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     description: description(),
     package: package()
     ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpotion, :cowboy, :plug]]
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
    [{:httpotion, "~> 3.0.0"}, {:poison, "~> 2.0"},{:cowboy, "~> 1.0.0"}, {:plug, "~> 1.0"}]
  end

  defp description do
    """
    Redmine REST API client library
    """
  end

  defp package do
    [# These are the default files included in the package
     name: :redelix,
     files: ["lib", "config", "mix.exs", "README*", "MIT_LICENSE*"],
     maintainers: ["Paolo Freuli"],
     licenses: ["MIT License"],
     links: %{"GitHub" => "https://github.com/wuatanabe/redelix"}]
  end
  
end
