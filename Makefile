# 定义变量
DATA_DIR = data
SCRIPTS_DIR = scripts
RESULTS_DIR = results
FIGURES_DIR = $(RESULTS_DIR)/figure
REPORT_DIR = report

# 定义输入数据和报告输出文件
RAW_DATA = $(DATA_DIR)/Beijinghouse.csv
PREPROCESSED_DATA = $(RESULTS_DIR)/clean_data_table.csv
CORR_MATRIX_PLOT = $(FIGURES_DIR)/correlation_matrix.png
BOXPLOT_LIVING_ROOM = $(FIGURES_DIR)/boxplot_living_room.png
BOXPLOT_DRAWING_ROOM = $(FIGURES_DIR)/boxplot_drawing_room.png
BOXPLOT_BATHROOM = $(FIGURES_DIR)/boxplot_bathroom.png
PREDICTION_PLOT = $(FIGURES_DIR)/price_prediction.png
FINAL_REPORT = $(REPORT_DIR)/count_report.html

# 默认目标
all: $(FINAL_REPORT)

# 数据加载与探索
$(RESULTS_DIR)/exploration_output.txt: $(SCRIPTS_DIR)/data_loading_and_exploration.R $(RAW_DATA)
	Rscript $< $(RAW_DATA) $@

# 数据预处理
$(PREPROCESSED_DATA): $(SCRIPTS_DIR)/data_preprocessing.R $(RAW_DATA)
	Rscript $< $(RAW_DATA) $@

# 数据分析和可视化
$(CORR_MATRIX_PLOT) $(BOXPLOT_LIVING_ROOM) $(BOXPLOT_DRAWING_ROOM) $(BOXPLOT_BATHROOM) $(PREDICTION_PLOT): $(SCRIPTS_DIR)/data_analysis.R $(PREPROCESSED_DATA)
	Rscript $< $(PREPROCESSED_DATA) $(CORR_MATRIX_PLOT) $(BOXPLOT_LIVING_ROOM) $(BOXPLOT_DRAWING_ROOM) $(BOXPLOT_BATHROOM) $(PREDICTION_PLOT)

# 生成报告
$(FINAL_REPORT): $(REPORT_DIR)/count_report.qmd $(CORR_MATRIX_PLOT) $(BOXPLOT_LIVING_ROOM) $(BOXPLOT_DRAWING_ROOM) $(BOXPLOT_BATHROOM) $(PREDICTION_PLOT)
	quarto render $<

# 清理生成的数据和图像
clean:
	rm -f $(PREPROCESSED_DATA)
	rm -f $(RESULTS_DIR)/exploration_output.txt
	rm -f $(CORR_MATRIX_PLOT) $(BOXPLOT_LIVING_ROOM) $(BOXPLOT_DRAWING_ROOM) $(BOXPLOT_BATHROOM) $(PREDICTION_PLOT)
	rm -f $(FINAL_REPORT)

# 创建必要的目录
$(RESULTS_DIR) $(FIGURES_DIR):
	mkdir -p $@

# 确保目录被创建
$(PREPROCESSED_DATA) $(CORR_MATRIX_PLOT) $(BOXPLOT_LIVING_ROOM) $(BOXPLOT_DRAWING_ROOM) $(BOXPLOT_BATHROOM) $(PREDICTION_PLOT): | $(RESULTS_DIR) $(FIGURES_DIR)
