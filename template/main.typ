// Standalone Typst starter template for bjk-academic.
//
// Usage from this repo:
//   typst compile template/main.typ --font-path static/fonts
//
// Usage as a local package (after symlinking into
// ~/.local/share/typst/packages/local/bjk-academic/0.1.0/):
//   #import "@local/bjk-academic:0.1.0": article, appendix

#import "../lib.typ": article, appendix

#show: article.with(
  title: "Paper Title",
  authors: (
    (
      name: "Author Name",
      affiliation: "University",
      email: "author@example.com",
      orcid: [],
    ),
  ),
  date: "2026",
  abstract: [
    This is an example abstract for the standalone Typst template.
  ],
  keywords: [keyword one, keyword two],
  sectionnumbering: "1.1.1",
)

= Introduction

#lorem(80)

= Methods

#lorem(100)

== Subsection

#lorem(60)

= Results

#lorem(80)

#show: appendix

= Additional Details

#lorem(60)
