# Start with the Jupyter base image
FROM jupyter/base-notebook:latest

# Install system dependencies
USER root
RUN apt-get update && apt-get install -y --no-install-recommends git curl vim

# Install R and essential R packages
RUN conda install -c conda-forge r-base r-essentials

# Install R packages
RUN R -e "options(repos = list(CRAN = 'http://cran.rstudio.com/')); install.packages(c('dplyr', 'ggplot2', 'tidyr', 'readr', 'corrplot', 'tidyverse', 'lubridate', 'repr', 'cowplot', 'ggmap', 'mapproj', 'viridis'))"

# Install IRkernel and register R kernel globally
RUN R -e "install.packages('IRkernel', repos='http://cran.rstudio.com/'); IRkernel::installspec(user = FALSE)"

# Adjust permissions to ensure `jovyan` user can access work directory
COPY . /home/jovyan/work
RUN chown -R jovyan:users /home/jovyan/work

# Switch back to jovyan to avoid running as root
USER jovyan

# Set the working directory
WORKDIR /home/jovyan/work
