// Standalone Typst example of the bjk-academic "simple" mode: memos, referee
// reports, and other quick documents that want the house styling without the
// article masthead.
//
// Usage from this repo:
//   typst compile template/example_simple.typ --root . --font-path static/fonts
//
// Usage as a local package (after symlinking into
// ~/.local/share/typst/packages/local/bjk-academic/0.1.0/):
//   #import "@local/bjk-academic:0.1.0": simple

#import "../lib.typ": simple, paragraph, proposition, proof, indent

// All three metadata fields are optional; omit them for a bare document.
#show: simple.with(
  title: [TODO(BJK): title],
  author: "TODO(BJK): author",
  date: "TODO(BJK): date",
)

#lorem(80)

= TODO(BJK): first heading

#paragraph[TODO(BJK): lead-in.]
#lorem(60)

$ y = beta_0 + beta_1 x + epsilon $ <eq-example>

#lorem(30) See @eq-example.

#proposition[
  #lorem(20)
]
#proof[
  #lorem(25)
]

= TODO(BJK): second heading

+ #lorem(20)
+ #lorem(20)
+ #lorem(20)

// Paragraphs are LaTeX-style: indented, with no gap between them. Typst
// indents only a paragraph that directly follows another paragraph, so a new
// paragraph right after a list or display equation starts flush left. When it
// begins a new thought, start it with `#indent`. Leave text that continues a
// sentence after an equation ("where ...") flush left, and don't use `#indent`
// after an ordinary paragraph (Typst already indents those, so it doubles).
#indent #lorem(30)
