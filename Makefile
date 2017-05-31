SRC = *.tex \
      *.bib

thesis: $(SRC)
	rubber -d thesis

all: thesis

clean:
	rubber --clean -d praca
	rubber --clean -d presentation

.PHONY: \
	clean
