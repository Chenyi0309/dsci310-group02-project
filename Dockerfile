# Start with the Jupyter base image
FROM jupyter/base-notebook:latest

# Install system dependencies
USER root
RUN apt-get update && apt-get install -y --no-install-recommends git curl vim

# Install R and R packages
# Install R and essential R packages
RUN conda install -c conda-forge r-base r-essentials

# Install R packages using Ncpus to speed up installation
RUN R -e "options(repos = list(CRAN = 'http://cran.rstudio.com/')); install.packages(c('dplyr', 'ggplot2', 'tidyr', 'readr', 'corrplot', 'tidyverse', 'lubridate', 'repr', 'cowplot', 'ggmap', 'mapproj', 'viridis'), Ncpus = parallel::detectCores())"

# Install IRkernel and register R kernel globally
RUN R -e "install.packages('IRkernel', repos='http://cran.rstudio.com/'); IRkernel::installspec(user = FALSE)"


# Copy the project directory (including any needed files) into the container
COPY . /home/jovyan/work

# Clean up to reduce image size
RUN conda clean -afy

# Continue as the non-root user
USER jovyan

# Set the working directory
WORKDIR /home/jovyan/work
