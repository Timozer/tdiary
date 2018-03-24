TEX = xelatex
BIBTEX = bibtex 
OPEN = open

STARTYEAR = 2018
THISYEAR = 2018

OBJECTS = main.pdf
target: $(OBJECTS)

main.pdf: main.tex *.cls *.sty Makefile
	$(TEX) -shell-escape $<
	#$(BIBTEX) main.aux
	#$(TEX) -shell-escape $<
	#$(TEX) -shell-escape $<
	$(OPEN) $@

genfolderexist:
	./genexistfiles.sh $(STARTYEAR) $(THISYEAR)

.PHONY: clean 

clean:
	rm -f *~ *.aux *.log *.out *.toc *.bbl *.blg *.lof *.lot 
	#rm -f *.pdf
	rm -rf _minted-cache
