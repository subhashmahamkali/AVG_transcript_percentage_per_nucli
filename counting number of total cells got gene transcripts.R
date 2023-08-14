# Set the path to the parent folder containing all the folders
parent_folder <- "E:/molecular_cartography/D2/D2_data"

Total_cells_exp <- data.frame()

# Get the list of folders
folders <- list.files(parent_folder, full.names = TRUE)

# Iterate through the folders
for (folder_path in folders) {
  # Get the list of files in the folder
  files <- list.files(folder_path, full.names = TRUE)
  
  # Filter files that contain "localization results by cell" in the filename
  target_files <- files[grepl("localization results by cell", files)]
  
  # Iterate through the target files
  for (file_path in target_files) {
    print(file_path)  # Debugging statement
    
    # Read the CSV file into a data frame
    df <- read.csv(file_path, na.strings = "NA")
    
    # Filter rows based on conditions, excluding NA values in Cell.ID column
    filtered_df <- df[!is.na(df$Cell.ID) & df$Cell.ID > 1 & df$Total.transcript.. != 0, ] 
    
    # Update the "Total cells expressed" value in the first row only
   Total_cells = df$`Total cells expressed`[1] <- nrow(filtered_df)
   print(Total_cells)
    # Write the updated data frame back to the CSV file
    #write.csv(df, file_path, row.names = FALSE) }}



# Extract the file name from the CSV file path
file_name <- basename(file_path)
file_name <- gsub(" - localization results by cell.csv", "", file_name)
Total_cells_exp = rbind(Total_cells_exp, data.frame(file_name = file_name, Total_cells = Total_cells))
# Write the results to a new Excel file
write.xlsx(Total_cells_exp, "Total_cells.xlsx", row.names = FALSE)}}
























