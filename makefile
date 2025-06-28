TEX = pandoc
src = template.tex details.yml
FLAGS = --pdf-engine=xelatex

output.pdf : $(src)
	$(TEX) $(filter-out $<,$^ ) -o $@ --template=$< $(FLAGS)

.PHONY: clean docker
clean :
	rm output.pdf

docker:
	docker run --rm --platform linux/amd64 \
    -v $(CURDIR):/data -w /data pandoc/latex \
    details.yml -o output.pdf --template=template.tex --pdf-engine=xelatex
