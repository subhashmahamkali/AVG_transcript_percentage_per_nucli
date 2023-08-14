# Create an empty list to store the results
nuc_percentage_list <- list()

# Iterate over each folder
for (folder in folders) {
  # Set the current folder path
  folder_path <- file.path(main_directory, folder)
  
  # Set the working directory to the current folder
  setwd(folder_path)
  
  # List the files in the current folder
  files <- list.files(pattern = "*.csv")
  
  # Find the CSV file with "localization results by cell" in its name
  target_file <- grep("localization results by cell", files, value = TRUE)
  
  # Proceed if the target file is found
  if (length(target_file) > 0) {
    # Read the data from the target CSV file
    data <- read.csv(target_file)
    
    # Extract the file name without extension
    file_name <- tools::file_path_sans_ext(basename(target_file))
    
    # Get the "average.nuclear.transcript.percentage" column from the data
    nuc_percentage_column <- data$average.nuclear.transcript.percentage
    
    # Store the column in the list with the file name as the list name
    nuc_percentage_list[[file_name]] <- nuc_percentage_column
  }
}

# Create the result dataframe by converting the list to a data frame
result_df <- as.data.frame(nuc_percentage_list)

# Print the result dataframe
print(result_df)

library(openxlsx)
# Create the result dataframe by converting the list to a data frame
result_df <- as.data.frame(nuc_percentage_list)

# Save the result_df as an Excel file
output_file <- "E:/molecular_cartography/D2/"
write.xlsx(result_df, output_file)

# Print a message to indicate successful saving
cat("Data has been saved to:", output_file, "\n")










library(openxlsx)
library(ggplot2)

# Read the data from the Excel file
input_file <- "E:/molecular_cartography/D2/marker genes localization percentage for cell assignment..xlsx"
data <- read.xlsx(input_file)

# Gather the gene columns into a long format
library(tidyr)
data_long <- gather(data, key = "Gene", value = "Nuc_Percentage", Cell_id)

# Create a scatter plot for each gene
ggplot(data, aes(x = Cell_id, y = Nuc_Percentage, color = Gene)) +
  geom_point() +
  labs(title = "Scatter Plot of Nuclear Percentage for Genes",
       x = "Cell ID",
       y = "Nuclear Percentage",
       color = "Gene") +
  theme_minimal()

library(openxlsx)
library(ggplot2)
library(tidyr)

# Read the data from the Excel file
input_file <- "E:/molecular_cartography/D2/marker genes localization percentage for cell assignment..xlsx"
data <- read.xlsx(input_file)

# Gather all the gene columns into a long format
data_long <- pivot_longer(data, cols = contains("GLYMA"), 
                          names_to = "Gene", values_to = "Nuc_Percentage")

# Create the scatter plot
print(ggplot(data_long, aes(x = Cell_id, y = Nuc_Percentage, color = Gene)) +
  geom_point() +
  labs(title = "Scatter Plot of Nuclear Percentage for All Genes",
       x = "Cell ID",
       y = "Nuclear Percentage",
       color = "Gene") +
  theme_minimal()) + scale_x_continuous(limits = c(0, 2938))
output_file <- "E:/molecular_cartography/D2/"
ggsave(output_file, device = "png", width = 10, height = 6, dpi = 300)

