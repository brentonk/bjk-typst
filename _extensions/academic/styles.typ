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
  fontsize: 11pt,
  sansfont: "Fira Sans",
  mathfont: "Libertinus Math",
  link-color: rgb("#483d8b"),
  sectionnumbering: none,
  indent: true,
  body,
) = {
  set par(justify: true, leading: 0.9em)
  // LaTeX-style paragraphs: first-line indent, no extra gap between
  // paragraphs. Typst indents only a paragraph that directly follows another
  // paragraph, so text after a heading, display equation, list, or figure
  // starts flush left. That is right for text continuing a sentence after an
  // equation, but a genuinely new paragraph after a list or equation needs a
  // manual `#indent` (see macros.typ). Theorem boxes are handled below.
  set par(spacing: 0.9em, first-line-indent: 1.5em) if indent
  // Block paragraphs (parskip style), used by the syllabus.
  set par(spacing: 1.6em) if not indent
  // With no gap between paragraphs, set lists off from the surrounding text
  // (like LaTeX's \topsep) so a flush-left paragraph after a list doesn't read
  // as part of it. Wide lists (blank lines between items) get a little space
  // between items; tight lists keep plain line spacing. Paragraph spacing
  // drives a list's item spacing, so it is set via `par` inside the list.
  show list: set block(above: 1.4em, below: 1.4em) if indent
  show enum: set block(above: 1.4em, below: 1.4em) if indent
  show terms: set block(above: 1.4em, below: 1.4em) if indent
  show list: set par(spacing: 1.25em) if indent
  show enum: set par(spacing: 1.25em) if indent
  show terms: set par(spacing: 1.25em) if indent
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
  // Turn off theorion's indent repair. With the default mode it puts an
  // invisible paragraph at the end of every box's body. That can't affect
  // anything outside the box, and when a box ends right at the bottom of a
  // page the invisible line gets pushed to the next page, leaving an empty
  // strip of box colour at the top of it.
  set-indent-mode(none)

  // Indent the paragraph after a theorem box, as LaTeX does. An invisible
  // zero-height paragraph goes after the box (with its spacing cancelled), so
  // Typst sees the next paragraph as following a paragraph. This is theorion's
  // `indent-fakepar`, copied because that one is disabled by the indent mode
  // above. Kinds are the clouds frame identifiers. Must come after
  // `show: show-theorion`: theorion's rule replaces each frame figure with its
  // body, so a figure rule set before it would never fire.
  let theorem-kinds = (
    "theorem", "lemma", "corollary", "definition", "axiom", "postulate",
    "proposition", "assumption", "property", "conjecture", "remark", "note",
    "example", "exercise", "problem",
  )
  let fake-par = context {
    let b = par(box())
    b
    v(-measure(b + b).height)
  }
  show figure: it => {
    if indent and type(it.kind) == str and it.kind in theorem-kinds {
      it
      fake-par
    } else { it }
  }
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
