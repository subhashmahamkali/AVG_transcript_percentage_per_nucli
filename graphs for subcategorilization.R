library(openxlsx)
library(ggplot2)
library(tidyr)

library(openxlsx)
library(ggplot2)
library(tidyr)

# Step 1: Read data from Excel sheet
excel_file <- "E:/molecular_cartography/A1/subcategorizationof cell types using marker genes/epicortex/epicortex.xlsx"
gene_data <- read.xlsx(excel_file)

# Step 2: Convert data to long format using tidyr::pivot_longer
gene_data_long <- gene_data %>%
  pivot_longer(cols = starts_with("G"),
               names_to = "gene",
               values_to = "value")


# Step 3: Convert epidermis_cell_id to factor
gene_data_long$epicortexCell.ID..... <- factor(gene_data_long$epicortexCell.ID.....)

# Step 4: Create a line plot using ggplot2
ggplot_object = ggplot(gene_data_long, aes(x = epicortexCell.ID....., y = value, color = gene, group = gene)) +
  geom_line() +
  labs(x = "Epicortex Cell ID", y = "Average % of Transcripts in Nucleus", title = "epicortex") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # To rotate x-axis labels for better visibility

ggsave("epicortex_plot.png", plot = ggplot_object, width = 20, height = 6, units = "in")

