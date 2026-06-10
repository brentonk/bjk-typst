// Quarto template partial for the academic-typst format.
//
// The implementation lives in `article-template.typ` (single source of truth,
// shared with the standalone Typst package via `lib.typ`). This thin partial
// is spliced into the intermediate .typ next to the rendered document, so its
// import is relative to the document's directory: it assumes the document
// lives at the project root, alongside `_extensions/`. The wildcard pulls
// `article()`/`appendix()` plus everything they re-export (macros, theorem
// environments, base-styles, Font Awesome) into the document's scope.

#import "_extensions/academic/article-template.typ": *
