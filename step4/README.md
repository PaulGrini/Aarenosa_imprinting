# Step 4
Generate statistics.

These scripts are inherited from IRP. Various scripts are launched by the main shell script (run_prepare_run_stats_V2.sh). It launches a Python script to prepare text files in the proper format (prepare_heterozygous_counts.py). That script takes the experimental design from a tabular file (model.tsv). A second Python script filters genes from the text files (apply_filter_to_counts.py). A third Python script generates statistics (statistics_from_counts.py). It launches R and runs the R script (limma.foldchange.r). The R script which uses the limma differential expression package to calculate fold changes and adjusted p-values. 

* run_prepare_run_stats_V2.sh
* prepare_heterozygous_counts.py
* model.tsv
* apply_filter_to_counts.py
* statistics_from_counts.py
* limma.foldchange.r
