# OSCC-LVI-Nodal-Stage-Analysis
import pandas as pd
# RNA-Seq 전처리 (Python)
df_unstranded = pd.read_csv('RNA_unstranded_240920.csv', index_col=0)
selected_samples = ["TCGA-4P-AA8J-01A-11R-A39I-07", ...] # 샘플 리스트
f = df_unstranded[selected_samples]
f.to_csv('RNA_processed_counts.csv')
