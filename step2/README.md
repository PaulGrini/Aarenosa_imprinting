# Step 2
Bin reads by transcript.

## Salmon_Homozygous directory
Map parent RNAseq read pairs to reference transcripts for read-to-gene assignment. Use the salmon alignment-free read mapping software. As recommended in salmon documentation, the map substrate includes target transcript sequences plus genome assembly sequences as decoys. Transcript IDs star with “jg” and assembly IDs start with “GCA”. The k-mer size is 17 (make_transcripts_index.sh). The mapper is run once per replicate (grid_salmon.sh, run_salmon.sh). The salmon output bam files are post-processed to generate tsv files with format read-pair-ID, space, transcript-ID (grid_read2gene.sh, run_read2gene.sh). The outputs are named SxS_BR1 to MxM_BR4, using S and M for Sn and Pp ecotypes, and BR for biological replicate.   

    * make_transcripts_index.sh
    * grid_read2gene.sh
    * run_read2gene.sh
    * grid_salmon.sh
    * run_salmon.sh

## Salmon_Heterozygous directory
Map cross RNAseq read pairs to reference transcripts for read-to-gene assignment. Reuse the “homozygous” scripts but substitute cross reads. 
