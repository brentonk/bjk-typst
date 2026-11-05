# bjk-typst

Academic article + course-syllabus + simple-document (memo / referee report) templates that work as both standalone Typst templates and Quarto extensions.

## Architecture

The shared typographic identity (fonts, paragraph/heading styling, links, figure captions, references, bibliography) lives in `_extensions/academic/styles.typ` as `base-styles()`. All document types apply it via `show: base-styles.with(...)`, so aesthetic changes only need to be made once. `base-styles()` takes `indent: true` (LaTeX-style paragraphs: 1.5em first-line indent, paragraph spacing equal to the leading, extra space above/below lists); the syllabus passes `indent: false` to keep block paragraphs. `base-styles()` contains no page setup or masthead; each document function supplies its own `set page` and front matter.

Three document types build on it:

- **Article** — `article()`/`appendix()` in `_extensions/academic/article-template.typ`.
- **Syllabus** — `syllabus()` in `_extensions/academic/syllabus-template.typ`. Same identity as the article, but with a course title / number / institution / semester / instructor masthead (the `number`/`institution`/`semester` fields compose the course-meta line beneath the title, closed off by a hairline rule; no abstract/keywords/author-grid/theorems) and light schedule-table styling. Optional logistics metadata renders as a compact key–value grid in the masthead with symmetric Meetings / Instructor / Teaching assistant rows: `time`/`place` form the Meetings row, the instructor and each of `tas` get a name + email row with their office hours on a muted second line. `office-hours` is the instructor's; `tas` is an array of `(name:, email:, office-hours:)` dicts. Grading and the schedule are written as ordinary body sections. Values with dashes should be passed as content (`[2:20--3:45pm]`) so Typst converts them; the Quarto bridge wraps values in `[...]` automatically.
- **Simple** — `simple()` in `_extensions/academic/simple-template.typ`. Same identity, no masthead infrastructure: for referee reports, memos, and other quick documents. Optional `title` renders as a modest bold-sans block (1.6em, just above Typst's 1.4em default level-1 heading, tight spacing) beneath an optional small `author`/`date` line in the article's date-line idiom; all three default to `none`, so `#show: simple` gives a bare styled body. Paragraph spacing is inherited from `base-styles()` unchanged. `macros.typ` is imported (as in the article) so theorems and math macros are available and the Quarto partial can wildcard-import them. PDF metadata falls back to `title`/`author`, the latter only when `author` is a string.

Each type has both usage paths:

- **Typst path:** `lib.typ` re-exports `article`, `appendix`, `syllabus`, `simple`, … → standalone `.typ` files import `@local/bjk-academic:0.1.0`
- **Quarto path:** each format directory's `typst-show.typ` maps YAML metadata to the relevant function using Mustache syntax. `_extensions/academic/` contributes `academic-typst`; `_extensions/syllabus/` contributes `syllabus-typst`; `_extensions/simple/` contributes `simple-typst`.

Typst indents only a paragraph that directly follows another paragraph, so a new paragraph right after a list or display equation is flush left; it can't be distinguished from text continuing a sentence after an equation. `#indent` (in `macros.typ`, exported from `lib.typ`) adds a manual indent matching `par.first-line-indent`; Quarto documents use the `{{< indent >}}` shortcode (`shortcodes.lua`, registered for the academic and simple formats and at the academic extension's top level so it emits nothing in other formats). The examples demonstrate it after a list. Paragraphs after theorem boxes are indented automatically: a `show figure` rule in `base-styles()` appends an invisible zero-height paragraph (with its spacing cancelled; a copy of theorion's `indent-fakepar`) after each theorion frame figure. That rule must come after `show: show-theorion`, whose own figure rule replaces the figure with its body. `base-styles()` also calls `set-indent-mode(none)`: theorion's default mode puts a similar invisible paragraph *inside* each box, which does nothing useful and, when a box ends right at the bottom of a page, gets pushed to the next page as an empty strip of box colour.

In Quarto documents, write run-in paragraph lead-ins as `[Lead-in.]{.paragraph}` spans. The `paragraph.lua` filter (auto-applied in all three Typst formats) converts them to the `paragraph()` macro from `macros.typ` (Fira Sans bold run-in); in any other format they degrade to plain bold, keeping documents portable to HTML/gfm. To get the bold fallback when rendering a non-Typst format, add `filters: [academic]` to the document YAML (the academic extension also contributes the filter standalone).

Each format's `typst-template.typ` is a thin partial that imports the implementation via a `_extensions/academic/...` path. Because partials are spliced into the intermediate `.typ` next to the rendered document, those imports resolve relative to the document's directory — so Quarto documents using these formats must live at the project root, alongside `_extensions/`. (This replaced an earlier `format-resources` approach, which littered the document directory with copies of `macros.typ`/`styles.typ`/`syllabus-template.typ` after every render.)

## Key files

- `_extensions/academic/styles.typ` — shared `base-styles()`; edit this for cross-cutting aesthetic changes
- `_extensions/academic/article-template.typ` — `article()`/`appendix()`
- `_extensions/academic/syllabus-template.typ` — `syllabus()`
- `_extensions/academic/simple-template.typ` — `simple()`
- `_extensions/academic/macros.typ` — math/text/theorem macros
- `_extensions/academic/paragraph.lua` — `[...]{.paragraph}` span → `paragraph()` (Typst) / bold (other formats)
- `_extensions/academic/typst-template.typ` — thin Quarto partial; wildcard-imports `article-template.typ`
- `_extensions/academic/typst-show.typ` — Quarto YAML→`article()` bridge (Mustache, not pure Typst)
- `_extensions/syllabus/{_extension.yml,typst-template.typ,typst-show.typ}` — Quarto `syllabus-typst` format
- `_extensions/simple/{_extension.yml,typst-template.typ,typst-show.typ}` — Quarto `simple-typst` format
- `_extensions/academic/shortcodes.lua` — Quarto `{{< appendix >}}` and `{{< indent >}}` shortcodes
- `lib.typ` — one-line re-exports for standalone Typst usage
- `typst.toml` — Typst package manifest
- `template/main.typ` — standalone article starter; `template/example_syllabus.typ` — standalone syllabus example; `template/example_simple.typ` — standalone simple-document example (placeholder content)
- `template.qmd`, `syllabus.qmd`, `simple.qmd` — Quarto examples; must stay at the repo root (see above)

## Building

```bash
make                 # build all six examples
make typst           # standalone Typst article only
make quarto          # Quarto article only
make syllabus-typst  # standalone Typst syllabus only
make syllabus-quarto # Quarto syllabus only
make simple-typst    # standalone Typst simple document only
make simple-quarto   # Quarto simple document only
make clean           # remove generated PDFs + copied resource artifacts
```

Output goes to `template/example_typst.pdf`, `template/example_quarto.pdf`, `template/example_syllabus.pdf`, `template/example_syllabus_quarto.pdf`, `template/example_simple.pdf`, and `template/example_simple_quarto.pdf`.

## Local package symlink

The repo is symlinked as a local Typst package at:
`~/.local/share/typst/packages/local/bjk-academic/0.1.0/`

Bump the version in `typst.toml` and the symlink directory name together.

## Pre-commit checklist

Before committing, review CLAUDE.md and README.md to ensure they reflect any changes made (new parameters, changed defaults, structural changes, etc.).
