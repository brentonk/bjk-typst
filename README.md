# bjk-academic

An academic article template — plus matching course-syllabus and simple-document (memo / referee report) offshoots — usable as both standalone Typst templates and Quarto extensions. Forked from [kazuyanagimoto/quarto-academic-typst](https://github.com/kazuyanagimoto/quarto-academic-typst).

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

## Syllabus

The same typographic identity is available as a course-syllabus template. It
swaps the article masthead for a course title / course-meta block over an
optional logistics grid (meetings, instructor, teaching assistants), drops the
abstract / keywords / author grid / theorem machinery, and adds light
schedule-table styling. Grading and the schedule are written as ordinary body
sections.

### Standalone Typst

```typ
#import "@local/bjk-academic:0.1.0": syllabus

#show: syllabus.with(
  title: "War and State Development",
  number: "PSCI 2227",
  institution: "Vanderbilt University",
  semester: "Spring 2026",
  instructor: "Professor Brenton Kenkel",
  email: "brenton.kenkel@vanderbilt.edu",
  time: [Mondays & Wednesdays, 2:20--3:45pm],
  place: "Alumni Hall 201",
  office-hours: [Tuesdays 2:00--3:30pm, Commons Center 326],
  tas: (
    (
      name: "Seungho Song",
      email: "seung.ho.song@vanderbilt.edu",
      office-hours: [Fridays 3:00--4:30pm, Commons 317],
    ),
  ),
)

= Grading
...
```

`syllabus()` parameters: `title`, `number`, `institution`, `semester`,
`instructor`, `email`, `time`, `place`, `office-hours`, `tas`, `date`, `header`,
`margin`, `paper`, `font`/`fontsize`/`sansfont`/`mathfont`, `link-color`,
`sectionnumbering`, `toc`.

- `number`, `institution`, and `semester` are joined with middots (in that
  order, omitting any that are absent) into the course-meta line beneath the
  title, and a hairline rule closes the masthead off from the body.
- `time`/`place`, the instructor, and `tas` render as a compact key–value
  logistics grid in the masthead (Meetings / Instructor / Teaching assistant
  rows); rows with no content are omitted. `office-hours` is the instructor's,
  shown on a muted line beneath their name; `tas` is an array of
  `(name:, email:, office-hours:)` dictionaries (`email`/`office-hours` each
  optional, shown the same way).
- Pass values that contain dashes as **content** (`[2:20--3:45pm]`) rather than
  strings (`"2:20--3:45pm"`) so Typst converts `--`/`---` to en/em dashes. (In
  Quarto YAML this happens automatically.)

See `template/example_syllabus.typ` for a complete working example.

### Quarto

Use `format: syllabus-typst`. The instructor comes from the first `author`
entry's `name`/`email`; logistics are top-level keys:

```yaml
---
title: "War and State Development"
number: "PSCI 2227"
institution: "Vanderbilt University"
semester: "Spring 2026"
author:
  - name: Professor Brenton Kenkel
    email: brenton.kenkel@vanderbilt.edu
time: "Mondays & Wednesdays, 2:20--3:45pm"
place: "Alumni Hall 201"
office-hours: "Tuesdays 2:00--3:30pm, Commons Center 326"
tas:
  - name: Seungho Song
    email: seung.ho.song@vanderbilt.edu
    office-hours: "Fridays 3:00--4:30pm, Commons 317"
format:
  syllabus-typst:
    font-paths: ["static/fonts"]
---
```

See `syllabus.qmd` for a complete example.

## Simple documents

For referee reports, memos, and other quick documents, `simple()` applies the
same typographic identity with none of the article's masthead machinery: no
author grid, abstract, keywords, thanks, or title page. It optionally renders a
modest title (bold Fira Sans, only slightly larger than a level-1 heading) with
a small author/date line above it, and otherwise starts the body at the top of
the page. The math/text/theorem macros are available exactly as in the article.

### Standalone Typst

```typ
#import "@local/bjk-academic:0.1.0": simple

#show: simple.with(
  title: "Referee Report: Manuscript 1234",
  author: "Reviewer 2",
  date: "September 2026",
)

= Summary
...
```

`simple()` parameters: `title`, `author`, `date`, `title-meta`, `author-meta`,
`margin`, `paper`, `font`/`fontsize`/`sansfont`/`mathfont`, `link-color`,
`sectionnumbering`, `pagenumbering`, `toc`.

- `title`, `author`, and `date` are all optional and default to `none`; unlike
  the article, no date is printed unless you pass one. `#show: simple` with no
  arguments gives a bare styled document.
- The PDF metadata falls back to `title` and `author` when `title-meta` /
  `author-meta` are not given. `document(author:)` only accepts strings, so
  pass `author-meta` explicitly if `author` is content.

See `template/example_simple.typ` for a complete working example.

### Quarto

Use `format: simple-typst`. `title`, `author`, and `date` map straight
through; multiple authors are joined with commas on the author line:

```yaml
---
title: "Referee Report: Manuscript 1234"
author: "Reviewer 2"
date: today
date-format: long
format:
  simple-typst:
    font-paths: ["static/fonts"]
---
```

See `simple.qmd` for a complete example.

## Paragraphs and manual indents

Articles and simple documents use LaTeX-style paragraphs: a 1.5em first-line
indent and no extra space between paragraphs. Lists get a little space above
and below so they stand apart from the text around them. The syllabus keeps
block paragraphs (a gap between paragraphs, no indent).

Typst indents a paragraph only when it directly follows another paragraph. So
a paragraph that comes right after a heading, display equation, list, or
figure starts flush left. That is what you want after a heading or figure, and
for text that continues a sentence after an equation ("…where $x$ is…"). But a
new paragraph right after a list or equation also starts flush left, which can
make it look like a continuation. Unlike LaTeX, Typst can't tell the two apart
by a blank line in the source.

The paragraph after a theorem box (lemma, proposition, definition, …) is
indented automatically, since text after a theorem almost always starts a new
paragraph. A proof that follows a theorem stays flush left.

For those cases, start the paragraph with a manual indent:

```typ
- First case.
- Second case.

#indent Finally, the remaining case …
```

In Quarto, use the shortcode (it emits nothing in non-Typst formats):

```markdown
{{< indent >}} Finally, the remaining case …
```

Use it only where the paragraph would otherwise be flush left. After an
ordinary paragraph Typst already indents, so `#indent` there doubles the
indent.

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

The shared typographic identity lives in `_extensions/academic/styles.typ` (the `base-styles()` helper). `article()` (in `article-template.typ`), `syllabus()` (in `syllabus-template.typ`), and `simple()` (in `simple-template.typ`) all apply it, so cross-cutting aesthetic changes only need to be made once. Edit the individual function files for masthead/front-matter changes specific to one document type.

### Key parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| `font` | `"libertinus serif"` | Body font |
| `sansfont` | `"Fira Sans"` | Heading/UI font |
| `mathfont` | `"Libertinus Math"` | Math font |
| `fontsize` | `11pt` | Base font size |
| `link-color` | `rgb("#483d8b")` | Link/reference color |
| `margin` | `(x: 1.25in, y: 1.25in)` | Page margins |
| `paper` | `"us-letter"` | Paper size |
| `sectionnumbering` | `none` | Section numbering format (e.g. `"1.1.1"`) |
| `titlepage` | `false` | Separate title page with content starting on page 1 |
| `cols` | `1` | Number of columns |

### Quarto-only files

- `typst-show.typ` — maps Quarto YAML metadata to the template function (Mustache/Pandoc template syntax)
- `typst-template.typ` — thin template partial that imports the implementation from `_extensions/academic/`; assumes the rendered document lives at the project root, alongside `_extensions/`
- `shortcodes.lua` — provides the `{{< appendix >}}` and `{{< indent >}}` shortcodes
- `_extension.yml` — Quarto extension metadata

## Building examples

```bash
make                 # build all six examples
make typst           # standalone Typst article only
make quarto          # Quarto article only
make syllabus-typst  # standalone Typst syllabus only
make syllabus-quarto # Quarto syllabus only
make simple-typst    # standalone Typst simple document only
make simple-quarto   # Quarto simple document only
make clean           # remove generated PDFs
```

## Repo structure

```
bjk-typst/
├── lib.typ                          # Typst package entrypoint (re-exports article, appendix, syllabus, simple, …)
├── typst.toml                       # Typst package manifest
├── Makefile                         # Build example PDFs
├── template/
│   ├── main.typ                     # Standalone Typst article starter
│   ├── example_syllabus.typ         # Standalone Typst syllabus example
│   ├── example_simple.typ           # Standalone Typst simple-document example
│   └── syllabus-references.bib      # Bibliography for the syllabus example
├── _extensions/academic/
│   ├── styles.typ                   # Shared base-styles() (single source of aesthetics)
│   ├── article-template.typ         # article() / appendix()
│   ├── syllabus-template.typ        # syllabus()
│   ├── simple-template.typ          # simple()
│   ├── macros.typ                   # Math/text/theorem macros
│   ├── typst-template.typ           # Thin partial: imports article() / appendix()
│   ├── typst-show.typ               # Quarto YAML → article() bridge
│   ├── shortcodes.lua               # Quarto shortcodes
│   └── _extension.yml               # academic-typst extension metadata
├── _extensions/syllabus/
│   ├── typst-template.typ           # Thin partial: imports syllabus()
│   ├── typst-show.typ               # Quarto YAML → syllabus() bridge
│   └── _extension.yml               # syllabus-typst extension metadata
├── _extensions/simple/
│   ├── typst-template.typ           # Thin partial: imports simple() + macros
│   ├── typst-show.typ               # Quarto YAML → simple() bridge
│   └── _extension.yml               # simple-typst extension metadata
├── static/fonts/                    # Bundled fonts (Fira Sans, Libertinus)
├── template.qmd                     # Quarto article example
├── syllabus.qmd                     # Quarto syllabus example
├── simple.qmd                       # Quarto simple-document example
└── references.bib                   # Example bibliography (article)
```

## Credits

Original template by [Kazuharu Yanagimoto](https://github.com/kazuyanagimoto), inspired by Kieran Healy's [LaTeX template](https://github.com/kjhealy/latex-custom-kjh) and Andrew Heiss's [Hikmah template](https://github.com/andrewheiss/hikmah-academic-quarto).
