library(readr)
library(dplyr)
library(ggplot2)
#library(summarytools)

institutionData <- read_csv("source-data/Most-Recent-Cohorts-Institution.csv")
#fieldData <- read_csv("source-data/Most-Recent-Cohorts-Field-of-Study.csv")
institutionData$SATVRMID <- as.numeric(institutionData$SATVRMID)
institutionData$ACTCMMID <- as.numeric(institutionData$ACTCMMID)

hist(institutionData$ACTCMMID)
hist(institutionData$SATVRMID)
plot(institutionData$ACTCMMID, institutionData$ADM_RATE_SUPP)

adm_rate_vs_sat <- ggplot(institutionData, aes(x = SATVRMID, y = ADM_RATE_SUPP)) +
  # Add a point geometry (scatter plot)
  geom_point() +
  labs(title = "Admission Rate versus SAT VR Score", x = "SAT VR Score", y = "Admission Rate") 
  # scale_x_continuous(name = "SAT Verbal Score", breaks = seq(300, 800, by = 50))

ggsave(filename = "figures/admission-rate-vs-SAT.png", plot = adm_rate_vs_sat, device = "png")

adm_rate_vs_act <- ggplot(institutionData, aes(x = ACTCMMID, y = ADM_RATE_SUPP)) +
  geom_point() +
  labs(title = "Admission Rate versus ACT Score", x = "ACT Score", y = "Admission Rate")

ggsave(filename = "figures/admission-rate-vs-ACT.png", plot = adm_rate_vs_act, device = "png")
