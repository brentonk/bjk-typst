// Standalone Typst starter template for bjk-academic.
//
// Usage from this repo:
//   typst compile template/main.typ --font-path static/fonts
//
// Usage as a local package (after symlinking into
// ~/.local/share/typst/packages/local/bjk-academic/0.1.0/):
//   #import "@local/bjk-academic:0.1.0": article, appendix, lemma, ...

#import "../lib.typ": (
  article, appendix,
  lemma, proposition, corollary, assumption, definition,
  proof, qedhere, theorion-restate, set-theorion-numbering,
  deriv, pderiv, mathbf, moveeqleft, indicator,
  def, note, paragraph, citet,
)

#show: article.with(
  title: "Paper Title",
  subtitle: "A subtitle for the paper",
  thanks: [The author thanks someone for helpful comments.],
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
    It exercises the math macros (#deriv($f$, $x$)), the theorem environments,
    and the equation-numbering convention.
  ],
  keywords: [keyword one, keyword two],
  sectionnumbering: "1.1.1",
  titlepage: true,
)

= Introduction

#lorem(40) We #def[define] technical terms using the `def` macro,
following #citet(<horst2020>) and the parenthetical form @katsushika1831.
#note[A draft note that's easy to spot.]

= Setup

#definition(title: "Interior maximizer")[
  An interior maximizer of $f$ is a point $x^* in RR$ with $f'(x^*) = 0$.
] <def-maximizer>

#assumption(title: "Regularity")[
  The function $f : RR -> RR$ is twice continuously differentiable and
  strictly concave.
] <assm-regularity>

Under @assm-regularity, an interior maximizer in the sense of @def-maximizer
is unique.

== Notation

A labelled display equation is numbered:
$
deriv(f, x) = 0
$ <eq-foc>

An unlabelled equation is not:
$
pderiv(f, x_i) + pderiv(f, x_j) = 0.
$

Expectations of indicator functions give probabilities:
$ EE[indicator(X <= t)] = Pr(X <= t). $

We refer to @eq-foc when needed. The macro #mathbf[v] produces an upright bold
vector.

= Results

#lemma(title: "Monotonicity")[
  If $f$ is strictly concave, then $f'$ is strictly decreasing.
] <res-monotone>

#proof[
  Differentiate twice and use the assumption. #qedhere
]

#proposition(title: "Main result")[
  The optimum exists and is unique.
] <res-main>

#corollary[
  Comparative statics on the optimum follow from the implicit function theorem.
]

#paragraph[Discussion.]
#lorem(40)

#bibliography("/references.bib")

#show: appendix
#set-theorion-numbering("A.1")

= Proof of @res-main <sec-proof>

#theorion-restate(filter: <res-main>)

#proof[
  By @res-monotone and the intermediate value theorem.
]
