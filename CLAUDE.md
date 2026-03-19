# bjk-typst

Academic article template that works as both a standalone Typst template and a Quarto extension.

## Architecture

All styling is defined in `_extensions/academic/typst-template.typ` (the `article()` and `appendix()` functions). This is the single source of truth — both usage paths import from here:

- **Typst path:** `lib.typ` re-exports → standalone `.typ` files import `@local/bjk-academic:0.1.0`
- **Quarto path:** `typst-show.typ` maps YAML metadata to `article()` params using Mustache syntax

## Key files

- `_extensions/academic/typst-template.typ` — core template, edit this for aesthetic changes
- `_extensions/academic/typst-show.typ` — Quarto-specific YAML-to-Typst bridge (Mustache syntax, not pure Typst)
- `_extensions/academic/shortcodes.lua` — Quarto `{{< appendix >}}` shortcode
- `lib.typ` — one-line re-export for standalone Typst usage
- `typst.toml` — Typst package manifest
- `template/main.typ` — standalone Typst starter example

## Building

```bash
# Standalone Typst
typst compile template/main.typ --root . --font-path static/fonts

# Quarto (requires R packages via renv)
quarto render template.qmd
```

## Local package symlink

The repo is symlinked as a local Typst package at:
`~/.local/share/typst/packages/local/bjk-academic/0.1.0/`

Bump the version in `typst.toml` and the symlink directory name together.
