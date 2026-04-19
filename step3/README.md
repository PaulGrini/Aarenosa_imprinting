# Step 3
Assign reads to alleles.

## Allele_Homozygous directory
Combine parent assignments and gene assignments to generate allele assignments per read pair. This is done first one the parental reads to help detect genes that might cause false negatives and false positives later. The parent assignments were generated with meryl software. The gene assignments were generated with salmon software. Generate intermedia tsv files (run_walker.sh, read_walker.py). Combine those into files containing gene-ID, tab, count, with filenames like SxS_BR1.mat.gene_counts.tsv (format_homoz_stats.sh, format_for_stats.py).

    * run_walker.sh
    * run_walker1.sh - was used for a partial rerun on hetero
    * run_walker2.sh - was used for a partial rerun on hetero
    * read_walker.py
    * format_homoz_stats.sh
    * format_for_stats.py

## Run_Filter directory
Filter genes with insufficient reads and genes that show false positive allelism. In the "homozygous" folder above, K-IRP runs on simulated crosses prepared by mising parental read pairs in equal proportions. The following scripts require a table that describes the experimental design's replicates and crosses (main.model.tsv). They also require counts from tsv files generated upstream. Various thresholds were tested, and appropriate thresholds were selected by elbow analysis (run_filter_homozygous_various.sh). An IRP script counts reads per gene and per parent (filter_homozygous.py). 

    * main.model.tsv
    * run_filter_homozygous_various.sh
    * filter_homozygous.py

## Allele_Heterozygous directory
Count read pairs per gene per parental allele. Reuse the “homozygous” scripts but substitute cross reads.

