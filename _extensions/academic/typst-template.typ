#import "@preview/fontawesome:0.6.0": *

#let article(
  // Document metadata
  title: none,
  subtitle: none,
  authors: (
    (
      name: "Brenton Kenkel",
      affiliation: "Vanderbilt University",
      email: "brenton.kenkel@vanderbilt.edu",
      orcid: [0000-0001-5815-6292],
    ),
  ),
  date: datetime.today().display("[month repr:long] [day padding:none], [year]"),
  abstract: none,
  abstract-title: "ABSTRACT",
  // PDF Metadata
  title-meta: none,
  author-meta: none,
  keywords-meta: none,
  date-meta: none,
  // Custom document metadata
  header: none,
  code-repo: none,
  keywords: none,
  custom-keywords: none,
  thanks: none,
  // Layout settings
  margin: (x: 1.25in, y: 1.25in),
  paper: "us-letter",
  // Typography settings
  lang: "en",
  region: "US",
  font: "libertinus serif",
  fontsize: 12pt,
  sansfont: "Fira Sans",
  mathfont: "Libertinus Math",
  link-color: rgb("#483d8b"),
  // Structure settings
  sectionnumbering: none,
  pagenumbering: "1",
  titlepage: false,
  toc: false,
  cols: 1,
  doc,
) = {
  set document(
    ..if title-meta != none { (title: title-meta) },
    ..if author-meta != none { (author: author-meta) },
    ..if keywords-meta != none { (keywords: keywords-meta) },
    ..if date-meta != none { (date: date-meta) },
  )
  set page(
    paper: paper,
    margin: margin,
    numbering: if titlepage { none } else { pagenumbering },
  )
  set par(justify: true, leading: 0.7em)
  set text(
    lang: lang,
    region: region,
    font: font,
    size: fontsize,
  )
  show math.equation: set text(font: mathfont)
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
      it
    }
  }

  show figure.caption: it => context align(center, block(width: 90%)[
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
      el.supplement
      link(el.location())[
        #set text(fill: link-color)
        #numbering(el.numbering, ..el.counter.at(el.location()))
      ]
    } else {
      it
    }
  }

  show link: set text(fill: link-color)
  set bibliography(title: "References")

  if date != none {
    align(left)[#block()[
        #text(weight: "bold", font: sansfont, size: 0.8em)[
          #date
          #if header != none {
            h(3em)
            text(weight: "regular")[#header]
          }
        ]
      ]]
  }

  if code-repo != none {
    align(left)[#block()[
        #text(weight: "regular", font: sansfont, size: 0.8em)[
          #code-repo
        ]
      ]]
  }

  if title != none {
    align(left)[#block(above: 4em, below: 2em)[
        #text(weight: "bold", size: 1.5em, font: sansfont)[
          #title
          #if thanks != none {
            footnote(numbering: "*", thanks)
            counter(footnote).update(0)
          }\
          #if subtitle != none {
            text(weight: "regular", style: "italic", size: 0.8em)[#subtitle]
          }
        ]
      ]]
  }

  if authors != none {
    let count = authors.len()
    let ncols = calc.min(count, 3)
    grid(
      columns: (1fr,) * ncols,
      row-gutter: 1.5em,
      ..authors.map(author => align(left)[
        #text(size: 1.2em, font: sansfont)[#author.name]
        #if author.orcid != [] {
          link("https://orcid.org/" + author.orcid.text)[
            #set text(size: 0.85em, fill: rgb("a6ce39"))
            #fa-orcid()
          ]
        } \
        #text(size: 0.85em, font: sansfont)[#author.affiliation] \
        #text(size: 0.7em, font: sansfont, fill: link-color)[
          #let email-str = if type(author.email) == str { author.email } else { author.email.children.map(e => e.text).join() }
          #link("mailto:" + email-str)[#author.email]
        ]
      ])
    )
  }

  if abstract != none {
    v(2em)
    block(inset: 2em)[
      #set text(size: 0.9em)
      #text(weight: "bold", font: sansfont, size: 0.9em)[#abstract-title] #h(0.5em)
      #text(font: sansfont)[#abstract]
      #if keywords != none {
        parbreak()
        text(weight: "bold", font: sansfont, size: 0.9em)[Keywords:]
        h(0.5em)
        text(font: sansfont)[#keywords]
      }
      #if custom-keywords != none {
        for it in custom-keywords {
          text(weight: "bold", font: sansfont, size: 0.9em)[\ #it.name:]
          h(0.5em)
          text(font: sansfont)[#it.values]
        }
      }
    ]
  }

  if toc {
    block(above: 0em, below: 2em)[
      #outline(
        title: auto,
        depth: none,
      );
    ]
  }

  if titlepage {
    pagebreak()
    counter(page).update(1)
    set page(numbering: pagenumbering)
    if cols == 1 {
      doc
    } else {
      columns(cols, doc)
    }
  } else if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}

#let appendix(sansfont: "Fira Sans", newpage: true, reset-page-numbering: true, content) = {
  // Reset Numbering
  set heading(numbering: "A.1.1", supplement: [Appendix])
  counter(heading).update(0)
  counter(figure.where(kind: "quarto-float-fig")).update(0)
  counter(figure.where(kind: "quarto-float-tbl")).update(0)
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)

  // Figure & Table Numbering
  set figure(
    numbering: it => {
      [A.#it]
    },
  )

  // Appendix Start
  if newpage {
    pagebreak(weak: true)
    if reset-page-numbering {
      counter(page).update(1)
    }
  }
  text(size: 2em, font: sansfont, weight: "bold")[Appendix]
  content
}
