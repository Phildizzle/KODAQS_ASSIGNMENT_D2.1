#!/bin/bash

# Exit immediately if a command fails
set -e

# Define the relative path to the code folder
CODE_DIR="Figure 1/Code"

# Run the R scripts
echo "Running barplot_unique_user_and_table_plotter.R, etc."
Rscript "$CODE_DIR/barplot_unique_user_and_table_plotter.R"

echo "Running Comparison of replication vs original results.R, etc."
Rscript "$CODE_DIR/Comparison of replication vs original results.R"

echo "Running tables_generator.R, etc."
Rscript "$CODE_DIR/tables_generator.R"

echo "All scripts completed successfully."
