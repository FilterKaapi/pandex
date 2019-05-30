defmodule Pandex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :pandex,
      version: "0.2.0",
      name: "pandex",
      elixir: "~> 1.0",
      source_url: "https://github.com/filterkaapi/pandex",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      docs: [extras: ["README.md"]],
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  def application do
    [applications: [:logger]]
  end

  defp description do
    """
      Pandex is a lightweight Elixir wrapper for [Pandoc](http://pandoc.org). Pandex enables you to convert Markdown, CommonMark, HTML, Latex, json, html to HTML, HTML5, opendocument, rtf, texttile, asciidoc, markdown, json and others. Pandex has no dependencies other than Pandoc itself.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.MD", "LICENSE"],
      contributors: ["Sandeep Laxman", "Sean Omlor"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/filterkaapi/pandex",
        "Docs" => "https://github.com/filterkaapi/pandex"
      }
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.20", only: [:dev], runtime: false}
    ]
  end
end
