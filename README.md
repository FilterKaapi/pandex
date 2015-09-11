# Pandex

Pandex is a lightweight ELixir wrapper for [Pandoc](http://pandoc.org)

Pandex enables you to perform any permutation of the conversion below:

Convert From (any)| Convert To (any)
------------------|-------------------
markdown          | json
markdown_github   | html
markdown_strict   | html5
markdown_mmd      | s5
commonmark        | slidy
json              | dzslides
rst               | docbook
textile           | man
html              | opendocument
latex             | latex
markdown_phpextra | beamer
                  | context
                  | texinfo
                  | markdown
                  | markdown_github
                  | markdown_strict
                  | markdown_mmd
                  | markdown_phpextra
                  | commonmark
                  | plain
                  | rst
                  | mediawiki
                  | textile
                  | rtf
                  | org
                  | asciidoc

# Installation

- Pandex requires Pandoc to work. [Install Pandoc](http://pandoc.org/installing.html) for your operating system.
- Add Pandex to `mix.exs` as follows:

``` elixir
defmodule YourApp.Mixfile do
  use Mix.Project

  def application do
    [applications: [:logger, :pandex]]
  end

  defp deps do
    [
      {:pandex, "~> 0.0.1"}
    ]
  end
end
```

# Usage

In your module
``` elixir
defmodule YourApp do
  import Pandex

  def
    {:ok, output} = markdown_to_html "# Title \n\n## List\n\n- one\n- two\n- three\n"
  end
end
```
