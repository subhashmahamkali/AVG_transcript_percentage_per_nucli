# Replace "data.xlsx" with the actual path to your Excel file
data <- read_excel("mcvssn.xlsx", sheet = "17G")


plot = ggplot(data, aes(x = `AVG_UMI/nuclei`, y = `AVG_trans/nuclei`)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, size = 2, color = "red") +  # Add the trend line
  labs(title = "Molecular Cartography™ vs snRNA-seq in soybean nodule",
       x = "Average #UMI/nuclei",
       y = "Average #transcripts/nuclei") +
  theme_minimal() +
  scale_y_continuous(limits = c(0, 9), breaks = seq(0, 9, by = 1)) +
  scale_x_continuous(limits = c(0, 1.8), breaks = seq(0, 1.8, by = 0.2)) +
  guides(color = FALSE)

ggsave("nodule.png", plot, dpi = 600)



library(tidyr)

data_long <- gather(data, key = "Variable", value = "Value", 'Average # UMI/nuclei','Average #transcripts/nuclei')

ggplot(data_long, aes(x = Gene_id, y = Value, fill = Variable)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Bar Graph: UMI vs. Transcripts by Gene ID",
       x = "Gene ID",
       y = "Count") +
  scale_fill_manual(values = c("blue", "red")) +
  theme_minimal()




plot = ggplot(data, aes(x = `AVG_UMI/nuclei`, y = `AVG_trans/nuclei`)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, size = 2, color = "red") +  # Add the trend line
  labs(title = "Molecular Cartography™ vs snRNA-seq in soybean root",
       x = "Average #UMI/nuclei",
       y = "Average #transcripts/nuclei") +
  theme_minimal() +
  scale_y_continuous(limits = c(0, 16), breaks = seq(0, 16, by = 2)) +
  scale_x_continuous(limits = c(0, 1.6), breaks = seq(0, 1.6, by = 0.2)) +
  guides(color = FALSE)

ggsave("Root.png", plot, dpi = 600)







col_names <- names(data)
print(col_names)



