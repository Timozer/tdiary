TEX = xelatex
BIBTEX = bibtex 
OPEN = open

STARTYEAR = 2018
THISYEAR = 2018

OBJECTS = main.pdf
target: $(OBJECTS)

main.pdf: FORCE 
	$(TEX) -shell-escape main.tex
	#$(BIBTEX) main.aux
	#$(TEX) -shell-escape main.tex
	#$(TEX) -shell-escape main.tex
	$(OPEN) $@

FORCE: ;

genfolderexist:
	./genexistfiles.sh $(STARTYEAR) $(THISYEAR)

.PHONY: clean 

clean:
	rm -f *~ *.aux *.log *.out *.toc *.bbl *.blg *.lof *.lot 
	#rm -f *.pdf
	rm -rf _minted-cache
