defmodule Pandex.Mixfile do
  use Mix.Project

  def project do
    [
     app: :pandex,
     version: "0.1.0",
     name: "pandex",
     elixir: "~> 1.0",
     source_url: "https://github.com/filterkaapi/pandex",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     docs: [extras: ["README.md"]],
     description: description,
     package: package,
     deps: deps
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  defp description do
    """
      Pandex is a lightweight Elixir wrapper for [Pandoc](http://pandoc.org). Pandex enables you to convert Markdown, CommonMark, HTML, Latex, json, html to HTML, HTML5, opendocument, rtf, texttile, asciidoc, markdown, json and others. Pandex has no dependencies other than Pandoc itself.
    """
  end

  defp package do
    [# These are the default files included in the package
     files: ["lib", "priv", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
     contributors: ["Sandeep Laxman"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/filterkaapi/pandex",
              "Docs" => "https://github.com/filterkaapi/pandex"}
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [{:ex_doc, "~> 0.9", only: :dev}]
  end
end
