
install.packages("BiocManager")
BiocManager::install("clusterProfiler")
BiocManager::install("org.At.tair.db")  # Annotation package for Arabidopsis
library(clusterProfiler)
library(org.At.tair.db) # Load the Arabidopsis annotation package
library(RColorBrewer) # for a colourful plot
library(dplyr)      # For data manipulation
library(ggplot2)    # For plotting, if preferred


#read data: PEGs in all species
gene_data <- read.delim("arenosa_PEGs.txt", header = TRUE)
head(gene_data) 
gene_data
# transform
deg_genes <- gene_data$arenosa

# View the first few gene IDs
head(deg_genes)
deg_genes

# Perform GO enrichment analysis
go_enrich <- enrichGO(gene = deg_genes,
                      OrgDb = org.At.tair.db,  # Use Arabidopsis annotation database
                      keyType = "TAIR",  # Use the appropriate key type, "TAIR" for Arabidopsis identifiers
                      ont = "MF",        # Choose the ontology; "BP", "CC", or "MF"
                      pAdjustMethod = "BH",
                      qvalueCutoff = 0.05,
                      readable = TRUE)  # Make terms more readable if possible
# View results
head(go_enrich)

#HMake dot-plot with ggplot:
# Convert to a data frame
go_enrich_df <- as.data.frame(go_enrich)
go_enrich_df

# Filter out texessive categories if necessary
filtered_go_enrich_df <- go_enrich_df %>%
  filter(!grepl("ugenee|bottle", Description))  # Pipe for several unwanted categories

# Check the structure of the filtered data frame
print(filtered_go_enrich_df)

#Set the exact P-values on the Scale:
# Calculate -log10(p.adjust) for proper scaling
filtered_go_enrich_df <- filtered_go_enrich_df %>%
  mutate(log_p_adjust = -log10(p.adjust))  # Create a new column for -log10(p.adjust)

# Determine the minimum and maximum adjusted p-values from the filtered data
min_p_value <- min(filtered_go_enrich_df$p.adjust)
max_p_value <- max(filtered_go_enrich_df$p.adjust)
min_p_value
max_p_value

# Define a customizable max scale for the y-axis
custom_max <- 10  # You can adjust this value

#DotPlot with GeneRatio in x-axis:
# Convert GeneRatio from "X/Y" format to numeric ratio
filtered_go_enrich_df <- filtered_go_enrich_df %>%
  mutate(GeneRatio = as.numeric(sub("/.*", "", GeneRatio)) / as.numeric(sub(".*?/", "", GeneRatio)))

ggplot(filtered_go_enrich_df, aes(x = GeneRatio, y = reorder(Description, -Count), color = log_p_adjust)) +
  geom_point(aes(size = Count), alpha = 0.8) +  # Use points; size corresponds to Count
  scale_color_gradient(
    low = "royalblue", 
    high = "salmon", 
    name = "Adj. p-value",
    limits = c(min(filtered_go_enrich_df$log_p_adjust, na.rm = TRUE), 
               max(filtered_go_enrich_df$log_p_adjust, na.rm = TRUE)),  # Set limits based on your data
    breaks = c(min(-log10(max(filtered_go_enrich_df$p.adjust, na.rm = TRUE))), 
               max(-log10(min(filtered_go_enrich_df$p.adjust, na.rm = TRUE)))),  # Adjust breaks 
    labels = c(sprintf("%.3g", max(filtered_go_enrich_df$p.adjust, na.rm = TRUE)), 
               sprintf("%.3g", min(filtered_go_enrich_df$p.adjust, na.rm = TRUE)))  # Correct labeling
  ) +
  labs(title = "GO Enrichment (MEGs-CC)", 
       x = "Gene Ratio", 
       y = "GO Term") +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.25)) +  # Set limits and breaks for GeneRatio
  scale_y_discrete() +  # Use scale_y_discrete for categorical y-axis
  theme_minimal() +
  geom_text(aes(label = round(FoldEnrichment, 2)), 
            position = position_nudge(x = 0.2),  # Adjust text position next to the dot
            size = 4)    # Adjust text size as needed
dev.off()
