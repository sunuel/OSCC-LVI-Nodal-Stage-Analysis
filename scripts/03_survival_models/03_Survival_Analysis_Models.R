# -----------------------------------------------------------------------------
# Script: 03_Survival_Analysis_Models.R
# Purpose: Perform Kaplan-Meier Survival Analysis and Cox Proportional Hazards Models.
# -----------------------------------------------------------------------------

# Load required libraries
library(survival)
library(survminer)
library(readxl)
library(dplyr)

# 1. Load the survival data
# Original file: '카플란_GSE41613_cox_scaled_micro_0321.xlsx'
# Ensure the data contains: Time (OS.time), Event (OS/Status), and Grouping Variables
surv_data <- read_excel("./data/survival_data_cleaned.xlsx")

# 2. Kaplan-Meier Survival Analysis
# Comparing survival rates between high and low expression groups (or pN stages)
fit <- survfit(Surv(OS.time, OS) ~ Group, data = surv_data)

# 3. Visualize Kaplan-Meier Curves
# This generates a publication-quality survival plot
km_plot <- ggsurvplot(fit, 
           data = surv_data,
           pval = TRUE,             # Display P-value
           conf.int = TRUE,         # Show confidence interval
           risk.table = TRUE,       # Add risk table at the bottom
           legend.labs = c("Group Low", "Group High"),
           palette = c("#E7B800", "#2E9FDF"),
           title = "Overall Survival by Gene Expression")

print(km_plot)

# 4. Multivariate Cox Proportional Hazards Model
# Adjusting for clinical covariates (Age, T stage, PNI, etc.)
cox_model <- coxph(Surv(OS.time, OS) ~ Gene_Expression + Age + AJCC_pT + PNI, 
                   data = surv_data)

# 5. Summary of Cox Model Results
summary_cox <- summary(cox_model)
print(summary_cox)

# 6. Check Proportional Hazards Assumption
# Crucial for reviewer validation (Schoenfeld residuals test)
ph_test <- cox.zph(cox_model)
print(ph_test)

# 7. Save the Results
write.csv(summary_cox$coefficients, "./data/Cox_Regression_Results.csv")
ggsave("./results/Survival_KM_Plot.tiff", plot = km_plot$plot, device = "tiff", dpi = 300)

message("Survival analysis complete. Plots and statistics saved.")