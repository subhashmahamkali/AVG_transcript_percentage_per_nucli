# Load required libraries
library(openxlsx)
library(dplyr)

# Initialize an empty data frame to hold the combined data
combined_data <- data.frame()

main_directory <- "E:/molecular_cartography/A1/A1_data/"
#epidermis
#folders <- c("G4DT", "GLYMA_09G099900", "GLYMA_10G070200", "GLYMA_19G255500") 

#cortex
#folders <- c("GLYMA_06G235500", "GLYMA_15G169100")  

#pericycle
folders <- c("GLYMA_05G023700", "GLYMA_02G003700", "GLYMA_11G078300")


# Step 1: Read the data from the Excel sheet (assuming 'nuc_data.xlsx' as the file name)
excel_file <- "C:/Users/stennant2/Desktop/cell_clusters_new/A1_celltypes.xlsx"
nuc_data <- read.xlsx(excel_file, sheet = "pericycle")

# Initialize a variable to keep track of the nuc_cells column
nuc_cells_added <- FALSE

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
    # Step 2: Read the data from the CSV file
    csv_data <- read.csv(target_file)
    
    # Step 3: Filter csv_data based on nuc_cells column
    filtered_data <- csv_data %>%
      filter(Cell.ID.. %in% nuc_data$nuc_cells)
    
    # Step 4: Get the .csv file name without extension
    csv_filename <- tools::file_path_sans_ext(basename(target_file))
    
    # Step 5: Extract the 'average.nuclear.transcript.percentage' column
    col_name <- paste(csv_filename, "percentage", sep = "_")
    column_data <- filtered_data[["average.nuclear.transcript.percentage"]]
    
    # Step 6: Add the column to the combined_data data frame
    if (!nuc_cells_added) {
      combined_data <- data.frame(filtered_data[["Cell.ID.."]], column_data)
      colnames(combined_data)[2] <- col_name
      nuc_cells_added <- TRUE
    } else {
      combined_data[col_name] <- column_data
    }
  }
}

# Output the combined_data data frame with data from all CSV files
print(combined_data)

# Load required libraries
library(openxlsx)

# Specify the path and filename for the output Excel file
output_file <- "E:/molecular_cartography/A1/subcategorizationof cell types using marker genes/epidermis/combined_data.xlsx"

# Write the 'combined_data' data frame to an Excel sheet
write.xlsx(combined_data, file = output_file, row.names = FALSE)

# Print a message to confirm the export
cat("Combined data has been exported to", output_file, "\n")
