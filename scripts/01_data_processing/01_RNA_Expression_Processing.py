import pandas as pd

# 1. Load the raw TCGA unstranded RNA-Seq data
# Note: Ensure the raw file is located in the './data/' directory
try:
    df_unstranded = pd.read_csv('./data/RNA_unstranded_240920.csv', index_col=0)
    print("Original Matrix Shape:", df_unstranded.shape)
except FileNotFoundError:
    print("Error: Raw data file not found. Please check './data/RNA_unstranded_240920.csv'")

# 2. List of target TCGA barcodes used in the study (Extracted from your documents)
target_samples = [
    "TCGA-4P-AA8J-01A-11R-A39I-07", "TCGA-BA-4074-01A-01R-1436-07",
    "TCGA-BA-5149-01A-01R-1514-07", "TCGA-BA-5151-01A-01R-1436-07",
    "TCGA-BA-5152-01A-02R-1873-07", "TCGA-BA-5556-01A-01R-1514-07",
    "TCGA-BA-5558-01A-01R-1514-07", "TCGA-BA-6872-01A-11R-1873-07",
    "TCGA-BA-6873-01A-11R-1873-07", "TCGA-BA-A6DB-01A-11R-A30B-07"
    # ... Add more barcodes as needed
]

# 3. Filter the matrix to include only selected samples
# Ensure barcodes exist in the columns
available_samples = [s for s in target_samples if s in df_unstranded.columns]
df_filtered = df_unstranded[available_samples]

# 4. Save the processed matrix for downstream analysis (DEG, Survival)
df_filtered.to_csv('./data/RNA_processed_matrix.csv')
print(f"Success: Processed {len(available_samples)} samples and saved to CSV.")