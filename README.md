# OSCC-LVI-Nodal-Stage-Analysis
library(survival)
# Multivariate Cox PH Model
cox_mod <- coxph(Surv(OS.time, OS) ~ Gene + Age + AJCC_pathologic_pT + 
                 Perineural_invasion + Treatment_modality, data = df)
# Proportional Hazards Test
ph_test <- cox.zph(cox_mod)
print(ph_test)
