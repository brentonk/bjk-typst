// Course-syllabus offshoot of the bjk-academic article template.
//
// `syllabus()` shares the typographic identity of `article()` (via
// `base-styles`) but swaps the article masthead for a course title / number /
// institution / semester / instructor block, drops the abstract / keyword /
// author-grid machinery, and adds light schedule-table styling. Optional
// logistics metadata (meeting time/place, office hours, teaching assistants)
// renders as a compact key–value block in the masthead; grading and the
// schedule are written as ordinary body sections.

#import "styles.typ": base-styles

// Extract a bare email address string from a str or content value, so it can
// seed a `mailto:` link regardless of whether it arrived from Typst or Quarto.
#let _addr-str(addr) = {
  if type(addr) == str { addr } else if addr.has("text") { addr.text } else if addr.has("children") {
    addr.children.map(e => if e.has("text") { e.text } else { "" }).join()
  } else { "" }
}

#let syllabus(
  // Course metadata
  title: none,
  number: none,
  institution: none,
  semester: none,
  instructor: none,
  email: none,
  // Logistics metadata (optional)
  time: none,
  place: none,
  office-hours: none,
  tas: (),
  date: none,
  header: none,
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
  fontsize: 12pt,
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
    ..if author-meta != none { (author: author-meta) } else if instructor != none { (author: instructor) },
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

  // Tighter line spacing than the article — a syllabus is a denser reference
  // document, not an airy paper — but keep a clear gap between paragraphs.
  set par(leading: 0.65em, spacing: 1em)

  // Schedule-table styling: Fira Sans bold header bounded by booktabs-style
  // rules, no vertical lines.
  set table(
    stroke: (_, y) => if y == 0 { (top: 0.7pt + black, bottom: 0.7pt + black) },
    inset: (x: 0.6em, y: 0.5em),
    align: left + top,
  )
  show table.cell.where(y: 0): set text(font: sansfont, weight: "bold", size: 0.9em)

  // Masthead
  if date != none or header != none {
    align(left)[#block()[
        #text(weight: "bold", font: sansfont, size: 0.8em)[
          #date
          #if date != none and header != none { h(3em) }
          #if header != none { text(weight: "regular")[#header] }
        ]
      ]]
  }

  if title != none {
    block(above: 3.4em, below: 1.3em)[
      #text(weight: "bold", size: 1.7em, font: sansfont)[#title]
    ]
    // Compose the course-meta line from whichever fields are provided.
    let subtitle-parts = (number, institution, semester).filter(p => p != none)
    if subtitle-parts.len() > 0 {
      block(above: 1.3em, below: 1.8em)[
        #text(weight: "regular", size: 1.05em, font: sansfont, fill: luma(90))[
          #subtitle-parts.map(p => [#p]).join([ · ])
        ]
      ]
    }
  }

  // A single email size, applied to the instructor and TA emails alike, so they
  // never disagree. Sized relative to the masthead body, not nested under a
  // larger run, so no compounding shrinks one below the other.
  let email-size = 0.85em
  let mailto-link(addr) = text(size: email-size, font: sansfont, fill: link-color)[
    #link("mailto:" + _addr-str(addr))[#addr]
  ]

  // Logistics block: a compact key–value grid. The instructor and teaching
  // assistants are symmetric rows — name + email, with that person's office
  // hours on a muted second line. Only rows with content are shown.
  let val-size = 0.95em

  // One person's cell: name, optional email, optional office hours beneath.
  let person-cell(name, mail, oh) = {
    let c = text(size: val-size)[#name]
    if mail != none { c = c + h(0.5em) + mailto-link(mail) }
    if oh != none {
      c = c + linebreak() + text(size: 0.85em, fill: luma(95))[Office hours: #oh]
    }
    c
  }

  let info-rows = ()
  let meeting = (time, place).filter(p => p != none)
  if meeting.len() > 0 {
    info-rows.push(("Meetings", text(size: val-size)[#meeting.map(p => [#p]).join([, ])]))
  }
  if instructor != none {
    info-rows.push(("Instructor", person-cell(instructor, email, office-hours)))
  }
  if tas != none and tas.len() > 0 {
    let label = if tas.len() == 1 { "Teaching assistant" } else { "Teaching assistants" }
    let ta-content = tas
      .map(ta => person-cell(
        ta.at("name", default: none),
        ta.at("email", default: none),
        ta.at("office-hours", default: none),
      ))
      .join(v(0.45em, weak: true))
    info-rows.push((label, ta-content))
  }

  if info-rows.len() > 0 {
    block(above: 1.8em, below: 1.6em)[
      #grid(
        columns: (auto, 1fr),
        column-gutter: 1.5em,
        row-gutter: 0.9em,
        // Value cell sets only the font; each value bakes in its own size so
        // the email size is not compounded by an outer size rule.
        ..info-rows.map(row => (
          text(font: sansfont, weight: "semibold", size: 0.85em, fill: luma(75))[#row.at(0)],
          text(font: sansfont)[#row.at(1)],
        )).flatten()
      )
    ]
  }

  // Hairline rule closing the masthead off from the body.
  if title != none or instructor != none or info-rows.len() > 0 {
    block(above: 1.7em, below: 2.6em, line(length: 100%, stroke: 0.5pt + luma(180)))
  }

  if toc {
    block(above: 0em, below: 2em)[
      #outline(title: auto, depth: none)
    ]
  }

  doc
}
