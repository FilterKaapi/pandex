# Pandex

Pandex is a lightweight ELixir wrapper for [Pandoc](http://pandoc.org). Pandex has no dependencies other than elixir itself.

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
Run `mix deps.get` to install `Pandex`

# Usage

Pandex follows the syntax of `<format from>_to_<format to> <string>`

For example:
``` elixir
markdown_to_html "# Title \n\n## List\n\n- one\n- two\n- three\n"
# {:ok, "<h1 id=\"title\">Title</h1>\n<h2 id=\"list\">List</h2>\n<ul>\n<li>one</li>\n<li>two</li>\n<li>three</li>\n</ul>\n"}

html_to_commonmark "<h1 id=\"title\">Title</h1>\n<h2 id=\"list\">List</h2>\n<ul>\n<li>one</li>\n<li>two</li>\n<li>three</li>\n</ul>\n"
# {:ok, "# Title\n\n## List\n\n* one\n* two\n* three\n\n"}

html_to_opendocument "<h1 id=\"title\">Title</h1>\n<h2 id=\"list\">List</h2>\n<ul>\n<li>one</li>\n<li>two</li>\n<li>three</li>\n</ul>\n"
# {:ok, "<text:h text:style-name=\"Heading_20_1\" text:outline-level=\"1\">Title</text:h>\n<text:h text:style-name=\"Heading_20_2\" text:outline-level=\"2\">List</text:h>\n<text:list text:style-name=\"L1\">\n  <text:list-item>\n    <text:p text:style-name=\"P1\">one</text:p>\n  </text:list-item>\n  <text:list-item>\n    <text:p text:style-name=\"P1\">two</text:p>\n  </text:list-item>\n  <text:list-item>\n    <text:p text:style-name=\"P1\">three</text:p>\n  </text:list-item>\n</text:list>\n"}

commonmark_to_latex "# Title \n\n## List\n\n- one\n- two\n- three\n"
# {:ok, "\\section{Title}\n\n\\subsection{List}\n\n\\begin{itemize}\n\\tightlist\n\\item\n  one\n\\item\n  two\n\\item\n  three\n\\end{itemize}\n"}

markdown_file_to_html "sample.md"
# {:ok, "<h1 id=\"title\">Title</h1>\n<h2 id=\"list\">List</h2>\n<ul>\n<li>one</li>\n<li>two</li>\n<li>three</li>\n</ul>\n"}

```

In your Elixir/Phoenix app:
``` elixir
defmodule YourApp do
  import Pandex

  def convert(string)  do
    {:ok, output} = markdown_to_html string
    IO.puts output
  end
end
```

You can also give a file as an input. The output will however be a string.
``` elixir
defmodule YourApp do
  import Pandex

  def convert(file)  do
    {:ok, output} = markdown_file_to_html file
    IO.puts output
  end
end
```

# License

[MIT License](LICENSE)
