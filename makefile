TEX = pandoc
src = template.tex details.yml
FLAGS = --pdf-engine=xelatex

output.pdf : $(src)
	$(TEX) $(filter-out $<,$^ ) -o $@ --template=$< $(FLAGS)

IMAGE = cv-builder
.PHONY: clean docker docker-image
clean :
	rm -f output.pdf

docker-image:
	docker build -t $(IMAGE) .

docker: docker-image
	docker run --rm \
	-v $(CURDIR):/data -w /data $(IMAGE) \
	--template=template.tex --pdf-engine=xelatex -o output.pdf details.yml
