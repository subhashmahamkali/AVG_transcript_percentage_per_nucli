library(tidyverse)

# Set the path to the parent folder containing all the folders
parent_folder <- "E:/molecular_cartography/B2/B2_data"
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
    df <- read.csv(file_path)
    
    print(dim(df))  # Debugging statement to check initial dimensions
    
    # Check if the required columns exist in the data frame
    if ("Total.transcript.." %in% colnames(df) && "Cytoplasm.only.transcript.." %in% colnames(df)) {
      # Perform the calculation and add the new column
      df <- df %>%
        mutate(`nuclear.only.transcripts` = Total.transcript.. - Cytoplasm.only.transcript..)
      
      # Print the dimensions after adding the new column
      print(dim(df))  # Debugging statement to check dimensions after modification
      
      # Save the updated data frame back to the CSV file, overwriting the original file
      write.csv(df, file_path, row.names = FALSE)
    } else {
      # Print a message if the required columns are not found
      print("Required columns not found")
    }
  }
}







library(tidyverse)

# Set the path to the parent folder containing all the folders
parent_folder <- "E:/molecular_cartography/B2/B2_data"
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
    df <- read.csv(file_path)
    
    print(dim(df))  # Debugging statement to check initial dimensions
    
    # Check if the required columns exist in the data frame
    if ("Total.transcript.." %in% colnames(df) && "Cytoplasm.only.transcript.." %in% colnames(df)) {
      # Perform the calculation and add the new column
      df <- df %>%
        mutate(`nuclear.only.transcripts` = Total.transcript.. - Cytoplasm.only.transcript..)
      
      # Sum the "nuclear.only.transcripts" column from row 4 onwards
      total_sum <- sum(df$`nuclear.only.transcripts`[4:nrow(df)], na.rm = TRUE)
      
      # Print the total sum
      print(total_sum)  # Debugging statement
      
      # Update the value in the 2941st row and "nuclear.only.transcripts" column
      df[1232, "nuclear.only.transcripts"] <- total_sum
      
      # Overwrite the original CSV file with the updated data frame
      write.csv(df, file_path, row.names = FALSE)
    } else {
      # Print a message if the required columns are not found
      print("Required columns not found")
    }
  }
}









library(tidyverse)
library(openxlsx)

# Set the path to the parent folder containing all the folders
parent_folder <- "E:/molecular_cartography/B2/B2_data"
# Get the list of folders
folders <- list.files(parent_folder, full.names = TRUE)

# Create a data frame to store the results
results_df <- data.frame(total_sum = numeric(), file_name = character(), stringsAsFactors = FALSE)

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
    df <- read.csv(file_path)
    
    print(dim(df))  # Debugging statement to check initial dimensions
    
    # Check if the required columns exist in the data frame
    if ("Total.transcript.." %in% colnames(df) && "Cytoplasm.only.transcript.." %in% colnames(df)) {
      # Perform the calculation and add the new column
      df <- df %>%
        mutate(`nuclear.only.transcripts` = Total.transcript.. - Cytoplasm.only.transcript..)
      
      # Sum the "nuclear.only.transcripts" column from row 4 onwards
      total_sum <- sum(df$`nuclear.only.transcripts`[4:nrow(df)], na.rm = TRUE)
      
      # Print the total sum
      print(total_sum)  # Debugging statement
      
      # Extract the file name from the CSV file path
      file_name <- basename(file_path)
      file_name <- gsub(" - localization results by cell.csv", "", file_name)
      
      # Add the results to the data frame
      results_df <- rbind(results_df, data.frame(total_sum = total_sum, file_name = file_name))
    } else {
      # Print a message if the required columns are not found
      print("Required columns not found")
    }
  }
}

# Write the results to a new Excel file
write.xlsx(results_df, "sum_results.xlsx", row.names = FALSE)
