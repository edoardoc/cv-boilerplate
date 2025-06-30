# Makefile

TEX = pandoc
src = template.tex details.yml
FLAGS = --pdf-engine=xelatex

# Define the image name
IMAGE = cv-builder

# Files to watch for the entr command
WATCH_FILES = $(src) $(wildcard *.tex)

.PHONY: clean docker docker-image watch-docker

# build the output PDF directly on the host (if pandoc is installed)
output.pdf : $(src)
	$(TEX) $(filter-out $<,$^ ) -o $@ --template=$< $(FLAGS) --verbose

clean : ## clean generated files
	rm -f output.pdf

docker-image: ## build the Docker image
	docker build -t $(IMAGE) .

docker: docker-image ## build output.pdf
	@echo "Running pandoc in Docker..."
	docker run --rm \
	-v "$(CURDIR):/data" -w /data $(IMAGE) \
	--template=/data/template.tex $(FLAGS) --verbose -o /data/output.pdf details.yml

watch-docker: docker-image ## Continously build output.pdf
	@echo "Starting watch mode for files: $(WATCH_FILES)"
	@echo "Press Ctrl+C to stop watching."
	@ls $(WATCH_FILES) | entr -cs 'docker run --rm -v "$$(pwd):/data" -w /data $(IMAGE) --template=/data/template.tex $(FLAGS) --verbose -o /data/output.pdf details.yml'

help: ## Help command
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'