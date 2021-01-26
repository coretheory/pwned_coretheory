defmodule Pwned.MixProject do
  use Mix.Project

  @version "1.2.0"

  def project do
    [
      app: :pwned,
      version: @version,
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      docs: docs(),
      test_coverage: [tool: ExCoveralls],
      name: "CT Pwned",
      source_url: "https://github.com/coretheory/ct_pwned"
    ]
  end

  def application do
    [
      applications: [:httpoison],
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:ex_doc, "~> 0.23.0", only: :dev, runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false}
    ]
  end

  defp description() do
    """
    Check if your password and email have been pwned.
    """
  end

  defp package() do
    [
      maintainers: ["Core Theory"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/coretheory/ct_pwned"}
    ]
  end

  defp docs() do
    [
      main: "readme",
      name: "Pwned",
      source_ref: "v#{@version}",
      canonical: "http://hexdocs.pm/pwned",
      source_url: "https://github.com/coretheory/ct_pwned",
      extras: [
        "README.md",
        "CONTRIBUTING.md"
      ]
    ]
  end
end
