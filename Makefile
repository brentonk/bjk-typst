TYPST_FONTS := static/fonts
TEMPLATE_DIR := template

.PHONY: all typst quarto syllabus-typst syllabus-quarto clean

all: typst quarto syllabus-typst syllabus-quarto

typst: $(TEMPLATE_DIR)/example_typst.pdf

quarto: $(TEMPLATE_DIR)/example_quarto.pdf

syllabus-typst: $(TEMPLATE_DIR)/example_syllabus.pdf

syllabus-quarto: $(TEMPLATE_DIR)/example_syllabus_quarto.pdf

$(TEMPLATE_DIR)/example_typst.pdf: $(TEMPLATE_DIR)/main.typ lib.typ _extensions/academic/article-template.typ _extensions/academic/styles.typ
	typst compile $(TEMPLATE_DIR)/main.typ $@ --root . --font-path $(TYPST_FONTS)

$(TEMPLATE_DIR)/example_quarto.pdf: template.qmd _extensions/academic/typst-template.typ _extensions/academic/typst-show.typ _extensions/academic/article-template.typ _extensions/academic/styles.typ
	quarto render template.qmd --to academic-typst
	mv docs/template.pdf $@

$(TEMPLATE_DIR)/example_syllabus.pdf: $(TEMPLATE_DIR)/example_syllabus.typ lib.typ _extensions/academic/syllabus-template.typ _extensions/academic/styles.typ
	typst compile $(TEMPLATE_DIR)/example_syllabus.typ $@ --root . --font-path $(TYPST_FONTS)

$(TEMPLATE_DIR)/example_syllabus_quarto.pdf: syllabus.qmd _extensions/syllabus/typst-show.typ _extensions/syllabus/typst-template.typ _extensions/academic/syllabus-template.typ _extensions/academic/styles.typ
	quarto render syllabus.qmd --to syllabus-typst
	mv docs/syllabus.pdf $@

clean:
	rm -f $(TEMPLATE_DIR)/example_typst.pdf $(TEMPLATE_DIR)/example_quarto.pdf
	rm -f $(TEMPLATE_DIR)/example_syllabus.pdf $(TEMPLATE_DIR)/example_syllabus_quarto.pdf
	rm -rf *_files/ docs/
