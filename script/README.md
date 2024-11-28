# Script

This folder contains the R script used as a sample script for this tutorial with a focus on **Gorilla** species.

## Script Overview

This R script is divided into the following key sections:

### **Data Import and Cleaning**
- **Imports** the **Gorilla gorilla occurrence data** from the `gorilla.csv` file.
- **Cleans** the dataset by filtering missing values and empty entries, ensuring that only valid data is used.
- **Renames columns** for consistency and readability, such as renaming `decimalLongitude` to `longitude` and `decimalLatitude` to `latitude`.

### **Data Visualization**
- **Visualizes species occurrences**: Plots the locations of the species using `ggplot2`, with different colors for each species.
- **Enhances the plot aesthetics**: Uses custom color palettes and themes to improve the readability and presentation of the species occurrence plot.
- **Creates a KDE (Kernel Density Estimate)** plot to visualize the spatial distribution of **Gorilla** occurrences, showing areas of higher concentration.

### **Nearest Neighbor Analysis**
- **Calculates nearest neighbor distances** to understand the clustering of gorilla occurrences.
- **Generates a histogram** to visualize the distribution of these distances, helping assess how the species is distributed spatially.

### **Geospatial Hotspot Mapping**
- **Creates static maps** of biological hotspots for **Gorilla** occurrences, highlighting areas with high densities using the `sf` and `ggplot2` packages.
- **Generates an interactive map** using `leaflet`, allowing zooming and panning to explore the hotspots dynamically.

## Dependencies

Ensure that the following R packages are installed before running the script:

- `dplyr`: for data manipulation
- `ggplot2`: for plotting and visualization
- `viridis`: for color scales in visualizations
- `spatstat`: for spatial statistics and Kernel Density Estimation
- `leaflet`: for creating interactive maps
- `sf`: for handling spatial data
- `RColorBrewer`, `extrafont`: for enhanced plot aesthetics

You can install the required packages using the following command in R:

```r
install.packages(c("dplyr", "ggplot2", "viridis", "spatstat", "leaflet", "sf", "RColorBrewer", "extrafont"))
```
