// Quarto template partial for the simple-typst format.
//
// The simple-document aesthetics live in the shared academic extension
// (single source of truth). This thin partial pulls `simple()` into scope so
// the companion `typst-show.typ` can invoke it, along with the math/text/
// theorem macros (including `paragraph()`, which the paragraph.lua filter
// emits) that `simple-template.typ` re-exports. It is spliced into the
// intermediate .typ next to the rendered document, so the import is relative
// to the document's directory: it assumes the document lives at the project
// root, alongside `_extensions/`.

#import "_extensions/academic/simple-template.typ": *
