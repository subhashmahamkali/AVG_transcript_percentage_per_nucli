# Set the path to the directory containing the folders
directory <- "C:/Users/stennant2/Desktop/Molecular Cartography/32771-slide1_submission/32771-slide1_submission/A1_data"

# Get a list of folder names in the directory
folder_names <- list.dirs(directory, full.names = FALSE)

# Convert folder names to the desired format
folder_names_formatted <- sprintf('"%s"', folder_names)

# Combine folder names with commas
folder_names_str <- paste(folder_names_formatted, collapse = ",")

# Export the folder names to a text file
writeLines(folder_names_str, "folder_names.txt")

# Export the folder names to a Word file
library(officer)
doc <- read_docx()
doc <- body_add_par(doc, folder_names_str)
print(doc, target = "folder_names.docx")
