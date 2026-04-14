# bjk-academic

An academic article template usable as both a standalone Typst template and a Quarto extension. Forked from [kazuyanagimoto/quarto-academic-typst](https://github.com/kazuyanagimoto/quarto-academic-typst).

## Usage

### Standalone Typst

If the local package symlink is set up (see [Setup](#setup)), import from any `.typ` file:

```typ
#import "@local/bjk-academic:0.1.0": article, appendix

#show: article.with(
  title: "My Paper",
  authors: ((
    name: "Author Name",
    affiliation: "University",
    email: "author@example.com",
    orcid: [],
  ),),
  date: "2026",
  abstract: [Abstract text here.],
  sectionnumbering: "1.1.1",
  titlepage: true,
)
```

Compile with `--font-path` to use the bundled fonts:

```bash
typst compile my-paper.typ --root . --font-path /path/to/bjk-typst/static/fonts
```

See `template/main.typ` for a complete working example.

### Quarto

Install the extension into a Quarto project:

```bash
quarto install extension brentonk/bjk-typst
```

Then use `format: academic-typst` in your `.qmd` front matter. See `template.qmd` for a minimal example.

## Setup

### Local Typst package

Symlink this repo as a local Typst package so it's importable from anywhere:

```bash
mkdir -p ~/.local/share/typst/packages/local/bjk-academic
ln -s /path/to/bjk-typst ~/.local/share/typst/packages/local/bjk-academic/0.1.0
```

### Quarto extension

No special setup needed — `quarto install extension brentonk/bjk-typst` handles it. Re-run after pulling changes to update.

## Editing the template

All styling lives in a single file: `_extensions/academic/typst-template.typ`. This defines the `article()` and `appendix()` functions. Both the Typst package (`lib.typ`) and the Quarto extension (`typst-show.typ`) point to this same file, so aesthetic changes only need to be made once.

### Key parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| `font` | `"libertinus serif"` | Body font |
| `sansfont` | `"Fira Sans"` | Heading/UI font |
| `mathfont` | `"New Computer Modern Math"` | Math font |
| `fontsize` | `11pt` | Base font size |
| `link-color` | `rgb("#483d8b")` | Link/reference color |
| `margin` | `(x: 1.25in, y: 1.25in)` | Page margins |
| `paper` | `"us-letter"` | Paper size |
| `sectionnumbering` | `none` | Section numbering format (e.g. `"1.1.1"`) |
| `titlepage` | `false` | Separate title page with content starting on page 1 |
| `cols` | `1` | Number of columns |

### Quarto-only files

- `typst-show.typ` — maps Quarto YAML metadata to `article()` parameters (Mustache/Pandoc template syntax)
- `shortcodes.lua` — provides `{{< appendix >}}` shortcode
- `_extension.yml` — Quarto extension metadata

## Building examples

```bash
make          # build both examples
make typst    # standalone Typst only
make quarto   # Quarto only
make clean    # remove generated PDFs
```

## Repo structure

```
bjk-typst/
├── lib.typ                          # Typst package entrypoint (re-exports from extension)
├── typst.toml                       # Typst package manifest
├── Makefile                         # Build example PDFs
├── template/
│   └── main.typ                     # Standalone Typst starter template
├── _extensions/academic/
│   ├── typst-template.typ           # Core template (single source of truth)
│   ├── typst-show.typ               # Quarto YAML → article() bridge
│   ├── shortcodes.lua               # Quarto shortcodes
│   └── _extension.yml               # Quarto extension metadata
├── static/fonts/                    # Bundled fonts (Fira Sans, Libertinus)
├── template.qmd                     # Quarto example
└── references.bib                   # Example bibliography
```

## Credits

Original template by [Kazuharu Yanagimoto](https://github.com/kazuyanagimoto), inspired by Kieran Healy's [LaTeX template](https://github.com/kjhealy/latex-custom-kjh) and Andrew Heiss's [Hikmah template](https://github.com/andrewheiss/hikmah-academic-quarto).
