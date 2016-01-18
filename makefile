SRC = kressner-cv.md

PDFS=$(SRC:.md=.pdf)
HTML=$(SRC:.md=.html)
LATEX_TEMPLATE=./pandoc-templates/default.latex
HTML_TEMPLATE=./pandoc-templates/default.html

all:    clean $(PDFS) $(HTML)

pdf:   clean $(PDFS)
html:  clean $(HTML)

%.html: %.md $(HTML_TEMPLATE)
	python kressner-cv.py html < $< | pandoc -t html+definition_lists -c kressner-cv.css --template=$(HTML_TEMPLATE) -o index.html --section-divs --email-obfuscation=none

%.pdf:  %.md $(LATEX_TEMPLATE)
	pandoc --latex-engine=xelatex --variable colorlinks --template=$(LATEX_TEMPLATE) -H header.tex -o kressner-cv.pdf $(SRC) 

ifeq ($(OS),Windows_NT)
  # on Windows
  RM = cmd //C del
else
  # on Unix
  RM = rm -f
endif

clean:
	$(RM) *.html *.pdf

# $(LATEX_TEMPLATE):
	# git submodule update --init
