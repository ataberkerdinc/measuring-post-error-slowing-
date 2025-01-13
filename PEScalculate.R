library(readxl)
library(dplyr)
library(ggplot2)
library(tidyr)
library(writexl)

setwd("yourdirectory")


datam <- read_excel("yourdata.xlsx")

pattern <- c("C", "C", "E", "C")
rows_to_keep <- c()
highlight_column <- rep(NA, nrow(datam))

i <- 1
while (i <= (nrow(datam) - length(pattern) + 1)) {
  if (all(datam$response[i:(i + length(pattern) - 1)] == pattern)) {
    rows_to_keep <- c(rows_to_keep, i:(i + length(pattern) - 1))
    highlight_column[i:(i + length(pattern) - 1)] <- "Highlighted"
    i <- i + length(pattern)
  } else {
    i <- i + 1
  }
}

data <- datam[rows_to_keep, ]
datam$Highlight <- highlight_column


pes_data <- data %>%
  group_by(participant) %>%
  mutate(
    RTpre_error = ifelse(response == "E", lag(RT, default = NA), NA),
    RTpost_error = ifelse(response == "E", lead(RT, default = NA), NA)
  ) %>%
  mutate(
    PES = ifelse(response == "E", RTpost_error - RTpre_error, NA)
  ) %>%
  ungroup()


Participant_PES_results <- pes_data %>%
  filter(!is.na(PES) & response == "E") %>%
  group_by(participant) %>%
  summarize(mean_PES = mean(PES, na.rm = TRUE), .groups = "drop")


write.csv(participant_pes_results, "Participant_PES_results.csv", row.names = FALSE)
write.csv(pes_data, "raw_pes_data.csv", row.names = FALSE)


plot_data <- pes_data %>%
  summarise(
    RTpre_error_mean = mean(RTpre_error, na.rm = TRUE),
    RTpost_error_mean = mean(RTpost_error, na.rm = TRUE),
    RT_error_mean = mean(RT[response == "E"], na.rm = TRUE)
  ) %>%
  pivot_longer(
    cols = c("RTpre_error_mean", "RT_error_mean", "RTpost_error_mean"),
    names_to = "Condition",
    values_to = "Mean_RT"
  ) %>%
  mutate(
    Condition = case_when(
      Condition == "RTpre_error_mean" ~ "E-1",
      Condition == "RT_error_mean" ~ "E",
      Condition == "RTpost_error_mean" ~ "E+1"
    )
  )


ggplot(plot_data, aes(x = Condition, y = Mean_RT, group = 1)) +
  geom_line(linewidth = 1) +
  geom_point(size = 3) +
  labs(
    title = "Mean Reaction Times by Condition",
    x = "Condition",
    y = "Mean Reaction Time (ms)"
  ) +
  theme_classic() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 16),
    axis.title = element_text(size = 14),
    axis.text = element_text(size = 12)
  )
