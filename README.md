# DSCI 310 Group02 Project: Uncovering the Drivers of Housing Prices in Beijing： The Influence of Location and Time

**Authors**: Prabhjot Singh, Yunxuan Zhang, Chenyi Zhao, Yelia Ye

This repository is part of a data analysis project for DSCI 310, exploring the factors influencing housing prices in Beijing.

**Dataset**: Accessed from [Kaggle - Beijing Lianjia Housing Data](https://www.kaggle.com/datasets/ruiqurm/lianjia).

## Table of Contents

- [Project Overview](#project-overview)
- [Introduction](#introduction)
- [Getting Started](#getting-started)
- [Data Analysis](#data-analysis)
- [Results](#results)
- [Contributing](#contributing)
- [Code of Conduct](#code-of-conduct)
- [Citation](#citation)
- [License](#license)
  
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
## Data Analysis

The dataset from Lianjia.com was loaded and inspected for structure and summary statistics. Initial data exploration included reviewing the distributions of key variables such as square footage and price. 

Data cleaning processes involved removing irrelevant columns, converting character variables to their appropriate types, and handling missing values. We also removed variables with non-ASCII characters to streamline the dataset for analysis.

Further exploratory data analysis revealed insights into the relationships between various features of the properties and their prices. For example, histograms were used to visualize the distribution of total prices, while scatter plots helped in understanding the relationship between the square footage of properties and their total prices.

Correlation matrices were computed and visualized to identify potential linear relationships between numerical variables, informing subsequent modeling choices.

## Results

Our analysis included detailed visualizations to compare various property features with the total price, which provided a clearer understanding of the housing market in Beijing. 

Box plots were employed to display the relationship between the number of living rooms, drawing rooms, and bathrooms with the total price of the properties. These plots illustrated the variation in price distribution across different property types.

Finally, a linear regression model was developed to predict the total price of properties based on the available features. The model's performance was evaluated by comparing actual prices with predicted prices, which was visualized through a scatter plot overlaid with a line of perfect prediction. This comparison highlighted the model’s accuracy and potential predictive power.

The results from these analyses will help in understanding the drivers of housing prices in Beijing and could assist buyers and sellers in making informed decisions in the real estate market.


## Contributing
We welcome contributions to our project. Please refer to [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines.

## Code of Conduct
Please read our [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Citation

## License
This project is licensed under the [MIT License](LICENSE.md) - see the file for details.

