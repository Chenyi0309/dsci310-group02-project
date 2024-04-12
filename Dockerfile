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

# Create a script to adjust permissions and ensure `jovyan` user can access work directory
RUN echo "#!/bin/bash" > /usr/local/bin/adjust-permissions.sh && \
    echo "mkdir -p /home/jovyan/.local/share/jupyter/runtime" >> /usr/local/bin/adjust-permissions.sh && \
    echo "chown -R jovyan:users /home/jovyan/.local" >> /usr/local/bin/adjust-permissions.sh && \
    chmod +x /usr/local/bin/adjust-permissions.sh

# Run the script to adjust permissions
RUN /usr/local/bin/adjust-permissions.sh

# Copy the project directory (including any needed files) into the container
COPY . /home/jovyan/work

# Adjust permissions for copied files to ensure `jovyan` user can access them
RUN chown -R jovyan:users /home/jovyan/work

# Switch back to jovyan to avoid running as root
USER jovyan

# Set the working directory
WORKDIR /home/jovyan/work

# Expose the port Jupyter Lab is reachable on
EXPOSE 8888

# Start Jupyter Lab
CMD ["start-notebook.sh", "--LabApp.token=''"]
