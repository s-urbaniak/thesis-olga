SRC = *.tex \
      *.bib

thesis: $(SRC)
	rubber -d thesis

all: thesis

clean:
	rubber --clean -d thesis

.PHONY: \
	clean
