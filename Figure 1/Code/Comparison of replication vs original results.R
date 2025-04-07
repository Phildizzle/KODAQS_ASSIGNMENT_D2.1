# Comparison for 2016 results
# Set file paths
data1 <- read.csv(file.choose()) #"table_data_unique_users_2016_remade.csv"
data2 <- read.csv(file.choose()) #"table_data_unique_users_2016.csv"

# Compare the data frames
if (identical(data1, data2)) {
  print("The two files are identical.")
} else {
  print("The two files are not identical.")
}

# Compare the data frames and show differences
comparison_result <- all.equal(data1, data2)

# Print the results
if (isTRUE(comparison_result)) {
  print("The two files are identical.")
} else {
  print("The files are not identical. Differences are:")
  print(comparison_result)
}

# Comparison for 2020 results
# Set file paths
file1 <- read.csv(file.choose()) #"table_data_unique_users_2020_remade.csv"
file2 <- read.csv(file.choose()) #"table_data_unique_users_2020.csv"

# Compare the data frames
if (identical(data1, data2)) {
  print("The two files are identical.")
} else {
  print("The two files are not identical.")
}

# Compare the data frames and show differences
comparison_result <- all.equal(data1, data2)

# Print the results
if (isTRUE(comparison_result)) {
  print("The two files are identical.")
} else {
  print("The files are not identical. Differences are:")
  print(comparison_result)
}

