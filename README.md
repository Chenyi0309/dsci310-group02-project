# DSCI 310 Group02 Project: Uncovering the Drivers of Housing Prices in Beijing：The Influence of Location and Time

**Authors**: Prabhjot Singh, Yunxuan Zhang, Chenyi Zhao, Yelia Ye

This repository is part of a data analysis project for DSCI 310, exploring the factors influencing housing prices in Beijing.

**Dataset**: Accessed from [Kaggle - Beijing Lianjia Housing Data](https://www.kaggle.com/datasets/ruiqurm/lianjia).

## Table of Contents

- [Project Overview](#project-overview)
- [Introduction](#introduction)
- [Getting Started](#getting-started)
- [Docker Usage](#using-docker)
- [Data Analysis](#data-analysis)
- [Results](#results)
- [Contributing](#contributing)
- [Code of Conduct](#code-of-conduct)
- [Citation](#citation)
- [License](#license)
  
## Background

The housing market in Beijing, as in many large cities, is a complex system influenced by a multitude of factors including location, transportation accessibility, property attributes, and economic conditions. The study of housing prices in Beijing is particularly relevant due to the city’s rapid urbanization and economic growth, which have dramatically affected real estate values. Our analysis aims to uncover the drivers behind housing prices by examining a dataset of property sales in Beijing. The primary focus is on the role of location and temporal factors, such as proximity to subway lines and the date of the transaction. By leveraging various statistical and machine learning techniques, this project provides a detailed exploration of the relationships between housing prices and their potential predictors.

## Project Overview

In this study, we investigate the primary factors that influence the cost of homes in Beijing. By analyzing data from Lianjia.com, we explore how the location of a property and the timing of its sale affect its price. This research aims to shed light on the complex dynamics of Beijing's real estate market and provide a clearer picture for individuals looking to understand the value of real estate in this bustling metropolis.

## Introduction

The real estate market of Beijing is as dynamic as it is diverse, presenting a unique opportunity to study the various factors influencing housing prices. This study aims to pinpoint the most significant determinants, with a special focus on the effects of location and time.

To explore this, we have sourced data from the Lianjia.com, which records extensive property transaction details in Beijing. Our research question investigates how location and the time of sale relate to the price of housing.

Through this report, we will analyze the ‘Housing price in Beijing’ dataset to uncover patterns and relationships within the housing market, offering a student's perspective on the data and what it reveals about property values in Beijing.

## Getting Started

### Step 1: Clone the Repository

To get started with the project, first clone the repository using Git:

```bash
git clone https://github.com/wsl0917/dsci310-group02-project.git
cd dsci310-group02
```

### Step 2： Create a conda environment and install the dependencies:
```bash
conda env create -f environment.yml
conda activate my_r_env
```
### Step 3: Navigate to the Jupyter notebook to start exploring the dataset:
```
jupyter notebook analysis_notebook.ipynb
```

## Using Docker

This project includes a Dockerfile which allows you to build a Docker image and run the analysis in an isolated environment. Here's how you can use Docker to set up your environment:

### Building the Docker Image

First, build the Docker image from the project directory:

```bash
docker build -t dsci310-group02-project .
```

Then, use the Docker
```bash
docker run -it --rm -p 8888:8888 -v "$PWD":/home/jovyan/work dsci310-group02-project
```
## Project Execution

This project supports the use of `make` commands to simplify the execution process. Follow the steps below to run the entire project analysis:

1. **Build Project Environment**: First, ensure that you have created and activated the corresponding Conda environment as outlined in the "Getting Started" section above.

2. **Execute Project Analysis**: At the root directory of the project, you can execute the entire project's analysis process with the following command:

```bash
make all
```
3. **Clean Generated Files**: After the project is complete, if you need to clean up files generated during the analysis process, you can run:

```bash
make clean
```

## Data Analysis

The dataset from Lianjia.com was loaded and inspected for structure and summary statistics. Initial data exploration included reviewing the distributions of key variables such as square footage and price. 

Data cleaning processes involved removing irrelevant columns, converting character variables to their appropriate types, and handling missing values. We also removed variables with non-ASCII characters to streamline the dataset for analysis.

Further exploratory data analysis revealed insights into the relationships between various features of the properties and their prices. For example, histograms were used to visualize the distribution of total prices, while scatter plots helped in understanding the relationship between the square footage of properties and their total prices.

Correlation matrices were computed and visualized to identify potential linear relationships between numerical variables, informing subsequent modelling choices.

## Results

Our analysis revealed several key insights into the Beijing housing market. Location emerged as a significant determinant of housing prices, with properties closer to subway stations commanding higher prices. The availability of amenities such as elevators also influenced prices, echoing the premium that buyers place on convenience and accessibility. Time played a crucial role as well, with fluctuations in prices observed over different months and years, reflecting broader economic trends and policy shifts.

The data visualization component, including heatmaps and geospatial overlays, illustrated the geographical distribution of housing prices across Beijing's districts. It became evident that certain districts exhibited higher median prices, pointing to a stratified market that mirrors socio-economic divisions within the city.

Overall, the project not only quantified the impact of individual factors on housing prices but also painted a comprehensive picture of the market's dynamics. The findings from this analysis could serve as a foundation for future studies, contribute to urban planning and policy formulation, and assist stakeholders in making informed decisions in the real estate domain.

## Contributing
We welcome contributions to our project. Please refer to [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines.

## Code of Conduct
Please read our [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Citation

If you find this work useful in your research, please consider cite:
```
@article{hou2010housing,
  author={Hou, Y.},
  title={Housing price bubbles in Beijing and Shanghai?: A multi‐indicator analysis},
  journal={International Journal of Housing Markets and Analysis},
  volume={3},
  number={1},
  pages={17--37},
  year={2010},
  publisher={Emerald},
  doi={10.1108/17538271011027050},
  url={https://doi.org/10.1108/17538271011027050}
}

@article{ZHANG201872,
author = {Lei Zhang and Yimin Yi}
title = {What contributes to the rising house prices in Beijing? A decomposition approach},
journal = {Journal of Housing Economics},
volume = {41},
pages = {72-84},
year = {2018},
issn = {1051-1377},
doi = {https://doi.org/10.1016/j.jhe.2018.04.003},
url = {https://www.sciencedirect.com/science/article/pii/S1051137717301250}
}

@article{qin_han_2013,
  title={Emerging Polycentricity in Beijing: Evidence from Housing Price Variations, 2001–05},
  author={Qin, Bo and Han, Sun Sheng},
  journal={Urban Studies},
  volume={50},
  number={10},
  pages={2006--2023},
  year={2013},
  publisher={SAGE Publications},
  doi={10.1177/0042098012471979},
  url={https://doi.org/10.1177/0042098012471979}
}

@article{han2021winning,
  title={Winning at the starting line: The primary school premium and housing prices in Beijing},
  author={Han, X. and Shen, Y. and Zhao, B.},
  journal={China Economic Quarterly International},
  volume={1},
  number={1},
  pages={29-42},
  year={2021},
  publisher={Elsevier},
  doi={10.1016/j.ceqi.2020.12.001},
  url={https://doi.org/10.1016/j.ceqi.2020.12.001}
}
```
## License
This project is licensed under the [MIT License](LICENSE.md) - see the file for details.

