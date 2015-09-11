# Pandex

Pandex is a lightweight ELixir wrapper for [Pandoc](http://pandoc.org)

Pandex accepts documents in "markdown", "json", "rst", "textile", "html", "latex" format and can convert it into "json", "html", "html5", "s5", "slidy", "dzslides", "docbook", "man", "opendocument", "latex", "beamer", "context", "texinfo", "markdown", "plain", "rst", "mediawiki", "textile", "rtf", "org", "asciidoc" formats.

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
