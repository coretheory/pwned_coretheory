defmodule CTPwned.MixProject do
  use Mix.Project

  @version "1.0.1"

  def project do
    [
      app: :pwned_coretheory,
      version: @version,
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      docs: docs(),
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
    A simple application to check if an email or password has been pwned
    using the HaveIBeenPwned? API. It requires a purchased hibp-api-key
    in order to use the email checking functions.
    """
  end

  defp package() do
    [
      maintainers: ["Core Theory"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/coretheory/ct_pwned"},
    ]
  end

  defp docs() do
    [
      main: "readme",
      name: "Pwned by Core Theory",
      source_ref: "v#{@version}",
      source_url: "https://github.com/coretheory/ct_pwned",
      extras: [
        "README.md",
        "CONTRIBUTING.md"
      ]
    ]
  end
end
