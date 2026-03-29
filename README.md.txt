Molecular Landscapes of OSCC Nodal Progression
This repository contains custom scripts for multi-omics integration, immune deconvolution, and survival analyses as presented in the paper: "Molecular Landscapes of OSCC Nodal Progression: Integrating ENE-Associated Genes into pN1 and pN2 Mutational Networks".

Table of Contents
Prerequisites

Workflow & Execution Order

Directory Structure

Key Analyses

Reproducibility

Prerequisites
The analyses were performed using R (v4.x) and Python (v3.9+).

Required R Packages
DESeq2, survival, survminer, maftools, dplyr, ggplot2, goseq, readxl

Required Python Libraries
pandas, numpy, scipy, matplotlib, seaborn

Workflow & Execution Order
To reproduce the findings of this study, please execute the scripts in the following sequence:

Data Preprocessing (/scripts/01_data_processing/)

Run 01_RNA_Expression_Processing.py and 02_Clinical_Metadata_Cleaning.R to prepare the analytic datasets from raw TCGA and clinical metadata.

(Optional) Run 03_Mutation_VCF_Filtering.py to filter somatic variants from VCF files.

Differential Expression Analysis (/scripts/02_deg_analysis/)

Run 02_Differential_Expression_Analysis.R to identify DEGs between pN1 and pN2 groups using the DESeq2 framework.

Survival Analysis (/scripts/03_survival_models/)

Run 03_Survival_Analysis_Models.R to generate Kaplan-Meier curves and perform Multivariate Cox Proportional Hazards regression adjusted for clinical covariates.

Mutation Landscape (/scripts/04_mutation_analysis/)

Run 04_Somatic_Mutation_Analysis.R to compare mutation frequencies and generate Oncoplots (Waterfall plots) using maftools.

Scientific Visualization (/scripts/05_visualization/)

Run 05_Mutation_Frequency_Plot.py and 06_Enrichment_Plot.R to produce high-resolution figures (e.g., Mutation frequency bar charts and GO enrichment plots).

Directory Structure
Plaintext
.
├── data/                  # Placeholder for raw/processed data (e.g., TCGA counts, metadata)
├── scripts/
│   ├── 01_data_processing/ # Data cleaning and matrix generation
│   ├── 02_deg_analysis/    # DESeq2 and fold-change filtering
│   ├── 03_survival_models/ # KM plots and Cox PH models
│   ├── 04_mutation_analysis/# maftools comparison and oncoplots
│   └── 05_visualization/   # Publication-quality figure generation
├── results/               # Output directory for plots and statistical tables
└── README.md
Key Analyses
eQTL Analysis: Examining the impact of somatic mutations on transcript levels using non-parametric statistical tests.

Proportional Hazard Validation: Testing the PH assumption for Cox models using Schoenfeld residuals (cox.zph).

Mutation Frequency Comparison: Statistical validation of mutation enrichment in pN2 vs. pN1 cohorts.

Reproducibility
To ensure full reproducibility:

All R scripts use set.seed(123) for stochastic processes.

Absolute file paths (e.g., C:/Users/...) have been replaced with relative paths (./data/).

Parameters for FDR (Benjamini-Hochberg) correction are explicitly defined in the DEG and survival scripts.

License
This project is licensed under the MIT License - see the LICENSE file for details.