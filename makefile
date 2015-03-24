SRC = $(wildcard *.md)

PDFS=$(SRC:.md=.pdf)
HTML=$(SRC:.md=.html)
LATEX_TEMPLATE=./pandoc-templates/default.latex

all:    clean $(PDFS) $(HTML)

pdf:   clean $(PDFS)
html:  clean $(HTML)

%.html: %.md
	python kressner-cv.py html $(GRAVATAR_OPTION) < $< | pandoc -t html+definition_lists -c kressner-cv.css -o index.html --section-divs --email-obfuscation=none

%.pdf:  %.md $(LATEX_TEMPLATE)
	python kressner-cv.py tex < $< | pandoc $(PANDOCARGS) --variable=colorlinks --template=$(LATEX_TEMPLATE) -H header.tex -o $@

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
