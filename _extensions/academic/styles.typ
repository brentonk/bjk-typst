// Shared document-level styling for the bjk-academic template family.
//
// `base-styles` bundles the set/show rules that define the common typographic
// identity (fonts, paragraph, headings, links, figure captions, references,
// bibliography). `article()` (article-template.typ), `syllabus()`
// (syllabus-template.typ), and `simple()` (simple-template.typ) all apply it
// via `show: base-styles.with(...)`, so aesthetic changes only need to be made
// once.

#import "macros.typ": *

#let base-styles(
  lang: "en",
  region: "US",
  font: "libertinus serif",
  fontsize: 12pt,
  sansfont: "Fira Sans",
  mathfont: "Libertinus Math",
  link-color: rgb("#483d8b"),
  sectionnumbering: none,
  body,
) = {
  set par(justify: true, leading: 0.9em, spacing: 1.6em)
  set text(
    lang: lang,
    region: region,
    font: font,
    size: fontsize,
  )
  show math.equation: set text(font: mathfont)

  // Equation numbering: only labelled block equations get a number
  set math.equation(numbering: "(1)", supplement: [Equation])
  show math.equation: set block(breakable: true)
  show math.equation.where(block: true, numbering: "(1)"): it => {
    if not it.has("label") {
      counter(math.equation).update(v => v - 1)
      math.equation(block: true, numbering: none, it.body)
    } else { it }
  }

  // Theorion theorem rendering + numbering depth (e.g., 1.2 = section 1, 2nd theorem)
  show: show-theorion
  set-inherited-levels(1)
  set heading(numbering: sectionnumbering)
  show heading: it => {
    set text(font: sansfont, weight: "bold")
    if it.numbering != none {
      // LaTeX-style alignment: number + gap, with wrapped lines indented past the number
      let num = counter(heading).display(it.numbering)
      let gap = 0.75em
      let num-width = measure(num).width + gap
      block(above: 1.2em, below: 0.9em, pad(left: num-width)[
        #h(-num-width)#num#h(gap)#it.body
      ])
    } else {
      block(above: 1.2em, below: 0.9em, it.body)
    }
  }

  show figure.caption: it => context align(center, block(width: 90%, inset: (bottom: 0.6em))[
    #set text(font: sansfont, size: 0.8em)
    #show math.equation: set text(size: 1.15em)
    #if it.supplement == [Figure] {
      set align(left)
      text(weight: "bold")[#it.supplement #it.counter.display(it.numbering): ]
      it.body
    } else {
      text(weight: "bold")[#it.supplement #it.counter.display(it.numbering): ]
      it.body
    }
  ])

  show footnote.entry: it => {
    show math.equation.where(block: true): set block(above: 0.7em, below: 0.7em)
    it
  }

  show ref: it => {
    let eq = math.equation
    let el = it.element
    if el == none {
      it
    } else if el.func() == eq {
      set text(fill: link-color)
      it
    } else if el.func() == figure and type(el.kind) != str {
      [#el.supplement~#link(el.location(), text(fill: link-color, numbering(el.numbering, ..el.counter.at(el.location()))))]
    } else {
      it
    }
  }

  show link: set text(fill: link-color)
  set bibliography(title: "References", style: "chicago-author-date")

  body
}
