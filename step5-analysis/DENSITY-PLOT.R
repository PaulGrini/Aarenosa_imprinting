install.packages("GGally")
install.packages("viridis")
install.packages("MASS")
library(viridis)
library(ggplot2)
library(dplyr)
library(hexbin)
library(GGally)
library(MASS)



#Plot LogFC cross1 over LogFC cross2


limma_results_Salmon_MxS <- read.csv("ArenosaIRP/Heterozygous/Salmon-MER_HeterozygousStats/MxS.counts.csv.filtered.final.csv", header = FALSE, row.names = 1)
head(limma_results_Salmon_MxS)
limma_results_Salmon_MxS
# manually name columns
names(limma_results_Salmon_MxS) <- c("mat", "mat", "mat", "mat", "pat", "pat", "pat", "pat", "num", "log2FC", "AveExpr", "t-val", "p-value", "adj.p-value", "B-log-odds", "FC") 
head(limma_results_Salmon_MxS)

limma_results_Salmon_SxM <- read.csv("ArenosaIRP/Heterozygous/Salmon-MER_HeterozygousStats/SxM.counts.csv.filtered.final.csv", header = FALSE, row.names = 1)
head(limma_results_Salmon_SxM)

names(limma_results_Salmon_SxM) <- c("mat", "mat", "mat", "mat", "pat", "pat", "pat", "pat", "num", "log2FC", "AveExpr", "t-val", "p-value", "adj.p-value", "B-log-odds", "FC") 
head(limma_results_Salmon_SxM)


# Merge the two data sets by rownames (gene names must match)
merged_data <- merge(limma_results_Salmon_MxS, limma_results_Salmon_SxM, by = "row.names", suffixes = c("_MxS", "_SxM"))
head(merged_data)
# names(merged_data) <- c("mat", "mat", "mat", "mat", "pat", "pat", "pat", "pat", "num", "log2FC", "AveExpr", "t-val", "p-value", "adj.p-value", "B-log-odds", "FC", "mat", "mat", "mat", "mat", "pat", "pat", "pat", "pat", "num", "log2FC", "AveExpr", "t-val", "p-value", "adj.p-value", "B-log-odds", "FC") 
head(merged_data)
merged_data

subsetmerged_data <- merged_data[, c("Row.names", "log2FC_MxS", "log2FC_SxM")]
head(subsetmerged_data)
subsetmerged_data <- as.data.frame(subsetmerged_data) 


merged_data <- as.data.frame(merged_data)
head(merged_data)

head(subsetmerged_data)

# Calculate density for points using MASS::kde2d
density_estimation <- kde2d(subsetmerged_data$log2FC_MxS, subsetmerged_data$log2FC_SxM, n = 200)
density_values <- data.frame(expand.grid(x = density_estimation$x, y = density_estimation$y), z = as.vector(density_estimation$z))

# Merge density data with original data
subsetmerged_data$density <- with(subsetmerged_data, apply(cbind(log2FC_MxS, log2FC_SxM), 1, function(point) {
  # Find the nearest grid point in the density estimation
  closest <- which.min((density_values$x - point[1])^2 + (density_values$y - point[2])^2)
  density_values$z[closest]
}))

head(subsetmerged_data)

density_scatter_plot <- ggplot(subsetmerged_data, aes(x = log2FC_MxS, y = log2FC_SxM, color = density)) +
  geom_point(alpha = 0.6, size = 0.5) +  # Scatter plot points with density coloring
  scale_color_viridis_c(option = "C") +  # Use viridis color scale
  labs(
    title = "Log2FC Comparison",
    x = "log2FC K-IRP PpxSn",
    y = "log2FC K-IRP SnxPp"
  ) +
  geom_hline(yintercept = c(0), col = c("black"), lty = c(1)) +  # Horizontal lines
  geom_vline(xintercept = c(0), col = c("black"), lty = c(1)) +  # Vertical lines
  geom_abline(intercept = 0, slope = 1, col = "black", lty = 2) +  # Diagonal line
  theme_minimal()

print(density_scatter_plot)


