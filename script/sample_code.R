# Title: Biodiversity Hotspot
# Author: Your Name
# Date: DD/MM/YYYY

-------------------------------------
# Install required packages
install.packages("dplyr")
install.packages("ggplot2")

# Load necessary libraries
library(dplyr)
library(ggplot2)

# Load the Gorilla gorilla occurrence data
gorilla <- read.csv("data/gorilla.csv")

# Inspect the dataset to understand its structure and identify potential issues
summary(gorilla)

# Remove rows with empty species names and check for missing data
gorilla_clean <- gorilla %>%
  filter(species != "") %>%
  filter(!is.na(species), !is.na(decimalLatitude), !is.na(decimalLongitude))

# Rename the column 'decimalLongitude' to 'longitude' and 'decimalLatitude' to 'latitude'
gorilla_clean <- gorilla_clean %>%
  rename(longitude = decimalLongitude, latitude = decimalLatitude)

# Clean the dataset
gorilla_clean <- gorilla %>%
  # Remove rows with empty or missing species names and coordinates
  filter(!is.na(species) & species != "") %>%
  filter(!is.na(decimalLatitude) & !is.na(decimalLongitude)) %>%
  # Rename columns for consistency and simplicity
  rename(
    longitude = decimalLongitude,
    latitude = decimalLatitude
  )

# Validate the cleaned data
# Check for duplicate rows and remove them if necessary
gorilla_clean <- gorilla_clean %>%
  distinct()

# Summarize the cleaned dataset to verify the cleaning process
glimpse(gorilla_clean)
summary(gorilla_clean)

# Check the first few rows of the cleaned data for a quick inspection
head(gorilla_clean)

# Optional
write.csv(gorilla_clean, "data/gorilla_clean.csv")

# Get the unique species
unique_species_list <- gorilla_clean %>%
  distinct(species) %>%  # Select unique species from the dataset
  pull(species)          # Extract the unique species as a vector

# Display the number of unique species in the dataset
cat("Number of unique species in the dataset:", length(unique_species_list), "\n")

# Display the list of unique species
cat("Unique species in the dataset:\n")
print(unique_species_list)

-------------------------------------
# Plotting the occurrences of both species
plot<- ggplot(gorilla_clean, aes(x = longitude, y = latitude, color = species)) +
  geom_point(alpha = 0.6) +
  ggtitle("Gorilla Occurrences (Gorilla gorilla and Gorilla beringei)")


# Install packages
install.packages("RColorBrewer")
install.packages("extrafont")

# Load additional libraries
library(RColorBrewer)
library(extrafont)

# Create a ggplot for visualizing the gorilla occurrence data
beautifulplot<- ggplot(gorilla_clean, aes(x = longitude, y = latitude, color = species)) +
  geom_point(alpha = 0.7, size = 3, shape = 21, stroke = 0.8) +  # Slightly larger, more defined points
  scale_color_manual(values = c("Gorilla gorilla" = "#FF9A8B",
                                "Gorilla beringei" = "#6A9ECF")) +
  labs(
    title = "Gorilla Occurrences\n(Gorilla gorilla and Gorilla beringei)",  # Title
    x = "Longitude",
    y = "Latitude",
    color = "Species"
  ) +
  theme_minimal(base_size = 16) +  # Base size for readability
  theme(
    plot.title = element_text(family = "Georgia", hjust = 0.5, size = 22, color = "darkslateblue", face = "bold"),  # Fancy script title with Lobster font
    axis.title = element_text(family = "Georgia", size = 16, face = "italic", color = "darkred"),  # Elegant font for axis titles
    axis.text = element_text(size = 12, family = "Georgia", color = "black"),  # Readable axis text
    legend.position = "right",  # Legend on the right
    legend.title = element_text(size = 15, family = "Georgia", face = "bold"),  # Bold legend title
    legend.text = element_text(size = 13, family = "Georgia"),  # Font size for legend
    panel.grid.major = element_line(color = "gray90", size = 0.5),  # Light major grid lines
    panel.grid.minor = element_line(color = "gray95", size = 0.25),  # Even lighter minor grid lines
    panel.border = element_rect(color = "black", fill = NA, size = 1.2),  # Plot border
    plot.margin = margin(50, 50, 50, 50),  # Balance the margins
    plot.background = element_rect(fill = "aliceblue", color = NA)  # Soft background color
  )

# Save the plots
ggsave("outputs/gorilla_plot.png", plot = plot, width = 6, height = 4, dpi = 300)
ggsave("outputs/gorilla_beautifulplot.png", plot = beautifulplot, width = 6, height = 4, dpi = 300)



