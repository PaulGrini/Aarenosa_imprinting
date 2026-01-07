#!/bin/sh
date

echo "Index reference transcripts. No decoys. Let salmon choose K."
./salmon index -t consensus_0/consensus.fasta -i Aa_nodecoy_auto
echo "$? salmon exit status"  
date
exit

echo "Start with a copy of the transcript sequences."
cp transcript_directory/MxM.fasta Aarenosa.transcripts_and_decoys.fasta

echo "Add copies of the genome sequences."
cat GCA_026151155.1_UiO_Aaren_v1.0_genomic.fna >> Aarenosa.transcripts_and_decoys.fasta 

echo "List the genome sequences as decoys."
grep '^>' GCA_026151155.1_UiO_Aaren_v1.0_genomic.fna | cut -d ' ' -f 1 | cut -c 2- > decoys.txt

echo "Run salmon"
KSIZE=17
# Salmon docs recommend 31 for human, and we expect more variation
# Salmon docs say this is a minimum and it must be odd
echo "K= ${KSIZE}"
../salmon index -t Aarenosa.transcripts_and_decoys.fasta -i Aa_index_${KSIZE} --decoys decoys.txt -k ${KSIZE}

date
echo done
