// Math, text, and theorem macros for the bjk-academic template.
//
// This file lives outside `typst-template.typ` because Quarto runs
// typst-template.typ through Pandoc's template engine, which treats `$...$`
// as variable substitution and chokes on the math macros below. Typst loads
// this file directly via `#import`, bypassing Pandoc.

#import "@preview/theorion:0.5.0": *
#import cosmos.clouds: *

// Math macros
#let deriv(num, denom, style: "vertical") = $frac(dif num, dif denom, style: style)$
#let pderiv(num, denom, style: "vertical") = $frac(partial num, partial denom, style: style)$
#let mathbf(it) = math.upright(math.bold(it))
#let moveeqleft = math.class("normal", h(-2em))

// Text macros
#let def(term) = text(fill: eastern, term)
#let citet(key, supplement: none) = cite(key, form: "prose", supplement: supplement)
#let citepp(prefix: none, ..keys) = {
  "("
  if prefix != none [#prefix ]
  keys.pos().map(k => [#cite(k, form: "author")#h(0pt) #cite(k, form: "year")]).join("; ")
  ")"
}
#let note-color = rgb("#fffd11a1")
#let note(it) = {
  show math.equation.where(block: false): e => box(
    fill: note-color,
    outset: (top: 0.15em, bottom: 0.25em),
    e,
  )
  highlight(fill: note-color)[\[#it\]]
}
#let paragraph(title) = {
  v(0.5em)
  text(font: "Fira Sans", strong(title))
  h(0.5em)
}

// Theorem environments (theorion-based, with custom Fira Sans titles)
#let bjk-thm-title(prefix, title) = [
  #text(font: "Fira Sans", size: 0.9em)[#prefix.#if title != "" and title != [] [#text(weight: 100)[ (#title.)]]]
]
#let assumption  = assumption.with(get-full-title: bjk-thm-title)
#let lemma       = lemma.with(get-full-title: bjk-thm-title)
#let proposition = proposition.with(get-full-title: bjk-thm-title)
#let (_, _, corollary, _) = make-frame(
  "corollary",
  theorion-i18n-map.at("corollary"),
  counter: theorem-counter,
  render: render-fn.with(fill: red.lighten(80%)),
)
#let corollary = corollary.with(get-full-title: bjk-thm-title)
