# Scripts overview

K-IRP is implemented in shell, Python, and R scripts. Scripts named "grid*" use slurm job scheduling to launch scripts named "run*" in parallel. As in IRP, "homozygous" refers to parental data, and "heterozygous" refers to cross data.

Scripts assume the unix O/S, slurm job scheduling, and 4 replicates per experiment. Dependencies include python, samtools, salmon, meryl, R, and limma. Scripts assume reads have been processed by trimmomatic to trim low-quality base calls at read ends. Scripts run in the order listed.

# Step 1
Count k-mers in reads.

## Extract_Mers directory
Count k-mers among parental read pairs in each replicate. Use the following utilities from the meryl k-mer software: “meryl count” does the counting, and “meryl greater-than” enforces a minimum threshold (run_mers_count.sh, run_mers_count.sh). The k-mer size is 15 and the minimum threshold is 5. Finally, for each replicate, the parent intersections are computed with “meryl difference” and “meryl intersect.” Reports for visual inspection are generated with “meryl statistics.” In directories named BR1 to BR4, intermediate results are computed in various subdirectories then collected into meryl databases with names like parent1 “minus” parent 2 (run_mer_differences.sh). 

    * grid_mers_count.sh
    * run_mers_count.sh
    * run_mer_differences.sh
    * test_5_minus_1.sh -- not used

## Meryl_Homozygous directory
Assign parent read pairs to one parent, where possible. This is to help detect genes that might cause false negatives and false positives later. Uses the previously computed sets of parent-specific k-mers. Convert read pair fastq files to fasta (grid_fasta_homoz.sh, make_fasta.sh). Use the “meryl-lookup” utility to count parent-specific k-mers per read pair (grid_lookup_homoz.sh, run_lookup_homoz.sh). Assign read pairs to a parent if they contain one or more k-mers specific to one parent, and none specific to the other (grid_combine.sh, run_combine.sh, combine_meryl_reads.py). Sort the IDs and generate files like MxM_BR1.mat.IDs.txt that contain IDs of the parentally assigned read pairs (sort_parental_reads.sh).

   * grid_fasta_homoz.sh
   * make_fasta.sh
   * grid_lookup_homoz.sh
   * run_lookup_homoz.sh
   * grid_combine.sh
   * run_combine.sh
   * combine_meryl_reads.py
   * sort_parental_reads.sh
   * test_lookup.sh - not used

## Meryl_Heterozygous directory
Assign cross read pairs to one parent, where possible. Reuses the “homozygous” scripts but substitute cross reads.
