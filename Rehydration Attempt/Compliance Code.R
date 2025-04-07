# Check if the 'devtools' package is installed; if not, install it
if(!require(devtools)) install.packages("devtools")

# Install the 'twCompliance' package from GitHub repository, for more information and a tutorial on how to
# rehydrate Twitter data, see here: https://github.com/Kudusch/twCompliance
devtools::install_github("Kudusch/twCompliance@main")

# Load the 'twCompliance' library, which provides functions for compliance checks with Twitter API
library(twCompliance)

# Call the 'set_bearer()' function to set the Twitter API bearer token (authentication)
# Restart your R environment after this
set_bearer()

# Preview the first few rows of an example dataset 'df.example_data' (assumed to be preloaded or available)
head(df.example_data)

# Specify the file path to a text file containing status IDs and user IDs for rehydration here
file_path <- "" 

# Load the text file and read only the first 4 lines to minimize data size during testing
lines <- # specifiy here how you want to load the data

# Check if the API responds to you
# Create a data frame with a single column named 'status_id' from the lines read
example_data <- data.frame(status_id = lines, stringsAsFactors = FALSE)

# Print the first few rows of the newly created data frame to confirm it was loaded correctly
head(example_data)

# Perform a compliance check on the dataset to identify any non-compliant or invalid status IDs
start_compliance_check(example_data)

# Convert the 'status_id' column to integer format (required for some compliance check functions)
example_data$status_id <- as.integer(example_data$status_id)

# Perform the compliance check again after converting the IDs to integers
start_compliance_check(example_data)

# Store the result of the compliance check in a variable for further analysis
check_id.example_data <- start_compliance_check(example_data)

# Create a subset of the dataset with the first 5 rows of the 'data' object (assumes 'data' is loaded elsewhere)
status_id_vector <- data[1:5, ]
subset_data <- data.frame(status_id = status_id_vector[1:5])

# Perform a compliance check on the subset of the dataset
check_id.example_data <- start_compliance_check(subset_data)

# Download the results of the compliance check for the 'example_data' dataset
check_df.example_data <- download_compliance_check(example_data)

# If the API works for you use your own data set to query the API
