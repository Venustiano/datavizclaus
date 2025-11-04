FROM rocker/binder:latest

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Small prep step to ensure HTTPS transport and certs available
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    gnupg \
    dirmngr \
    wget \
    locales \
  && rm -rf /var/lib/apt/lists/*

# Install main packages. If first attempt fails, run apt-get update --fix-missing and try again for clearer output.
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
      libudunits2-dev \
      libpoppler-cpp-dev \
      gdal-bin \
      libgdal-dev \
      libgeos-dev \
      libproj-dev \
      libmagick++-dev \
      libxt6 \
      libxtst6 \
      libssl-dev \
      libprotobuf-dev \
      protobuf-compiler \
      cmake \
      poppler-utils \
      ghostscript \
      tk \
      libxml2-dev \
      libcurl4-openssl-dev \
      liblzma-dev \
      zlib1g-dev \
      texlive-latex-extra \
      texlive-luatex \
      texlive-pictures \
  || (apt-get update --fix-missing && apt-get install -y --no-install-recommends \
      libudunits2-dev \
      libpoppler-cpp-dev \
      gdal-bin \
      libgdal-dev \
      libgeos-dev \
      libproj-dev \
      libmagick++-dev \
      libxt6 \
      libxtst6 \
      libssl-dev \
      libprotobuf-dev \
      protobuf-compiler \
      cmake \
      poppler-utils \
      ghostscript \
      tk \
      libxml2-dev \
      libcurl4-openssl-dev \
      liblzma-dev \
      zlib1g-dev \
      texlive-latex-extra \
      texlive-luatex \
      texlive-pictures ); \
    apt-get clean; rm -rf /var/lib/apt/lists/*

# Copy pip requirements and R installer from the repo root (these files must exist there)
COPY requirements.txt install.R /tmp/

# Install pip requirements
RUN python3 -m pip install --no-cache-dir --requirement /tmp/requirements.txt

# Install R packages via the provided script
RUN Rscript /tmp/install.R

# Use the typical rocker user/workspace
WORKDIR /home/jovyan/work
USER jovyan
