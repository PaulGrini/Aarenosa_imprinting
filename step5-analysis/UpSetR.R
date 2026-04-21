#make UpSet diagram

install.packages("UpSetR")

library(VennDiagram)
library(tidyverse)
library(dplyr)
library(grid)
library(RColorBrewer)
library(UpSetR)

#read data: PEGs in all species
gene_data <- read.delim("ArenosaIRP/Heterozygous/Salmon-MER_HeterozygousStats/Brassicacea_PEGs_ex-uniqV4.txt", header = TRUE)
head(gene_data) 
gene_data

# Prepare lists from each column in gene_data (names cannot contain blank spaces)
list_input <- list(
  A.thaliana = gene_data$thaliana,
  A.arenosa  = gene_data$arenosa,
  A.lyrata  = gene_data$lyrata,
  B.rapa  = gene_data$rapa,
  B.napus  = gene_data$napus,
  C.rubella  = gene_data$rubella,
  C.grandiflora = gene_data$grandiflora,
  C.orientalis = gene_data$orientalis
)

# Remove NAs and empty strings that might be present in each list (THIS IS IMPORTANT!!)
list_input <- lapply(list_input, function(x) na.omit(x[x != ""]))

# Convert the list to an UpSetR-compatible binary matrix
binaryMatrix <- fromList(list_input)

# Print the head of the binary matrix to confirm transformation correctness
head(binaryMatrix)
binaryMatrix

# Create the UpSet plot
upset(binaryMatrix, sets = names(list_input), order.by = "freq")

#WITH COLORS:
# Print the head of the binary matrix to confirm transformation correctness
head(binaryMatrix)
binaryMatrix

# Set custom colors for the sets (NB!!!!  COLORING WILL BE BY ORDER IN THE PLOT NOT BY NAME OF SET!!!!!)
set_colors <- c("A.thaliana" = "darkblue",
                "A.arenosa"    = "#008080",
                "A.lyrata"  = "#008080",
                "C.rubella"   = "darkblue",
                "C.grandiflora" = "#008080",
                "C.orientalis" = "darkblue",
                "B.rapa"     = "darkblue",
                "B.napus"  = "#008080")

# Specify the custom order for the sets
custom_order <- c("B.napus", "B.rapa", "C.orientalis", "C.grandiflora", "C.rubella", "A.thaliana", "A.lyrata", "A.arenosa")

# Create the UpSet plot
upset(binaryMatrix, 
      sets = custom_order,    # Manually order the sets
      keep.order = TRUE,      # Keep the order specified
      sets.bar.color = set_colors[custom_order],    # Apply custom colors
      order.by = "freq")      # Order by frequency (if desired)


dev.off()


