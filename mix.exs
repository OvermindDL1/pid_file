defmodule PidFile.Mixfile do
  use Mix.Project

  def project do
    [
      app: :pid_file,
      version: "0.1.0",
      elixir: "~> 1.5",
      description: description(),
      package: package(),
      docs: docs(),
      start_permanent: Mix.env == :prod,
      deps: deps(),
    ]
  end

  def description do
    """
    This is a library to create and manage a PID file from the BEAM process.
    """
  end

  def package do
    [
      licenses: ["MIT"],
      name: :pid_file,
      maintainers: ["OvermindDL1"],
      links: %{
        "Github" => "https://github.com/OvermindDL1/pid_file",
      },
    ]
  end

  def docs do
    [
      #logo: "path/to/logo.png",
      extras: ["README.md"],
      main: "readme",
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {PidFile.Application, []},
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end
end
