#For updating the excelsheet with the values
library(tidyverse)

# Set the path to the parent folder containing all the folders
parent_folder <- "E:/molecular_cartography/D2/D2_data"

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
    
    # Filter rows based on conditions
    filtered_df <- df[df$Cell.ID > 1 & df$Nucleus.fractional.area != 0, ] 
    
    # Calculate the average_column of the 'average.nuclear.transcript.percentage' column
    average_column <- mean(filtered_df$average.nuclear.transcript.percentage, na.rm = TRUE)
    
    # Check if the data frame has at least 1889 rows
    if (nrow(df) >= 2942) {
      # Update the value in the 1889th row of the 'average.nuclear.transcript.percentage' column
      df[2942, "average.nuclear.transcript.percentage"] <- average_column
    } else {
      # Append a new row to the data frame with the updated value
      new_row <- data.frame(average.nuclear.transcript.percentage = average_column)
      df <- bind_rows(df, new_row)
    }
    
    # Print the total sum
    print(average_column)  # Debugging statement
    # Overwrite the original CSV file with the updated data frame
    write.csv(df, file_path, row.names = FALSE)
  }
}



#For having an excel sheet with 2 columns both average and gene_ID

library(tidyverse)
library(openxlsx)
# Set the path to the parent folder containing all the folders
parent_folder <- "E:/molecular_cartography/D2/D2_data"

# Create an empty data frame to store the results
avgnuc_df <- data.frame()

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
    
    # Filter rows based on conditions
    filtered_df <- df[df$Cell.ID > 1 & df$Nucleus.fractional.area != 0, ] 
    
    # Calculate the average of the 'average.nuclear.transcript.percentage' column
    average_column <- mean(filtered_df$average.nuclear.transcript.percentage, na.rm = TRUE)
    
    # Print the average
    print(average_column)  # Debugging statement
    
    # Extract the file name from the CSV file path
    file_name <- basename(file_path)
    file_name <- gsub(" - localization results by cell.csv", "", file_name)
    
    # Add the results to the data frame
    avgnuc_df <- rbind(avgnuc_df, data.frame(average_column = average_column, file_name = file_name))
  }
}

# Write the results to a new Excel file
write.xlsx(avgnuc_df, "average_results.xlsx", row.names = FALSE)


#making graph with those two columns 
library(readxl)
library(ggplot2)
excel_file <- read_excel("Nodule_Avg_of_transcripts_nucl.xlsx", sheet = 1)
gene_id <- excel_file$file_name
nodule <- excel_file$Nodule
Root = excel_file$Root
data <- data.frame(Gene_id = gene_id, Nodule = nodule, Root = Root)

# Create the line graph
ggplot(data, aes(x = Gene_id)) +
  geom_line(aes(y = Root, color = "Root", group = 1)) +
  geom_line(aes(y = nodule, color = "Nodule", group = 1)) +
  labs(x = "Gene ID", y = "Avg percentage of transcripts/nuclei") +
  ggtitle("Line Graph of Root and Nodule") +
  scale_color_manual(values = c("Root" = "red", "Nodule" = "blue")) +
theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +
  ylim(0, 100)
