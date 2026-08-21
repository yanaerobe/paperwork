TEX := cv_yyj.tex
PDF := cv_yyj.pdf

.PHONY: all clean verify render

all: $(PDF)

$(PDF): $(TEX) resume.cls
	latexmk -xelatex -interaction=nonstopmode -halt-on-error $(TEX)

verify: all
	@pages=$$(pdfinfo $(PDF) | awk '/^Pages:/ {print $$2}'); \
		test "$$pages" = "2" || { echo "expected 2 pages, got $$pages"; exit 1; }
	@if rg -n 'Overfull|LaTeX Error' cv_yyj.log; then \
		echo "layout/build diagnostics found"; exit 1; \
	fi
	@pdftotext -layout $(PDF) /tmp/cv_yyj.txt
	@pdffonts $(PDF) >/dev/null

render: verify
	pdftoppm -png -r 144 $(PDF) /tmp/cv_yyj-page

clean:
	latexmk -c $(TEX)
