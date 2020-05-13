GIT_VERSION := $(shell git log -1 --pretty=format:'g%h -- %ci')
GIT_DIRTY := $(shell git describe --all --long --dirty | grep -q dirty && echo ' (locally modified)' || true)

angel.pdf: angel.tex logo.pdf
	@echo "Typesetting $@..."
	@pdflatex --shell-escape -interaction=batchmode "\def\gitversion{$(GIT_VERSION)$(GIT_DIRTY)}\input{angel}"
	@pdflatex --shell-escape -interaction=batchmode "\def\gitversion{$(GIT_VERSION)$(GIT_DIRTY)}\input{angel}"

%.pdf : %.svg
	@echo "Converting $@..."
	@inkscape --export-area-drawing \
		--export-pdf=$@ $<

clean:
	@echo "Cleaning..."
	@rm -f angel.toc angel.aux angel.log \
		angel.ind angel.idx angel.out \
		angel.pdf
	@rm -f logo.pdf
