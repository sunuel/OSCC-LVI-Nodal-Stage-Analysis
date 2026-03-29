library(ggplot2)
library(dplyr)
library(forcats)

# 1. Load GO Enrichment results (from 02_deg_analysis)
# go_results <- read.csv("./results/GO_Analysis_Results.csv")

# 2. Select top 5-10 Biological Processes
go_plot_data <- goResults %>%
  top_n(5, wt = -over_represented_pvalue) %>%
  mutate(neg_log_p = -log10(over_represented_pvalue))

# 3. Create Bar Plot
ggplot(go_plot_data, aes(x = numDEInCat, y = fct_reorder(term, neg_log_p), fill = over_represented_pvalue)) +
  geom_col() +
  scale_fill_gradient(low = "red", high = "blue") +
  labs(title = "GO Enrichment Analysis (BP)",
       x = "Number of DEGs",
       y = "Biological Process Term",
       fill = "P-value") +
  theme_minimal()

# 4. Save Image
ggsave("./results/Figure_GO_Enrichment.tiff", width = 18, height = 6, units = "cm", dpi = 300)