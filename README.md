# OSCC-LVI-Nodal-Stage-Analysis
from scipy.stats import mannwhitneyu, kruskal
# eQTL Analysis: Mann-Whitney U test for WT vs Mutation groups
stat, pval = mannwhitneyu(wt_samples[tpm_col], mut_samples[tpm_col])
