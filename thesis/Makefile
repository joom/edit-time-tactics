FILENAME=thesis
SOURCENAME=source
OUTPUTNAME=output
LATEX=pdflatex

default: preview

compile:
	@cp $(SOURCENAME).tex $(FILENAME).tex
	@$(LATEX) $(FILENAME).tex
	@bibtex $(FILENAME) > /dev/null
	@$(LATEX) $(FILENAME).tex 2> /dev/null
	@$(LATEX) $(FILENAME).tex 2> /dev/null
	@$(LATEX) $(FILENAME).tex
	@mv $(FILENAME).pdf $(OUTPUTNAME).pdf

debug:
	cp $(SOURCENAME).tex $(FILENAME).tex
	$(LATEX) $(FILENAME).tex
	bibtex $(FILENAME)
	$(LATEX) $(FILENAME).tex
	$(LATEX) $(FILENAME).tex
	$(LATEX) $(FILENAME).tex
	mv $(FILENAME).pdf $(OUTPUTNAME).pdf

open:
	@open $(OUTPUTNAME).pdf

clean:
	@rm *.aux
	@rm $(FILENAME).*

publishbash:
	./publish.sh

preview: compile open clean
publish: compile publishbash clean
