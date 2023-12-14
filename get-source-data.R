# Install and load necessary packages
library(downloader)
library(readr)

# Specify the URL of the ZIP file
# zip_url <- "https://ed-public-download.app.cloud.gov/downloads/Most-Recent-Cohorts-Institution_09262023.zip"

# Specify the local file name where you want to save the downloaded ZIP file
zip_file <- "source-data/Most-Recent-Cohorts-Institution_09262023.zip"

# Specify the local directory where you want to extract the contents
extract_dir <- "source-data/"

# Download the ZIP file
# download(zip_url, destfile = zip_file, mode = "wb")

# Create the directory if it doesn't exist
dir.create(extract_dir, recursive = TRUE, showWarnings = FALSE)

# Extract the contents of the ZIP file
unzip(zip_file, exdir = extract_dir)



