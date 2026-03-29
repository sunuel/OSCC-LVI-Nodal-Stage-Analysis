# Load required libraries
library(readxl)
library(dplyr)

# 1. Import the clinical metadata (e.g., LVI status, pN stage)
# Original file: LVI_293.xlsx or pN2_LVI.xlsx
clinical_file_path <- "./data/LVI_293.xlsx"

if (file.exists(clinical_file_path)) {
  clinical_data <- read_excel(clinical_file_path)
  
  # 2. Transpose the data frame for downstream matching with expression matrices
  # In OSCC analysis, we often need samples as columns or rows depending on the tool
  clinical_transposed <- t(clinical_data)
  
  # 3. Save as CSV for reproducibility
  write.csv(clinical_transposed, file="./data/Clinical_Processed_Metadata.csv", row.names = TRUE)
  
  message("Clinical data processing complete. Output: Clinical_Processed_Metadata.csv")
} else {
  stop("Clinical file not found at: ", clinical_file_path)
}