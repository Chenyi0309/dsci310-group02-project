# Start with the Jupyter base image
FROM jupyter/base-notebook:latest

# Install system dependencies
USER root
RUN apt-get update && apt-get install -y --no-install-recommends git curl vim

# Copy the project directory (including the environment.yml file) into the container
COPY . /home/jovyan/work

# Create a Conda environment using the environment.yml file
# Note: Assuming the environment.yml is in the root of your project directory
RUN conda env create -f /home/jovyan/work/environment.yml

# Clean up to reduce image size
RUN conda clean -afy

# Make RUN commands use the new environment:
# The Conda environment name should match the name specified in environment.yml
# Replace `your_env_name` with the actual name of your Conda environment
SHELL ["conda", "run", "-n", "beijing_housing_analysis_Group_2", "/bin/bash", "-c"]

# Continue as the non-root user
USER jovyan

# Set the working directory
WORKDIR /home/jovyan/work


