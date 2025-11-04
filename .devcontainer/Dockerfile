FROM rocker/binder:latest

# prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
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
    libpoppler-cpp-dev \
    poppler-utils \
    ghostscript \
    tk \
    libxml2-dev \
    libcurl4-openssl-dev \
    liblzma-dev \
    zlib1g-dev \
    texlive-latex-extra \
    texlive-luatex \
    texlive-pictures && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy pip requirements and R installer from the repository into the image.
# (These files should exist at the repo root — they will be copied during build.)
COPY requirements.txt install.R /tmp/

# Install Python pip requirements (no-cache)
RUN python3 -m pip install --no-cache-dir --requirement /tmp/requirements.txt

# Run the R install script to install R packages
RUN Rscript /tmp/install.R

# Default working directory in the codespace
WORKDIR /workspace
