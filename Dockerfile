# Start with the Jupyter base image
FROM jupyter/base-notebook:latest

# Install system dependencies
USER root
RUN apt-get update && apt-get install -y --no-install-recommends git curl vim

# Install mamba from conda-forge to manage conda packages more efficiently
RUN conda install mamba -n base -c conda-forge

# Use mamba to install Python and R dependencies to ensure faster resolution
RUN mamba install -c conda-forge \
    numpy=1.19.2 \
    pandas=1.1.3 \
    scikit-learn=0.23.2 \
    matplotlib=3.3.2 \
    r-base=4.0.5 \
    r-dplyr \
    r-ggplot2 \
    r-tidyr \
    r-readr \
    r-corrplot \
    notebook=6.4.0 \
    jupyterlab=3.0.14 \
    ipywidgets \
    -y

 COPY . /home/jovyan/work

# Activate the base environment by default when running commands with /bin/bash
SHELL ["conda", "run", "-n", "base", "/bin/bash", "-c"]

# Continue as the non-root user
USER jovyan

# Set the working directory
WORKDIR /home/jovyan/work

