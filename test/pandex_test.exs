defmodule PandexTest do
  use ExUnit.Case, async: true
  doctest Pandex

  @min_version_major 2
  @min_version_minor 5

  test "pandoc version >= #{@min_version_major}.#{@min_version_minor}" do
    assert {:ok, [major, minor | _]} = get_pandoc_version()
    assert major >= @min_version_major and minor >= @min_version_minor
  end

  test "markdown_to_html" do
    input = """
    # Title

    ## List
    - one
    - two
    - three
    """

    output = """
    <h1 id="title">Title</h1>
    <h2 id="list">List</h2>
    <ul>
    <li>one</li>
    <li>two</li>
    <li>three</li>
    </ul>
    """

    assert Pandex.markdown_to_html(input) == {:ok, output}
  end

  test "html_to_commonmark" do
    input = """
    <h1 id="title">Title</h1>
    <h2 id="list">List</h2>
    <ul>
      <li>one</li>
      <li>two</li>
      <li>three</li>
    </ul>
    """

    output = """
    # Title

    ## List

      - one
      - two
      - three
    """

    assert Pandex.html_to_commonmark(input) == {:ok, output}
  end

  test "html_to_opendocument" do
    input = """
    <h1 id="title">Title</h1>
    <h2 id="list">List</h2>
    <ul>
    <li>one</li>
    <li>two</li>
    <li>three</li>
    </ul>
    """

    output = """
    <text:h text:style-name="Heading_20_1" text:outline-level="1"><text:bookmark-start text:name="title" />Title<text:bookmark-end text:name="title" /></text:h>
    <text:h text:style-name="Heading_20_2" text:outline-level="2"><text:bookmark-start text:name="list" />List<text:bookmark-end text:name="list" /></text:h>
    <text:list text:style-name="L1">
      <text:list-item>
        <text:p text:style-name="P1">one</text:p>
      </text:list-item>
      <text:list-item>
        <text:p text:style-name="P1">two</text:p>
      </text:list-item>
      <text:list-item>
        <text:p text:style-name="P1">three</text:p>
      </text:list-item>
    </text:list>
    """

    assert Pandex.html_to_opendocument(input) == {:ok, output}
  end

  test "commonmark_to_latex" do
    input = """
    # Title
    ## List
    - one
    - two
    - three
    """

    output = """
    \\section{Title}

    \\subsection{List}

    \\begin{itemize}
    \\tightlist
    \\item
      one
    \\item
      two
    \\item
      three
    \\end{itemize}
    """

    assert Pandex.commonmark_to_latex(input) == {:ok, output}
  end

  test "latex_to_html5" do
    input = """
    \\section{Title}

    \\subsection{List}

    \\begin{itemize}
    \\tightlist
    \\item
      one
    \\item
      two
    \\item
      three
    \\end{itemize}
    """

    output = """
    <h1 id="title">Title</h1>
    <h2 id="list">List</h2>
    <ul>
    <li><p>one</p></li>
    <li><p>two</p></li>
    <li><p>three</p></li>
    </ul>
    """

    assert Pandex.latex_to_html5(input) == {:ok, output}
  end

  test "html_to_latex" do
    input = """
    <h1 id="title">Title</h1>
    <h2 id="list">List</h2>
    <ul>
    <li><p>one</p></li>
    <li><p>two</p></li>
    <li><p>three</p></li>
    </ul>
    """

    output = """
    \\hypertarget{title}{%
    \\section{Title}\\label{title}}

    \\hypertarget{list}{%
    \\subsection{List}\\label{list}}

    \\begin{itemize}
    \\item
      one
    \\item
      two
    \\item
      three
    \\end{itemize}
    """

    assert Pandex.html_to_latex(input) == {:ok, output}
  end

  test "latex_to_json" do
    input = """
    \\section{Title}\\label{title}

    \\subsection{List}\\label{list}

    \\begin{itemize}
    \\item
      one
    \\item
      two
    \\item
      three
    \\end{itemize}
    """

    assert {:ok, api_version} = get_pandoc_api_version()
    api_version = Enum.join(api_version, ",")

    output = """
    {"blocks":[{"t":"Header","c":[1,["title",[],[]],[{"t":"Str","c":"Title"}]]},{"t":"Header","c":[2,["list",[],[]],[{"t":"Str","c":"List"}]]},{"t":"BulletList","c":[[{"t":"Para","c":[{"t":"Str","c":"one"}]}],[{"t":"Para","c":[{"t":"Str","c":"two"}]}],[{"t":"Para","c":[{"t":"Str","c":"three"}]}]]}],"pandoc-api-version":[#{
      api_version
    }],"meta":{}}
    """

    assert Pandex.latex_to_json(input) == {:ok, output}
  end

  test "markdown_to_rst" do
    input = """
    # Title

    ## List
    - one
    - two
    - three
    """

    output = """
    Title
    =====

    List
    ----

    -  one
    -  two
    -  three
    """

    assert Pandex.markdown_to_rst(input) == {:ok, output}
  end

  test "markdown_to_rtf" do
    input = """
    # Title

    ## List
    - one
    - two
    - three
    """

    output = """
    {\\pard \\ql \\f0 \\sa180 \\li0 \\fi0 \\b \\fs36 Title\\par}
    {\\pard \\ql \\f0 \\sa180 \\li0 \\fi0 \\b \\fs32 List\\par}
    {\\pard \\ql \\f0 \\sa0 \\li360 \\fi-360 \\bullet \\tx360\\tab one\\par}
    {\\pard \\ql \\f0 \\sa0 \\li360 \\fi-360 \\bullet \\tx360\\tab two\\par}
    {\\pard \\ql \\f0 \\sa0 \\li360 \\fi-360 \\bullet \\tx360\\tab three\\sa180\\par}

    """

    assert Pandex.markdown_to_rtf(input) == {:ok, output}
  end

  test "markdown_to_opendocument" do
    input = """
    # Title

    ## List

    - one
    - two
    - three
    """

    output = """
    <text:h text:style-name="Heading_20_1" text:outline-level="1"><text:bookmark-start text:name="title" />Title<text:bookmark-end text:name="title" /></text:h>
    <text:h text:style-name="Heading_20_2" text:outline-level="2"><text:bookmark-start text:name="list" />List<text:bookmark-end text:name="list" /></text:h>
    <text:list text:style-name="L1">
      <text:list-item>
        <text:p text:style-name="P1">one</text:p>
      </text:list-item>
      <text:list-item>
        <text:p text:style-name="P1">two</text:p>
      </text:list-item>
      <text:list-item>
        <text:p text:style-name="P1">three</text:p>
      </text:list-item>
    </text:list>
    """

    assert Pandex.markdown_to_opendocument(input) == {:ok, output}
  end

  test "commonmark_to_textile" do
    input = """
    # Title

    ## List

    - one
    - two
    - three
    """

    output = """
    h1. Title

    h2. List

    * one
    * two
    * three

    """

    assert Pandex.commonmark_to_textile(input) == {:ok, output}
  end

  test "textile_to_markdown_github" do
    input = """
    h1. Title

    h2. List

    * one
    * two
    * three
    """

    output = """
    Title
    =====

    List
    ----

    -   one
    -   two
    -   three
    """

    assert Pandex.textile_to_markdown_github(input) == {:ok, output}
  end

  test "textile_to_gfm" do
    input = """
    h1. Title

    h2. List

    * one
    * two
    * three
    """

    output = """
    # Title

    ## List

      - one
      - two
      - three
    """

    assert Pandex.textile_to_gfm(input) == {:ok, output}
  end

  test "textile_to_markdown_phpextra" do
    input = """
    h1. Title

    h2. List

    * one
    * two
    * three
    """

    output = """
    Title {#title}
    =====

    List {#list}
    ----

    -   one
    -   two
    -   three
    """

    assert Pandex.textile_to_markdown_phpextra(input) == {:ok, output}
  end

  test "textile_to_html5" do
    input = """
    h1. Title

    h2. List

    * one
    * two
    * three
    """

    output = """
    <h1 id="title">Title</h1>
    <h2 id="list">List</h2>
    <ul>
    <li>one</li>
    <li>two</li>
    <li>three</li>
    </ul>
    """

    assert Pandex.textile_to_html5(input) == {:ok, output}
  end

  test "textile_to_opendocument" do
    input = """
    h1. Title

    h2. List

    * one
    * two
    * three
    """

    output = """
    <text:h text:style-name="Heading_20_1" text:outline-level="1"><text:bookmark-start text:name="title" />Title<text:bookmark-end text:name="title" /></text:h>
    <text:h text:style-name="Heading_20_2" text:outline-level="2"><text:bookmark-start text:name="list" />List<text:bookmark-end text:name="list" /></text:h>
    <text:list text:style-name="L1">
      <text:list-item>
        <text:p text:style-name="P1">one</text:p>
      </text:list-item>
      <text:list-item>
        <text:p text:style-name="P1">two</text:p>
      </text:list-item>
      <text:list-item>
        <text:p text:style-name="P1">three</text:p>
      </text:list-item>
    </text:list>
    """

    assert Pandex.textile_to_opendocument(input) == {:ok, output}
  end

  test "textile_to_asciidoc" do
    input = """
    h1. Title

    h2. List

    * one
    * two
    * three
    """

    output = """
    == Title

    === List

    * one
    * two
    * three
    """

    assert Pandex.textile_to_asciidoc(input) == {:ok, output}
  end

  test "markdown_to_asciidoc" do
    input = """
    # Title

    ## List

    - one
    - two
    - three
    """

    output = """
    == Title

    === List

    * one
    * two
    * three
    """

    assert Pandex.markdown_to_asciidoc(input) == {:ok, output}
  end

  test "gfm_to_plain" do
    input = """
    # Title

    ## List

    - one
    - two
    - three
    """

    output = """


    TITLE


    List

    -   one
    -   two
    -   three
    """

    assert Pandex.gfm_to_plain(input) == {:ok, output}
  end

  test "gfm_to_plain with [\"--wrap=none\"] options" do
    input = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
    """

    output = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
    tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim
    veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
    commodo consequat.
    """

    output_wrap_none = input

    assert Pandex.gfm_to_plain(input) == {:ok, output}
    assert Pandex.gfm_to_plain(input, ["--wrap=none"]) == {:ok, output_wrap_none}
  end

  # Private

  defp get_pandoc_version() do
    get_version(~r/^pandoc\s*(?<version>[0-9][0-9.]*)(\r\n|\r|\n)/)
  end

  defp get_pandoc_api_version() do
    get_version(~r/.*pandoc-types\s*(?<version>[0-9][0-9.]*),.*/)
  end

  # return version list, e.g. [2, 5]
  defp get_version(regex) do
    with {result, 0} <- System.cmd("pandoc", ["--version"]),
         %{"version" => version} <- Regex.named_captures(regex, result),
         [_, _ | _] = version <- parse_version(version) do
      {:ok, version}
    else
      _ -> :error
    end
  end

  # parse version string into list of integers, e.g. "2.5" returns [2, 5]
  defp parse_version(version) when is_binary(version) do
    version
    |> String.split(".")
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(fn {n, _} -> n end)
  end

  defp parse_version(_), do: :error
end
