library(readr)
library(dplyr)
library(ggplot2)

institutionData <- read_csv("source-data/Most-Recent-Cohorts-Institution.csv")

# Convert to numeric, handling NAs
institutionData$SATVRMID <- as.numeric(institutionData$SATVRMID)
institutionData$ACTCMMID <- as.numeric(institutionData$ACTCMMID)
institutionData$ADM_RATE_SUPP <- as.numeric(institutionData$ADM_RATE_SUPP)

# Filter out rows where SATVRMID, ACTCMMID, or ADM_RATE_SUPP are NULL
filteredData <- institutionData %>%
  filter(!is.na(SATVRMID) & !is.na(ACTCMMID) & !is.na(ADM_RATE_SUPP))

# Histograms
hist(filteredData$ACTCMMID)
hist(filteredData$SATVRMID)

# Scatter plots
adm_rate_vs_sat <- ggplot(filteredData, aes(x = SATVRMID, y = ADM_RATE_SUPP)) +
  geom_point() +
  labs(title = "Admission Rate versus SAT VR Score", x = "SAT VR Score", y = "Admission Rate")

ggsave(filename = "figures/admission-rate-vs-SAT.png", plot = adm_rate_vs_sat, device = "png")

adm_rate_vs_act <- ggplot(filteredData, aes(x = ACTCMMID, y = ADM_RATE_SUPP)) +
  geom_point() +
  labs(title = "Admission Rate versus ACT Score", x = "ACT Score", y = "Admission Rate")

ggsave(filename = "figures/admission-rate-vs-ACT.png", plot = adm_rate_vs_act, device = "png")
