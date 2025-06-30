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
    fonts-terminus \
    fonts-cmu \
    fontconfig \
    ca-certificates \
    wget \
    entr \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/share/fonts/truetype/raleway
COPY fonts/*.ttf /usr/share/fonts/truetype/raleway/
RUN fc-cache -f -v

WORKDIR /data
ENTRYPOINT ["pandoc"]
