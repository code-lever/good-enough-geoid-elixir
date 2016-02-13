defmodule GoodEnoughGeoid.Mixfile do
  use Mix.Project

  def project do
    [app: :good_enough_geoid,
     version: "0.0.2",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description,
     package: package,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [mod: {GoodEnoughGeoid.App, []},
     applications: [:logger]]
  end

  defp deps do
    [
      {:csv, "~> 1.2"},
      {:dogma, "~> 0.0", only: :dev},
      {:earmark, "~> 0.0", only: :dev},
      {:ex_doc, "~> 0.10", only: :dev},
    ]
  end

  defp description do
    """
    Get EGM Geoid heights that are good enough for some purposes (maybe yours).
    """
  end

  defp package do
    [
      files: ["lib", "priv", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Nick Veys", "Gabe Cook"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/code-lever/good-enough-geoid-elixir",
      }
    ]
  end
end
