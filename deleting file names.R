# Set the main folder path
main_folder <-  "E:/molecular_cartography/B2/B2_data"

# List all PNG files in the main folder and its subdirectories
file_list <- list.files(path = main_folder, pattern = "\\.png$", recursive = TRUE, full.names = TRUE)

# Iterate over each file and rename the PNG images
for (file_path in file_list) {
  file_name <- basename(file_path)
  new_name <- gsub("localization results by cell\\.csv_plot", "", file_name)
  new_path <- file.path(dirname(file_path), new_name)
  file.rename(file_path, new_path)
}

# Print a message indicating the completion of the renaming process
cat("PNG image renaming completed.")
