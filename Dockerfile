# Start with the Jupyter base image
FROM jupyter/base-notebook:latest

# Install system dependencies
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    vim

# Copy the project directory (including the environment.yml file) into the container
COPY . /home/jovyan/work

# Create a Conda environment using the environment.yml file to install R dependencies
RUN conda env create -f /home/jovyan/work/environment.yml

# Activate the newly created Conda environment
SHELL ["conda", "run", "-n", "my_r_env", "/bin/bash", "-c"]

# Install Python dependencies within the activated Conda environment
RUN pip install numpy==1.19.2 pandas==1.1.3 scikit-learn==0.23.2 matplotlib==3.3.2

# Continue as the non-root user
USER jovyan

# Set the working directory
WORKDIR /home/jovyan/work

