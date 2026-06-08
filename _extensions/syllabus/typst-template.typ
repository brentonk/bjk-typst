// Quarto template partial for the syllabus-typst format.
//
// The syllabus aesthetics live in the shared academic extension (single source
// of truth). This thin partial just pulls `syllabus()` into scope so the
// companion `typst-show.typ` can invoke it. The shared files
// (`syllabus-template.typ`, `styles.typ`, `macros.typ`) are copied next to the
// rendered output via this extension's `format-resources`, so the bare import
// resolves.

#import "syllabus-template.typ": syllabus
