TYPST_FONTS := static/fonts
TEMPLATE_DIR := template

.PHONY: all typst quarto clean

all: typst quarto

typst: $(TEMPLATE_DIR)/example_typst.pdf

quarto: $(TEMPLATE_DIR)/example_quarto.pdf

$(TEMPLATE_DIR)/example_typst.pdf: $(TEMPLATE_DIR)/main.typ lib.typ _extensions/academic/typst-template.typ
	typst compile $(TEMPLATE_DIR)/main.typ $@ --root . --font-path $(TYPST_FONTS)

$(TEMPLATE_DIR)/example_quarto.pdf: template.qmd _extensions/academic/typst-template.typ _extensions/academic/typst-show.typ
	quarto render template.qmd --to academic-typst
	mv docs/template.pdf $@

clean:
	rm -f $(TEMPLATE_DIR)/example_typst.pdf $(TEMPLATE_DIR)/example_quarto.pdf
	rm -rf *_files/ docs/
