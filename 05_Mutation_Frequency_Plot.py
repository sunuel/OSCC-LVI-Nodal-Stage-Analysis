import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# 1. Prepare frequency data (Example based on your revision notes)
# Data: Mutation proportions for specific genes in pN1 vs pN2 groups
data = {
    'Gene': ['Gene A', 'Gene B', 'Gene C', 'Gene D'],
    'pN2_Group': [0.45, 0.38, 0.30, 0.25], # Frequency in pN2
    'pN1_Group': [0.15, 0.20, 0.10, 0.05]  # Frequency in pN1 (Rest)
}
df = pd.DataFrame(data)

# 2. Plotting - Mutation Frequency (Proportion)
fig, ax = plt.subplots(figsize=(10, 6))
X_idx = np.arange(len(df.Gene))

# Vertical Bar Chart (Bidirectional to show contrast)
plt.bar(X_idx, df.pN2_Group, facecolor='#d62728', edgecolor='white', label='pN2 Group')
plt.bar(X_idx, -df.pN1_Group, facecolor='#798287', edgecolor='white', label='pN1 Group')

# 3. Add Labels & Styling (Addressing Reviewer Point 4-iii)
plt.axhline(0, color='black', linewidth=1)
plt.ylim(-0.4, 0.6)
y_ticks = np.arange(-0.4, 0.7, 0.2)
plt.yticks(y_ticks, [f"{abs(t):.1f}" for t in y_ticks], fontsize=12)

plt.xticks(X_idx, df.Gene, fontsize=12, fontweight='bold')
plt.ylabel('Mutation Frequency (Proportion)', fontsize=14, fontweight='bold')
plt.legend()
plt.title('Comparison of Mutation Frequencies: pN2 vs pN1', fontsize=16)

# 4. Save for Publication
plt.tight_layout()
plt.savefig('./results/Figure_Mutation_Frequency.tiff', dpi=300)
plt.show()