FILENAME=thesis
SOURCENAME=source
OUTPUTNAME=output

default: preview

compile:
	@cp $(SOURCENAME).tex $(FILENAME).tex
	@pydflatex $(FILENAME).tex
	@bibtex $(FILENAME) > /dev/null
	@pydflatex $(FILENAME).tex 2> /dev/null
	@pydflatex $(FILENAME).tex 2> /dev/null
	@pydflatex $(FILENAME).tex
	@mv $(FILENAME).pdf $(OUTPUTNAME).pdf

debug:
	cp $(SOURCENAME).tex $(FILENAME).tex
	pydflatex $(FILENAME).tex
	bibtex $(FILENAME)
	pydflatex $(FILENAME).tex
	pydflatex $(FILENAME).tex
	pydflatex $(FILENAME).tex
	mv $(FILENAME).pdf $(OUTPUTNAME).pdf

open:
	@open $(OUTPUTNAME).pdf

clean:
	@rm *.aux
	@rm $(FILENAME).*

preview: compile open clean
