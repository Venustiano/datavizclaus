FROM rocker/binder:latest

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Make sure subsequent RUNs execute as root (some devcontainer tooling can change the user)
USER root

# Minimal prerequisites for apt over HTTPS and certificates
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    gnupg \
    dirmngr \
    wget \
    locales \
  && rm -rf /var/lib/apt/lists/*

# Main apt install step (retry/fallback to give clearer errors on transient failures)
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

USER jovyan
# Copy pip requirements and R installer (these must exist at repo root)
COPY requirements.txt install.R /tmp/

# Install Python pip requirements
RUN python3 -m pip install --no-cache-dir --requirement /tmp/requirements.txt

# Run the R install script
RUN Rscript /tmp/install.R

# Default working directory and switch back to the jovyan user used by rocker images
WORKDIR /home/jovyan/work
