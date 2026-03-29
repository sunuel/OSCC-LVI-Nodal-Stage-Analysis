# -----------------------------------------------------------------------------
# Script: 02_Differential_Expression_Analysis.R
# Purpose: Identify Differentially Expressed Genes (DEGs) between pN1 and pN2 groups.
# -----------------------------------------------------------------------------

# Load required libraries
library(DESeq2)
library(dplyr)
library(ggplot2)

# 1. Load the preprocessed count matrix and metadata
# These files were generated in '01_data_processing'
counts <- read.csv("./data/RNA_processed_matrix.csv", row.names = 1)
metadata <- read.csv("./data/Clinical_Processed_Metadata.csv", row.names = 1)

# Ensure sample names in counts match row names in metadata
counts <- counts[, rownames(metadata)]

# 2. Set up DESeq2 Data Set (dds)
# Design: Grouping based on Nodal Status (e.g., pN1 vs pN2)
dds <- DESeqDataSetFromMatrix(countData = round(counts),
                              colData = metadata,
                              design = ~ nodal_status)

# 3. Run Differential Expression Analysis
dds <- DESeq(dds)

# 4. Extract Results (Comparison: pN2 vs pN1)
res <- results(dds, contrast=c("nodal_status", "pN2", "pN1"))

# 5. Apply FDR (Benjamini-Hochberg) Correction & Filtering
# Filtering criteria: Adjusted P-value < 0.05 and |log2FoldChange| > 1
res_df <- as.data.frame(res) %>%
  filter(padj < 0.05 & abs(log2FoldChange) > 1) %>%
  arrange(padj)

# 6. Save the DEG Results
write.csv(res_df, "./data/DEG_pN2_vs_pN1_Results.csv")
message("DEG analysis complete. Results saved to 'DEG_pN2_vs_pN1_Results.csv'.")

# 7. Simple Visualization: Volcano Plot for Quality Check
ggplot(as.data.frame(res), aes(x=log2FoldChange, y=-log10(padj))) +
  geom_point(alpha=0.4, size=1.5) +
  theme_minimal() +
  labs(title="Volcano Plot: pN2 vs pN1",
       x="log2 Fold Change",
       y="-log10 Adjusted P-value") +
  geom_hline(yintercept=-log10(0.05), col="red", linetype="dashed")