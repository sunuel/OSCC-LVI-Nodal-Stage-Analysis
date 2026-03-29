# OSCC-LVI-Nodal-Stage-Analysis
import pandas as pd
# RNA-Seq pre-processing (Python)
df_unstranded = pd.read_csv('RNA_unstranded_240920.csv', index_col=0)
selected_samples = ["TCGA-4P-AA8J-01A-11R-A39I-07", ...] # sample list
f = df_unstranded[selected_samples]
f.to_csv('RNA_processed_counts.csv')
