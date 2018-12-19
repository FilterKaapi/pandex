# Pandex

Pandex is a lightweight Elixir wrapper for [Pandoc](http://pandoc.org). It has no dependencies other than Pandoc itself. Pandex unit tests are currently run again Pandoc version 2.5.

Pandex enables you to perform any combination of the conversions below:

|Convert From (any)  | Convert To (any)   |
|:-------------------|:-------------------|
| commonmark         | asciidoc           |
| gfm                | beamer             |
| html               | commonmark         |
| json               | context            |
| latex              | docbook            |
| markdown           | dzslides           |
| markdown_github *  | gfm                |
| markdown_mmd       | html               |
| markdown_phpextra  | html5              |
| markdown_strict    | json               |
| rst                | latex              |
| textile            | man                |
|                    | markdown           |
|                    | markdown_github *  |
|                    | markdown_mmd       |
|                    | markdown_phpextra  |
|                    | markdown_strict    |
|                    | mediawiki          |
|                    | opendocument       |
|                    | org                |
|                    | plain              |
|                    | rst                |
|                    | rtf                |
|                    | s5                 |
|                    | slidy              |
|                    |texinfo             |
|                    | textile            |

`*` Deprecated: `markdown_github`. Use `gfm` instead.

# Installation

1. Pandex requires Pandoc to work. [Install Pandoc](http://pandoc.org/installing.html) for your operating system.

2. Add Pandex to `mix.exs` as follows:

    ```elixir
    defmodule YourApp.Mixfile do
      defp deps do
        [
          {:pandex, "~> 0.2.0"}
        ]
      end
    end
    ```

3. Run `mix deps.get` to install `Pandex`.

# Usage

Pandex follows the syntax of `<format from>_to_<format to> <string>`

## Examples

```elixir
iex> Pandex.gfm_to_html("# Title \n\n## List\n\n- one\n- two\n- three\n")
{:ok, "<h1 id=\"title\">Title</h1>\n<h2 id=\"list\">List</h2>\n<ul>\n<li>one</li>\n<li>two</li>\n<li>three</li>\n</ul>\n"}

iex> Pandex.latex_to_html5("\\section{Title}\n\n\\subsection{List}\n\n\\begin{itemize}\n\\tightlist\n\\item\n  one\n\\item\n  two\n\\item\n  three\n\\end{itemize}\n")
{:ok, "<h1 id=\"title\">Title</h1>\n<h2 id=\"list\">List</h2>\n<ul>\n<li><p>one</p></li>\n<li><p>two</p></li>\n<li><p>three</p></li>\n</ul>\n"}

iex> Pandex.latex_to_json("\\section{Title}\\label{title}\n\n\\subsection{List}\\label{list}\n\n\\begin{itemize}\n\\item\n  one\n\\item\n  two\n\\item\n  three\n\\end{itemize}\n")
{:ok, "{\"blocks\":[{\"t\":\"Header\",\"c\":[1,[\"title\",[],[]],[{\"t\":\"Str\",\"c\":\"Title\"}]]},{\"t\":\"Header\",\"c\":[2,[\"list\",[],[]],[{\"t\":\"Str\",\"c\":\"List\"}]]},{\"t\":\"BulletList\",\"c\":[[{\"t\":\"Para\",\"c\":[{\"t\":\"Str\",\"c\":\"one\"}]}],[{\"t\":\"Para\",\"c\":[{\"t\":\"Str\",\"c\":\"two\"}]}],[{\"t\":\"Para\",\"c\":[{\"t\":\"Str\",\"c\":\"three\"}]}]]}],\"pandoc-api-version\":[1,17,5,4],\"meta\":{}}\n"}
```

## Using with your app

``` elixir
defmodule YourApp do
  import Pandex

  def convert(string)  do
    {:ok, output} = markdown_to_html(string)
    IO.puts output
  end
end
```

You can also give a file as an input. The output will however be a string.
``` elixir
defmodule YourApp do
  import Pandex

  def convert(file)  do
    {:ok, output} = markdown_file_to_html(file)
    IO.puts output
  end
end
```

# License

[MIT License](LICENSE)
