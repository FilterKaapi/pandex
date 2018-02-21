# Pandex

Pandex is a lightweight Elixir wrapper for [Pandoc](http://pandoc.org). Pandex has no dependencies other than Pandoc itself.

Pandex enables you to perform any combination of the conversions below:

|Convert From (any)| Convert To (any)   |
|:-----------------|:-------------------|
|docx              | html               |
|markdown          | json               |
|markdown_github   | html               |
|markdown_strict   | html5              |
|markdown_mmd      | s5                 |
|commonmark        | slidy              |
|json              | dzslides           |
|rst               | docbook            |
|textile           | man                |
|html              | opendocument       |
|latex             | latex              |
|markdown_phpextra | beamer             |
|                  | context            |
|                  | texinfo            |
|                  | markdown           |
|                  | markdown_github    |
|                  | markdown_strict    |
|                  | markdown_mmd       |
|                  | markdown_phpextra  |
|                  | commonmark         |
|                  | plain              |
|                  | rst                |
|                  | mediawiki          |
|                  | textile            |
|                  | rtf                |
|                  | org                |
|                  | asciidoc           |

# Installation

1. Pandex requires Pandoc to work. [Install Pandoc](http://pandoc.org/installing.html) for your operating system.

2. Add Pandex to `mix.exs` as follows:

    ```elixir
    defmodule YourApp.Mixfile do
      defp deps do
        [
          {:pandex, "~> 0.1.1"}
        ]
      end
    end
    ```

3. Run `mix deps.get` to install `Pandex`.

4. Add `Pandex` your application block in `mix.exs`

    ```elixir
    defmodule YourApp.Mixfile do
      use Mix.Project

      def application do
        [applications: [:logger, :pandex]]
      end
    end
    ```

# Usage

Pandex follows the syntax of `<format from>_to_<format to> <string>`

## Examples

``` elixir
iex> Pandex.docx_to_html(File.read!(System.cwd() <> "/test/fixtures/test.docx"), ["-s", "--toc"])
{:ok, "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n  <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\n  <meta http-equiv=\"Content-Style-Type\" content=\"text/css\" />\n  <meta name=\"generator\" content=\"pandoc\" />\n  <title></title>\n  <style type=\"text/css\">code{white-space: pre;}</style>\n</head>\n<body>\n<div id=\"TOC\">\n<ul>\n<li><a href=\"#hello-world\">Hello World</a></li>\n</ul>\n</div>\n<h1 id=\"hello-world\">Hello World</h1>\n<p>Lorem ipsum</p>\n</body>\n</html>\n"}

iex> Pandex.markdown_to_html "# Title \n\n## List\n\n- one\n- two\n- three\n"
{:ok, "<h1 id=\"title\">Title</h1>\n<h2 id=\"list\">List</h2>\n<ul>\n<li>one</li>\n<li>two</li>\n<li>three</li>\n</ul>\n"}

iex> Pandex.html_to_commonmark "<h1 id=\"title\">Title</h1>\n<h2 id=\"list\">List</h2>\n<ul>\n<li>one</li>\n<li>two</li>\n<li>three</li>\n</ul>\n"
{:ok, "# Title\n\n## List\n\n* one\n* two\n* three\n\n"}

iex> Pandex.html_to_opendocument "<h1 id=\"title\">Title</h1>\n<h2 id=\"list\">List</h2>\n<ul>\n<li>one</li>\n<li>two</li>\n<li>three</li>\n</ul>\n"
{:ok, "<text:h text:style-name=\"Heading_20_1\" text:outline-level=\"1\">Title</text:h>\n<text:h text:style-name=\"Heading_20_2\" text:outline-level=\"2\">List</text:h>\n<text:list text:style-name=\"L1\">\n  <text:list-item>\n    <text:p text:style-name=\"P1\">one</text:p>\n  </text:list-item>\n  <text:list-item>\n    <text:p text:style-name=\"P1\">two</text:p>\n  </text:list-item>\n  <text:list-item>\n    <text:p text:style-name=\"P1\">three</text:p>\n  </text:list-item>\n</text:list>\n"}

iex> Pandex.commonmark_to_latex "# Title \n\n## List\n\n- one\n- two\n- three\n"
{:ok, "\\section{Title}\n\n\\subsection{List}\n\n\\begin{itemize}\n\\tightlist\n\\item\n  one\n\\item\n  two\n\\item\n  three\n\\end{itemize}\n"}

iex> Pandex.latex_to_html5 "\\section{Title}\n\n\\subsection{List}\n\n\\begin{itemize}\n\\tightlist\n\\item\n  one\n\\item\n  two\n\\item\n  three\n\\end{itemize}\n"
{:ok, "<h1 id=\"title\">Title</h1>\n<h2 id=\"list\">List</h2>\n<ul>\n<li><p>one</p></li>\n<li><p>two</p></li>\n<li><p>three</p></li>\n</ul>\n"}

iex> Pandex.html_to_latex "<h1 id=\"title\">Title</h1>\n<h2 id=\"list\">List</h2>\n<ul>\n<li><p>one</p></li>\n<li><p>two</p></li>\n<li><p>three</p></li>\n</ul>\n"
{:ok, "\\section{Title}\\label{title}\n\n\\subsection{List}\\label{list}\n\n\\begin{itemize}\n\\item\n  one\n\\item\n  two\n\\item\n  three\n\\end{itemize}\n"}

iex> Pandex.latex_to_json "\\section{Title}\\label{title}\n\n\\subsection{List}\\label{list}\n\n\\begin{itemize}\n\\item\n  one\n\\item\n  two\n\\item\n  three\n\\end{itemize}\n"
{:ok, "[{\"unMeta\":{}},[{\"t\":\"Header\",\"c\":[1,[\"title\",[],[]],[{\"t\":\"Str\",\"c\":\"Title\"}]]},{\"t\":\"Header\",\"c\":[2,[\"list\",[],[]],[{\"t\":\"Str\",\"c\":\"List\"}]]},{\"t\":\"BulletList\",\"c\":[[{\"t\":\"Para\",\"c\":[{\"t\":\"Str\",\"c\":\"one\"}]}],[{\"t\":\"Para\",\"c\":[{\"t\":\"Str\",\"c\":\"two\"}]}],[{\"t\":\"Para\",\"c\":[{\"t\":\"Str\",\"c\":\"three\"}]}]]}]]\n"}

iex> Pandex.markdown_to_rst "# Title \n\n## List\n\n- one\n- two\n- three\n"
{:ok, "Title\n=====\n\nList\n----\n\n-  one\n-  two\n-  three\n"}

iex> Pandex.markdown_to_rtf "# Title \n\n## List\n\n- one\n- two\n- three\n"
{:ok, "{\\pard \\ql \\f0 \\sa180 \\li0 \\fi0 \\b \\fs36 Title\\par}\n{\\pard \\ql \\f0 \\sa180 \\li0 \\fi0 \\b \\fs32 List\\par}\n{\\pard \\ql \\f0 \\sa0 \\li360 \\fi-360 \\bullet \\tx360\\tab one\\par}\n{\\pard \\ql \\f0 \\sa0 \\li360 \\fi-360 \\bullet \\tx360\\tab two\\par}\n{\\pard \\ql \\f0 \\sa0 \\li360 \\fi-360 \\bullet \\tx360\\tab three\\sa180\\par}\n"}

iex> Pandex.markdown_to_opendocument "# Title \n\n## List\n\n- one\n- two\n- three\n"
{:ok, "<text:h text:style-name=\"Heading_20_1\" text:outline-level=\"1\">Title</text:h>\n<text:h text:style-name=\"Heading_20_2\" text:outline-level=\"2\">List</text:h>\n<text:list text:style-name=\"L1\">\n  <text:list-item>\n    <text:p text:style-name=\"P1\">one</text:p>\n  </text:list-item>\n  <text:list-item>\n    <text:p text:style-name=\"P1\">two</text:p>\n  </text:list-item>\n  <text:list-item>\n    <text:p text:style-name=\"P1\">three</text:p>\n  </text:list-item>\n</text:list>\n"}

iex> Pandex.commonmark_to_textile "# Title \n\n## List\n\n- one\n- two\n- three\n"
{:ok, "h1. Title\n\nh2. List\n\n* one\n* two\n* three\n\n"}

iex> Pandex.textile_to_markdown_github "h1. Title\n\nh2. List\n\n* one\n* two\n* three\n\n"
{:ok, "Title\n=====\n\nList\n----\n\n-   one\n-   two\n-   three\n\n"}

iex> Pandex.textile_to_markdown_phpextra "h1. Title\n\nh2. List\n\n* one\n* two\n* three\n\n"
{:ok, "Title {#title}\n=====\n\nList {#list}\n----\n\n-   one\n-   two\n-   three\n\n"}

iex> Pandex.textile_to_html5 "h1. Title\n\nh2. List\n\n* one\n* two\n* three\n\n"
{:ok, "<h1 id=\"title\">Title</h1>\n<h2 id=\"list\">List</h2>\n<ul>\n<li>one</li>\n<li>two</li>\n<li>three</li>\n</ul>\n"}

iex> Pandex.textile_to_opendocument "h1. Title\n\nh2. List\n\n* one\n* two\n* three\n\n"
{:ok, "<text:h text:style-name=\"Heading_20_1\" text:outline-level=\"1\">Title</text:h>\n<text:h text:style-name=\"Heading_20_2\" text:outline-level=\"2\">List</text:h>\n<text:list text:style-name=\"L1\">\n  <text:list-item>\n    <text:p text:style-name=\"P1\">one</text:p>\n  </text:list-item>\n  <text:list-item>\n    <text:p text:style-name=\"P1\">two</text:p>\n  </text:list-item>\n  <text:list-item>\n    <text:p text:style-name=\"P1\">three</text:p>\n  </text:list-item>\n</text:list>\n"}

```

## Using with your app

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
