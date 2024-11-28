# Title: Biodiversity Hotspot
# Author: Your Name
# Date: DD/MM/YYYY

# Data Inspection and Cleaning ----
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



# Geospatial Data Analysis ----
# Visualize Species Occurrence

# Plotting the occurrences of both species
plot <- ggplot(gorilla_clean, aes(x = longitude, y = latitude, color = species)) +
  geom_point(alpha = 0.6) +
  ggtitle("Gorilla Occurrences (Gorilla gorilla and Gorilla beringei)")

# Install packages
install.packages("RColorBrewer")
install.packages("extrafont")

# Load additional libraries
library(RColorBrewer)
library(extrafont)

# Create a ggplot for visualizing the gorilla occurrence data
beautifulplot <- ggplot(gorilla_clean, aes(x = longitude, y = latitude, color = species)) +
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
    plot.margin = margin(30, 30, 30, 30),  # Balance the margins
    plot.background = element_rect(fill = "aliceblue", color = NA)  # Soft background color
  )

# Save the plots
ggsave("outputs/gorilla_plot.png", plot = plot, width = 8, height = 5, dpi = 300)
ggsave("outputs/gorilla_beautifulplot.png", plot = beautifulplot, width = 8, height = , dpi = 300)


# Perform Kernel Density Estimation (KDE)
# Install additional packages
install.packages("spatstat")
install.packages('viridis')
install.packages("sp")
install.packages("ks") 

# Load necessary libraries
library(spatstat)
library(viridis)
library(sp)
library(ks)

# Extract the grid coordinates and the density estimates
x_coords <- kde_result$eval.points[[1]]  # Longitude grid points
y_coords <- kde_result$eval.points[[2]]  # Latitude grid points

# Create a grid of coordinates using expand.grid() to match the KDE grid
grid_coords <- expand.grid(x = x_coords, y = y_coords)

# Reshape the KDE estimates into a vector for each coordinate
density_values <- as.vector(kde_result$estimate)

# Create the data frame for visualization
kde_data <- data.frame(
  x = grid_coords$x,
  y = grid_coords$y,
  density = density_values
)

# Visualize the KDE result using ggplot2
kde_plot <- ggplot(kde_data, aes(x = x, y = y, fill = density)) +
  geom_tile() +
  scale_fill_viridis_c() +  # Use a color scale for density
  ggtitle("Kernel Density Estimation of Gorilla Occurrences") +
  labs(x = "Longitude", y = "Latitude", fill = "Density") +
  theme_minimal()

# Save the plot
ggsave("outputs/kdeplot.png", plot = kde_plot, width = 8, height = 5, dpi = 300)


# KNN for Nearest Neighbor Analysis
# Create a point pattern object from the cleaned data
coords <- cbind(gorilla_clean$longitude, gorilla_clean$latitude)
# Create the point pattern object (ppp) from coordinates
pp <- ppp(coords[, 1], coords[, 2], window = owin(xrange = range(coords[, 1]), yrange = range(coords[, 2])))

# Calculate the nearest neighbor distance
nnd <- nndist(pp)
# Check the result of nearest neighbor distances
if (length(nnd) == 0) {
  stop("No nearest neighbor distances calculated. Please check the input data.")
}

# Plot histogram of nearest neighbor distances
nndplot <- ggplot(data.frame(nnd), aes(x = nnd)) +
  geom_histogram(binwidth = 0.1, fill = "blue", alpha = 0.7) +
  ggtitle("Nearest Neighbor Distance Distribution") +
  xlab("Distance to Nearest Neighbor") +
  ylab("Frequency") +
  theme_minimal(base_size = 14) +  # Larger font size for readability
  theme(
    panel.background = element_rect(fill = "lightgray"), 
    plot.background = element_rect(fill = "white"),
    plot.title = element_text(hjust = 0.5), 
    axis.text = element_text(color = "black"),
    axis.title = element_text(color = "black"),
    plot.margin = margin(40, 40, 40, 40)
  )

# Save the plot
ggsave("outputs/nndplot.png", plot = nndplot, width = 8, height = 5, dpi = 300)



# Visualizing the Biodiversity Hotspot Map ----
# Create a Static Hotspot Map

# Install and load necessary packages
packages <- c('sf', 'rnaturalearth', 'rnaturalearthdata', 'leaflet', 'viridis')
install.packages(packages)
lapply(packages, library, character.only = TRUE)

# Define hotspot data
hotspot_data <- data.frame(
  longitude = c(-118, -75, 35, 20, 120, 10, 150, 35, 30, 40, 55, 100),  # Longitude values
  latitude = c(34, 45, -25, -30, 35, 5, -30, 25, 60, 15, -15, -10),  # Latitude values
  hotspot_level = c(3, 2, 3, 2, 1, 3, 2, 1, 3, 2, 1, 3)  # Intensity levels
)

# Convert to sf object (spatial data)
hotspot_sf <- st_as_sf(hotspot_data, coords = c("longitude", "latitude"), crs = 4326)

# Load world map data
world_map <- ne_countries(scale = "medium", returnclass = "sf")

# Continent labels
continent_labels <- data.frame(
  label = c("North America", "South America", "Europe", "Africa", "Asia", "Australia", "Antarctica"),
  longitude = c(-100, -60, 10, 20, 100, 135, -60),
  latitude = c(40, -40, 50, 0, 30, -25, -75)
)

# Create the static map with hotspots
ggplot() +
  geom_sf(data = world_map, fill = "lightgray", color = "gray80", size = 0.5) +
  geom_sf(data = hotspot_sf, aes(fill = hotspot_level, size = hotspot_level), color = "black", alpha = 0.8) +
  scale_fill_viridis(option = "C", direction = 1, alpha = 0.7) +
  scale_size_continuous(range = c(5, 15)) +
  geom_text(data = continent_labels, aes(x = longitude, y = latitude, label = label), size = 5, fontface = "bold", color = "darkblue") +
  ggtitle("Biodiversity Hotspot Map with Intensity Levels") +
  labs(caption = "Created by Shizhao, 28 November 2024") +
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.title = element_text(size = 20, face = "bold", hjust = 0.5, color = "darkred", family = "Georgia"),
    plot.caption = element_text(hjust = 1, size = 12, color = "darkgray", family = "Georgia"),
    plot.margin = margin(20, 20, 20, 20),
    panel.background = element_rect(fill = "white", color = "gray", size = 0.3),
    legend.position = "right",
    legend.title = element_text(size = 14, face = "bold", family = "Georgia"),
    legend.text = element_text(size = 12, family = "Georgia"),
    legend.key.size = unit(1.2, "cm"),
    legend.key = element_rect(fill = "white", color = "black", size = 0.5)
  ) +
  coord_sf(xlim = c(-180, 180), ylim = c(-90, 90)) +
  guides(fill = guide_colorbar(title = "Hotspot Intensity", barwidth = 10, barheight = 1),
         size = guide_legend(title = "Hotspot Size"))

# Save the plot as jpeg
ggsave("outputs/hotspot_map.jpeg", width = 12, height = 7, dpi = 300)


# Create an Interactive Map with Leaflet
map <- leaflet(hotspot_data) %>%
  addTiles() %>%
  addCircleMarkers(
    ~longitude, ~latitude,
    radius = ~hotspot_level * 2,
    color = ~viridis::viridis(1)[1],
    fillOpacity = 0.7,
    popup = ~paste("Hotspot Level: ", hotspot_level)
  ) %>%
  setView(lng = 0, lat = 0, zoom = 2)

# Save the interactive map as an HTML file
library(htmlwidgets)
saveWidget(
  widget = map,
  file = "outputs/interactive_hotspot_map.html",
  selfcontained = TRUE,  # Embeds all resources into the HTML file
  libdir = NULL,         # Don't use a separate directory for external libraries
  background = "white",  # Set background color
  title = "Interactive Hotspot Map",  # Set the title of the HTML page
  knitrOptions = list()  # Optional list for knitr options (leave empty if not needed)
)