defmodule Pandex do
  @moduledoc ~S"""

  Pandex is a lightweight ELixir wrapper for [Pandoc](http://pandoc.org). Pandex has no dependencies other than pandoc itself. Pandex enables you to convert Markdown, CommonMark, HTML, Latex, json, html to HTML, HTML5, opendocument, rtf, texttile, asciidoc, markdown, json and others. Pandex has no dependencies other than Pandoc itself.

  Pandex enables you to perform any combination of the conversion below:

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

  # Usage

  Pandex follows the syntax of `<format from>_to_<format to> <string>`

  ## Examples:

    iex> Pandex.gfm_to_html("# Title \n\n## List\n\n- one\n- two\n- three\n")
    {:ok, "<h1 id=\"title\">Title</h1>\n<h2 id=\"list\">List</h2>\n<ul>\n<li>one</li>\n<li>two</li>\n<li>three</li>\n</ul>\n"}

    iex> Pandex.latex_to_html5("\\section{Title}\n\n\\subsection{List}\n\n\\begin{itemize}\n\\tightlist\n\\item\n  one\n\\item\n  two\n\\item\n  three\n\\end{itemize}\n")
    {:ok, "<h1 id=\"title\">Title</h1>\n<h2 id=\"list\">List</h2>\n<ul>\n<li><p>one</p></li>\n<li><p>two</p></li>\n<li><p>three</p></li>\n</ul>\n"}

    iex> Pandex.latex_to_json("\\section{Title}\\label{title}\n\n\\subsection{List}\\label{list}\n\n\\begin{itemize}\n\\item\n  one\n\\item\n  two\n\\item\n  three\n\\end{itemize}\n")
    {:ok, "{\"blocks\":[{\"t\":\"Header\",\"c\":[1,[\"title\",[],[]],[{\"t\":\"Str\",\"c\":\"Title\"}]]},{\"t\":\"Header\",\"c\":[2,[\"list\",[],[]],[{\"t\":\"Str\",\"c\":\"List\"}]]},{\"t\":\"BulletList\",\"c\":[[{\"t\":\"Para\",\"c\":[{\"t\":\"Str\",\"c\":\"one\"}]}],[{\"t\":\"Para\",\"c\":[{\"t\":\"Str\",\"c\":\"two\"}]}],[{\"t\":\"Para\",\"c\":[{\"t\":\"Str\",\"c\":\"three\"}]}]]}],\"pandoc-api-version\":[1,17,5,4],\"meta\":{}}\n"}
  """

  @readers [
    "commonmark",
    "gfm",
    "html",
    "json",
    "latex",
    "markdown",
    "markdown_github",
    "markdown_mmd",
    "markdown_phpextra",
    "markdown_strict",
    "rst",
    "textile"
  ]

  @writers [
    "asciidoc",
    "beamer",
    "commonmark",
    "context",
    "docbook",
    "dzslides",
    "gfm",
    "html",
    "html5",
    "json",
    "latex",
    "man",
    "markdown",
    "markdown_github",
    "markdown_mmd",
    "markdown_phpextra",
    "markdown_strict",
    "mediawiki",
    "opendocument",
    "org",
    "plain",
    "rst",
    "rtf",
    "s5",
    "slidy",
    "texinfo",
    "textile"
  ]

  @tmp_folder ".tmp"

  Enum.each(@readers, fn reader ->
    Enum.each(@writers, fn writer ->
      # Convert a string from one format to another.
      # Example: `Pandex.markdown_to_html5("# Title \n\n## List\n\n- one\n- two\n- three\n")`
      def unquote(:"#{reader}_to_#{writer}")(string, options \\ []) do
        convert_string(string, unquote(reader), unquote(writer), options)
      end

      # Convert a file from one format to another.
      # Example: `Pandex.markdown_file_to_html("sample.md") `
      def unquote(:"#{reader}_file_to_#{writer}")(file, options \\ []) do
        convert_file(file, unquote(reader), unquote(writer), options)
      end
    end)
  end)

  @doc """
  `convert_string` works under the hood of all the other string conversion functions.
  """
  def convert_string(string, from, to, options \\ []) when is_list(options) do
    unless File.dir?(@tmp_folder), do: File.mkdir(@tmp_folder)
    file = Path.join(@tmp_folder, random_filename())
    File.write(file, string)

    result =
      case System.cmd("pandoc", [file, "--from=#{from}", "--to=#{to}" | options]) do
        {output, 0} -> {:ok, output}
        e -> {:error, e}
      end

    File.rm(file)

    result
  end

  @doc """
  `convert_file` works under the hood of all the other functions.
  """
  def convert_file(file, from, to, options \\ []) when is_list(options) do
    case System.cmd("pandoc", [file, "--from=#{from}", "--to=#{to}" | options]) do
      {output, 0} -> {:ok, output}
      e -> {:error, e}
    end
  end

  # Private

  defp random_filename do
    Enum.join([random_string(), "-", timestamp(), ".tmp"])
  end

  defp random_string(length \\ 36) do
    length
    |> :crypto.strong_rand_bytes()
    |> Base.url_encode64()
    |> String.slice(0, length)
    |> String.downcase()
  end

  defp timestamp do
    :os.system_time(:seconds)
  end
end
