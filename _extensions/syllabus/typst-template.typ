// Quarto template partial for the syllabus-typst format.
//
// The syllabus aesthetics live in the shared academic extension (single source
// of truth). This thin partial just pulls `syllabus()` into scope so the
// companion `typst-show.typ` can invoke it, plus `paragraph()` so the
// paragraph.lua filter's output resolves. It is spliced into the intermediate
// .typ next to the rendered document, so the imports are relative to the
// document's directory: they assume the document lives at the project root,
// alongside `_extensions/`.

#import "_extensions/academic/syllabus-template.typ": syllabus
#import "_extensions/academic/macros.typ": paragraph
