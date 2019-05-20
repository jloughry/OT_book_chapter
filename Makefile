target = chapter_7

latex_cmd = pdflatex

graphics = taxonomy.pdf

all:: $(target).pdf

$(target).pdf: $(target).tex $(graphics) Makefile
	$(latex_cmd) $(target).tex
	bibtex $(target)
	@if (grep "Warning" $(target).blg > /dev/null ) then false; fi
	@while grep "Rerun to get" $(target).log ; do \
		$(latex_cmd) $(target) ; \
	done

fix_boldface_for_memoir_class:
	sed -e 's/{\\\bf /\\\textbf{/g' $(target).bbl

reset:: touch
	rm -fv *.bbl

vi:
	vi $(target).tex

touch:
	touch $(target).tex

clean::
	@echo "This is \"clean\" in the local Makefile."
	rm -fv *.log *.blg *.aux

spell::
	detex $(target).tex | aspell --lang=EN_GB list | sort --ignore-case | uniq -i

allclean: clean
	rm -fv *.bbl $(target).pdf

include common.mk
