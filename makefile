SRC = kressner-cv.md

PDF=$(SRC:.md=.pdf)
HTML=$(SRC:.md=.html)
LATEX_TEMPLATE=./pandoc-templates/default.latex
HTML_TEMPLATE=./pandoc-templates/default.html

all:    $(PDF) $(HTML)

pdf:   $(PDF)
html:  $(HTML)

%.html: %.md $(HTML_TEMPLATE)
	python kressner-cv.py html < $< | pandoc -t html+definition_lists -c kressner-cv.css --template=$(HTML_TEMPLATE) -o index.html --section-divs --email-obfuscation=none --metadata pagetitle="Abigail Anne (Abbie) Kressner"

%.pdf:  %.md $(LATEX_TEMPLATE)
	pandoc --pdf-engine=xelatex --variable colorlinks --template=$(LATEX_TEMPLATE) -H header.tex -o kressner-cv.pdf $(SRC) --metadata pagetitle="Abigail Anne (Abbie) Kressner"
