library(readr)
library(dplyr)
library(ggplot2)

institutionData <- read_csv("source-data/Most-Recent-Cohorts-Institution.csv")
# Assuming institutionData is your data frame
institutionData <- institutionData %>%
  mutate(
    MD_EARN_WNE_P10 = as.numeric(MD_EARN_WNE_P10),
    PCT10_EARN_WNE_P10 = as.numeric(PCT10_EARN_WNE_P10),
    PCT25_EARN_WNE_P10 = as.numeric(PCT25_EARN_WNE_P10),
    PCT75_EARN_WNE_P10 = as.numeric(PCT75_EARN_WNE_P10),
    PCT90_EARN_WNE_P10 = as.numeric(PCT90_EARN_WNE_P10),
    CONTROL = factor(
      CONTROL,
      levels = c(1, 2, 3),
      labels = c("Public", "Private nonprofit", "Private for-profit")
    )
  ) %>%
  na.omit()  # Remove rows with NA values in any column


# PREDDEG = 3 is Predominantly bachelor's-degree granting

earnings <- institutionData %>%
  filter(
         PREDDEG == 3, 
         !(CCBASIC %in% c("10", "11", "12", "13", "24", "25", "26", "27", "28", "29", "30", "31", "32"))) %>%
  select(College = INSTNM, CollegeType = CONTROL,
         e50 = MD_EARN_WNE_P10, 
         e10 = PCT10_EARN_WNE_P10,
         e25 = PCT25_EARN_WNE_P10, 
         e75 = PCT75_EARN_WNE_P10,
         e90 = PCT90_EARN_WNE_P10) %>%
  arrange(desc(e75))

earnings <- cbind(Rank=1:nrow(earnings), earnings)
earnings$College <- paste(earnings$Rank, earnings$College, sep=". ")
earnings$College <- factor(earnings$College, levels=rev(earnings$College))

earnings_after_10_years = ggplot(earnings, aes(x=e50, color=CollegeType, fill=CollegeType, group=CollegeType)) +
  geom_density(alpha=0.3) +
  theme_light(base_size=16) +
  xlab("Median Earnings 10 Years after Matriculation") + ylab("")
ggsave(filename = "figures/earnings_after_10_years.png", plot = earnings_after_10_years, device = "png")

top_20_earnings_quartiles = ggplot(earnings[1:20,], aes(x=College, ymin=e10, lower=e25, middle=e50, upper=e75, ymax=e90)) +
  geom_boxplot(stat="identity", fill="#53cfff") + 
  geom_text(aes(x=College, y=e75-5000, ymax=e75, hjust=0.95, label=paste0("$", e75)), size=4) + 
  theme_light(base_size=16) +
  theme(axis.text.y = element_text(hjust=0, color="black")) +
  coord_flip() +
  xlab("") + ylab("") +
  ggtitle("Top Quartile Earnings 10 Years After Matriculation ($)")
ggsave(filename = "figures/top_20_earnings_quartiles.png", plot = top_20_earnings_quartiles, device = "png")
