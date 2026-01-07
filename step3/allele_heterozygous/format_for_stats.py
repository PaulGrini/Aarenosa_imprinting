'''
Input two files like SxM_BR1.mat.gene_counts.tsv
Input two files like SxM_BR1.pat.gene_counts.tsv
Expect tsv files with no header, and lines like...

jg10000.t1	422
jg10002.t1	64

Input two names like SS and MM
representing the maternal and paternal (heterozygous reads)
or the true and false parents (homozygous reads).

In cross SxM, mat is SS and pat is MM.
The first file should represent SS.
The second file should represent MM.

Output files like SxM_BR4.tsv
Generate tsv files with lines like...

gene  allele      count
jg10000.t1    SS    20
jg10002.t1    MM    10
'''
import sys

def load_counts(fn):
    gene_counts = dict()
    with open (fn, 'r') as fin:
        header = "NO HEADER" # None
        for line in fin:
            if header is None:
                header = line
                continue
            line = line.strip()
            (gene,count) = line.split('\t')
            if gene in gene_counts.keys():
                raise Exception('Gene seen twice:',gene)
            gene_counts[gene]=count
    return gene_counts
    
MAT_file = sys.argv[1]
PAT_file = sys.argv[2]
MAT_name = sys.argv[3]
PAT_name = sys.argv[4]
out_file = sys.argv[5]
print('Reading MAT from',MAT_file)
MAT_dict = load_counts(MAT_file)
print('Reading PAT from',PAT_file)
PAT_dict = load_counts(PAT_file)

all_genes = set()
for gene in MAT_dict.keys():
    all_genes.add(gene)
for gene in PAT_dict.keys():
    all_genes.add(gene)
sorted_genes = sorted(list(all_genes))

with open (out_file, 'w') as fout:
    print('gene','allele','count', sep='\t', file=fout)
    for gene in sorted_genes:
        if gene in MAT_dict.keys():
            print(gene, MAT_name, MAT_dict[gene], sep='\t', file=fout)
        if gene in PAT_dict.keys():
            print(gene, PAT_name, PAT_dict[gene], sep='\t', file=fout)
print('Wrote to',out_file)

