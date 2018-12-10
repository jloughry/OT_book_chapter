target = book_chapter

latex_cmd = pdflatex

all:: $(target).pdf

$(target).pdf: $(target).tex Makefile
	$(latex_cmd) $(target).tex
	bibtex $(target)
	@if (grep "Warning" $(target).blg > /dev/null ) then false; fi
	@while grep "Rerun to get" $(target).log ; do \
		$(latex_cmd) $(target) ; \
	done

vi:
	vi $(target).tex

clean::
	@echo "This is \"clean\" in the local Makefile."
	rm -fv *.log *.blg *.aux

spell::
	detex book_chapter.tex | aspell --lang=EN_GB list

allclean: clean
	rm -fv *.bbl $(target).pdf

include common.mk
