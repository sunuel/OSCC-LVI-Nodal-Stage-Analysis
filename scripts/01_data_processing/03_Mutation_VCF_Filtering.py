import pandas as pd
import re

# 1. Initialize dataframe for storing variants
columns = ['CHROM', 'POS', 'REF', 'ALT', 'FILTER', 'INFO']
result = pd.DataFrame(columns=columns)

# 2. Process the VCF file (e.g., STN005.variants.vcf)
vcf_input = './data/STN005.variants.vcf'

try:
    with open(vcf_input, 'r') as f:
        for line in f:
            # Skip metadata/header lines starting with '#'
            if line.startswith('#'):
                continue
            
            fields = line.strip().split('\t')
            
            # 3. Filtering: Only include variants that passed quality control ('PASS')
            if fields[6] == 'PASS':
                row_data = {
                    'CHROM': fields[0], 'POS': fields[1], 'REF': fields[3], 
                    'ALT': fields[4], 'FILTER': fields[6], 'INFO': fields[7]
                }
                result = pd.concat([result, pd.DataFrame([row_data])], ignore_index=True)

    # 4. Detailed Annotation Parsing (Splitting the INFO field by '|')
    # This aligns with the mutation severity analysis in the paper
    anno_split = result['INFO'].str.split('|', expand=True)
    final_output = pd.concat([result, anno_split], axis=1)

    # 5. Save the filtered somatic mutation data
    final_output.to_csv('./data/STN005_PASS_variants.csv', index=False)
    print(f"Mutation filtering complete. {len(result)} PASS variants identified.")

except FileNotFoundError:
    print(f"Error: {vcf_input} not found.")