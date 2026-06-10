# bjk-academic

An academic article template — plus a matching course-syllabus offshoot — usable as both standalone Typst templates and Quarto extensions. Forked from [kazuyanagimoto/quarto-academic-typst](https://github.com/kazuyanagimoto/quarto-academic-typst).

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

The shared typographic identity lives in `_extensions/academic/styles.typ` (the `base-styles()` helper). Both `article()` (in `article-template.typ`) and `syllabus()` (in `syllabus-template.typ`) apply it, so cross-cutting aesthetic changes only need to be made once. Edit the individual function files for masthead/front-matter changes specific to one document type.

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

- `typst-show.typ` — maps Quarto YAML metadata to the template function (Mustache/Pandoc template syntax)
- `typst-template.typ` — thin template partial that imports the implementation from `_extensions/academic/`; assumes the rendered document lives at the project root, alongside `_extensions/`
- `shortcodes.lua` — provides `{{< appendix >}}` shortcode
- `_extension.yml` — Quarto extension metadata

## Building examples

```bash
make                 # build all four examples
make typst           # standalone Typst article only
make quarto          # Quarto article only
make syllabus-typst  # standalone Typst syllabus only
make syllabus-quarto # Quarto syllabus only
make clean           # remove generated PDFs
```

## Repo structure

```
bjk-typst/
├── lib.typ                          # Typst package entrypoint (re-exports article, appendix, syllabus, …)
├── typst.toml                       # Typst package manifest
├── Makefile                         # Build example PDFs
├── template/
│   ├── main.typ                     # Standalone Typst article starter
│   ├── example_syllabus.typ         # Standalone Typst syllabus example
│   └── syllabus-references.bib      # Bibliography for the syllabus example
├── _extensions/academic/
│   ├── styles.typ                   # Shared base-styles() (single source of aesthetics)
│   ├── article-template.typ         # article() / appendix()
│   ├── syllabus-template.typ        # syllabus()
│   ├── macros.typ                   # Math/text/theorem macros
│   ├── typst-template.typ           # Thin partial: imports article() / appendix()
│   ├── typst-show.typ               # Quarto YAML → article() bridge
│   ├── shortcodes.lua               # Quarto shortcodes
│   └── _extension.yml               # academic-typst extension metadata
├── _extensions/syllabus/
│   ├── typst-template.typ           # Thin partial: imports syllabus()
│   ├── typst-show.typ               # Quarto YAML → syllabus() bridge
│   └── _extension.yml               # syllabus-typst extension metadata
├── static/fonts/                    # Bundled fonts (Fira Sans, Libertinus)
├── template.qmd                     # Quarto article example
├── syllabus.qmd                     # Quarto syllabus example
└── references.bib                   # Example bibliography (article)
```

## Credits

Original template by [Kazuharu Yanagimoto](https://github.com/kazuyanagimoto), inspired by Kieran Healy's [LaTeX template](https://github.com/kjhealy/latex-custom-kjh) and Andrew Heiss's [Hikmah template](https://github.com/andrewheiss/hikmah-academic-quarto).
