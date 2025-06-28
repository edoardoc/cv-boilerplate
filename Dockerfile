FROM debian:bookworm-slim

# Install Pandoc and XeLaTeX with required packages
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    pandoc \
    texlive-xetex \
    texlive-latex-recommended \
    texlive-latex-extra \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-lang-english \
    texlive-lang-greek \
    fonts-texgyre \
    fonts-lmodern \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /data
ENTRYPOINT ["pandoc"]