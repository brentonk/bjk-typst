-- Render [Lead-in.]{.paragraph} spans as run-in paragraph headings.
--
-- Typst output calls the paragraph() macro from macros.typ (Fira Sans bold
-- run-in); every other format falls back to plain bold, so documents stay
-- portable to HTML/gfm. Auto-applied in the academic-typst and syllabus-typst
-- formats; for other formats add `filters: [academic]` to the document YAML.
function Span(el)
  if not el.classes:includes('paragraph') then
    return nil
  end
  if FORMAT == 'typst' then
    local result = pandoc.Inlines({ pandoc.RawInline('typst', '#paragraph[') })
    result:extend(el.content)
    result:insert(pandoc.RawInline('typst', ']'))
    return result
  end
  return pandoc.Strong(el.content)
end
