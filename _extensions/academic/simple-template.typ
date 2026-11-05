// Minimal offshoot of the bjk-academic article template, for referee reports,
// memos, and other quick documents.
//
// `simple()` applies the shared typographic identity (via `base-styles`) with
// none of the article's masthead machinery: no author grid, abstract,
// keywords, thanks, or title page. It optionally renders a modest title (bold
// sans, only slightly larger than a level-1 heading) beneath a small
// author/date line. The math/text/theorem macros are imported here, as in
// `article()`, so the Quarto partial can expose them with a wildcard import.

#import "macros.typ": *
#import "styles.typ": base-styles

#let simple(
  // Document metadata (all optional)
  title: none,
  author: none,
  date: none,
  // PDF metadata
  title-meta: none,
  author-meta: none,
  // Layout settings
  margin: (x: 1.25in, y: 1.25in),
  paper: "us-letter",
  // Typography settings
  lang: "en",
  region: "US",
  font: "libertinus serif",
  fontsize: 11pt,
  sansfont: "Fira Sans",
  mathfont: "Libertinus Math",
  link-color: rgb("#483d8b"),
  // Structure settings
  sectionnumbering: none,
  pagenumbering: "1",
  toc: false,
  doc,
) = {
  set document(
    ..if title-meta != none { (title: title-meta) } else if title != none { (title: title) },
    // `document(author:)` only accepts strings, so content authors need an
    // explicit `author-meta`.
    ..if author-meta != none { (author: author-meta) } else if type(author) == str { (author: author) },
  )
  set page(
    paper: paper,
    margin: margin,
    numbering: pagenumbering,
  )

  show: base-styles.with(
    lang: lang,
    region: region,
    font: font,
    fontsize: fontsize,
    sansfont: sansfont,
    mathfont: mathfont,
    link-color: link-color,
    sectionnumbering: sectionnumbering,
  )

  // Author/date line, in the same idiom as the article's date line: small
  // bold sans, with the date in regular weight when it follows an author.
  if author != none or date != none {
    block(below: 0.8em)[
      #text(weight: "bold", font: sansfont, size: 0.8em)[
        #author
        #if author != none and date != none { h(3em) }
        #if date != none { text(weight: "regular")[#date] }
      ]
    ]
  }

  // Modest title: bold sans a notch above a level-1 heading (Typst's default
  // is 1.4em), with tight spacing so it reads as a heading rather than as the
  // paper masthead.
  if title != none {
    block(above: 0.8em, below: 1.4em)[
      #set par(leading: 0.5em, justify: false)
      #text(weight: "bold", size: 1.6em, font: sansfont)[#title]
    ]
  }

  if toc {
    block(above: 0em, below: 2em)[
      #outline(title: auto, depth: none)
    ]
  }

  doc
}
