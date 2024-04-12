# Start with the Jupyter base image
FROM jupyter/base-notebook:latest

# Install system dependencies
USER root
RUN apt-get update && apt-get install -y --no-install-recommends git curl vim

# Install R and R packages
RUN conda install -c conda-forge r-base
RUN R -e "install.packages(c('dplyr', 'ggplot2', 'tidyr', 'readr', 'corrplot', 'tidyverse', 'lubridate', 'repr', 'cowplot', 'ggmap', 'mapproj', 'viridis'), repos='http://cran.rstudio.com/')"

# Copy the project directory (including any needed files) into the container
COPY . /home/jovyan/work

# Clean up to reduce image size
RUN conda clean -afy

# Continue as the non-root user
USER jovyan

# Set the working directory
WORKDIR /home/jovyan/work
