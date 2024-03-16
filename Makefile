# Makefile for the Beijing Housing Price Analysis Project
# author: Yunxuan Zhang
# date: 03-16-2024

# Main target: Complete all analysis steps and generate report
all: results/summary_of_original_housing_data.txt \
	results/beijing_house_price_cleaned.csv \
	results/figure/plot_1_totalprice_distribution_plot.png \
	results/figure/plot_2_correlation_plot.png \
	results/figure/plot_3_price_distribution_subway.png \
	results/figure/plot_4_price_distribution_elevator.png \
	results/figure/plot_5_renovation_condition.png \
	results/figure/plot_6_monthly_price_overview.png \
	results/figure/plot_7_beijing_map.png \
	results/figure/plot_8_beijing_map_with_price_overlay.png \
	results/figure/plot_9_boxplot_price_district.png \
	results/figure/plot_10_beijing_map_with_district_overlay.png \
	results/price_prediction_plot.png \
	results/model_summary.txt \
	reports/dsci310-group02-project-analysis.html \
	reports/dsci310-group02-project-analysis.pdf



# Data reading and description
results/summary_of_original_housing_data.txt: scripts/data_read_description.R \
	data/Beijinghouse.csv
	Rscript scripts/data_read_description.R

# Data preprocessing
results/beijing_house_price_cleaned.csv: scripts/data_preprocessing.R \
	results/summary_of_original_housing_data.txt
	Rscript scripts/data_preprocessing.R

# Exploratory data analysis
results/figure/plot_1_totalprice_distribution_plot.png \
results/figure/plot_2_correlation_plot.png \
results/figure/plot_3_price_distribution_subway.png \
results/figure/plot_4_price_distribution_elevator.png \
results/figure/plot_5_renovation_condition.png \
results/figure/plot_6_monthly_price_overview.png \
results/figure/plot_7_beijing_map.png \
results/figure/plot_8_beijing_map_with_price_overlay.png \
results/figure/plot_9_boxplot_price_district.png \
results/figure/plot_10_beijing_map_with_district_overlay.png: scripts/data_exploratory_analysis.R \
	results/beijing_house_price_cleaned.csv
	Rscript scripts/data_exploratory_analysis.R



# Results and conclusion
results/price_prediction_plot.png results/model_summary.txt results/final_model.rds: scripts/results_and_conclusion.R \
	results/beijing_house_price_cleaned.csv
	Rscript scripts/results_and_conclusion.R


# Render Quarto report in HTML and PDF
reports/beijing_housing_analysis.html reports/beijing_housing_analysis.pdf: reports/dsci310-group02-project-analysis.qmd \
	results/summary_of_original_housing_data.txt \
	results/beijing_house_price_cleaned.csv \
	results/figure/plot_1_totalprice_distribution_plot.png \
	results/figure/plot_2_correlation_plot.png \
	results/figure/plot_3_price_distribution_subway.png \
	results/figure/plot_4_price_distribution_elevator.png \
	results/figure/plot_5_renovation_condition.png \
	results/figure/plot_6_monthly_price_overview.png \
	results/figure/plot_7_beijing_map.png \
	results/figure/plot_8_beijing_map_with_price_overlay.png \
	results/figure/plot_9_boxplot_price_district.png \
	results/figure/plot_10_beijing_map_with_district_overlay.png \
	results/price_prediction_plot.png \
	results/model_summary.txt
	quarto render reports/dsci310-group02-project-analysis.qmd --to html
	quarto render reports/dsci310-group02-project-analysis.qmd --to pdf



# Clean up generated files
clean:
	rm -rf results/*
	rm -rf reports/dsci310-group02-project-analysis.html \
		reports/dsci310-group02-project-analysis.pdf \
		reports/dsci310-group02-project-analysis_files

