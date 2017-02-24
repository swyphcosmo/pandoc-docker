FROM haskell:8.0

MAINTAINER Michael Vernier <swyphcosmo@gmail.com>

# install latex packages
RUN apt-get update -y \
  && apt-get upgrade -y \
  && apt-get install -y -o Acquire::Retries=10 --no-install-recommends \
    texlive-latex-base \
    texlive-xetex latex-xcolor \
    texlive-math-extra \
    texlive-latex-extra \
    texlive-fonts-extra \
    texlive-bibtex-extra \
    fontconfig \
    lmodern

# will ease up the update process
# updating this env variable will trigger the automatic build of the Docker image
ENV PANDOC_VERSION "1.19.2.1"

# install pandoc
RUN cabal update \
  && cabal install hsb2hs-0.3.1 \
  && cabal install pandoc-${PANDOC_VERSION} -fembed_data_files

WORKDIR /source

ENTRYPOINT ["/root/.cabal/bin/pandoc"]

CMD ["--help"]
