defmodule DynamicInterfaces.Mixfile do
  use Mix.Project

  def project do
    [
      app: :dynamic_interfaces,
      version: "0.2.1",
      elixir: "~> 1.5",
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description do
    """
    Macro for swapping out different implementations at runtime.
    """
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp package do
    [
      name: :dynamic_interfaces,
      files: ["lib", "mix.exs", "README*", "LICENSE*", "config"],
      maintainers: ["Skyler Parr"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/skylerparr/dynamic_interfaces"}
    ]
  end
end
