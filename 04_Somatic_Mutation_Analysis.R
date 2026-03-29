# -----------------------------------------------------------------------------
# Script: 04_Somatic_Mutation_Analysis.R
# Purpose: Compare mutation profiles between groups and generate Oncoplots.
# -----------------------------------------------------------------------------

# Load required libraries
library(maftools)
library(dplyr)
library(openxlsx)

# 1. Load and Merge MAF (Mutation Annotation Format) files
# LVI0: Lymphovascular Invasion Absence / LVI1: Presence
path_lvi0 <- "./data/LVI_0/"
path_lvi1 <- "./data/LVI_1/"

# List all maf files in each directory
files_lvi0 <- list.files(path_lvi0, full.names = TRUE)
files_lvi1 <- list.files(path_lvi1, full.names = TRUE)

# Merge individual MAF files into a single MAF object
maf_lvi0 <- merge_mafs(files_lvi0, verbose = TRUE)
maf_lvi1 <- merge_mafs(files_lvi1, verbose = TRUE)

# 2. Compare Mutations Between Two Groups
# Identify differentially mutated genes
mutation_comparison <- mafCompare(m1 = maf_lvi0, 
                                  m2 = maf_lvi1, 
                                  m1Name = 'LVI_Absence', 
                                  m2Name = 'LVI_Presence', 
                                  minMut = 5)

print(mutation_comparison)

# 3. Save Statistical Results
write.xlsx(mutation_comparison$results, file = "./results/Mutation_Comparison_LVI0vs1.xlsx")

# 4. Generate Oncoplots (Waterfall Plots)
# Visualizing top mutated genes in both groups
tiff("./results/Oncoplot_LVI_Comparison.tiff", units="in", width=10, height=8, res=300)
oncoplot(maf = maf_lvi1, top = 20, fontSize = 0.8, titleText = "Top Mutated Genes (LVI Presence)")
dev.off()

# 5. Forest Plot to visualize Odd's Ratio of differentially mutated genes
tiff("./results/ForestPlot_Mutation_Difference.tiff", units="in", width=7, height=5, res=300)
forestPlot(mafCompareRes = mutation_comparison, pVal = 0.05)
dev.off()

message("Mutation analysis complete. Results and plots saved to './results/'.")