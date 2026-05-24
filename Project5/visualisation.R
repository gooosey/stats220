#library(tidyverse)
#library(httr)
# Goal employment + AI mentioned

beehive <- readRDS("beehive.rds")
ministers <- readRDS("ministers.rds")

# Data cleaning

beehive <- beehive %>%
  separate_rows(ministers, sep = ";") %>%
  mutate(clean_ministers = str_remove_all(ministers, "Hon |Rt "))

# Party selection

minister_party <- ministers %>%
  filter(label == "Party") %>%
  select(minister, party = "value")

# Left join each party
minister_join <- beehive %>%
  left_join(minister_party, by = c("ministers" = "minister"))

# Clean party names

new_beehive <- minister_join %>%
  mutate(party = case_when(
    str_detect(party, "National") ~ "National",
    str_detect(party, "Labour") ~ "Labour",
    str_detect(party, "Green") ~ "Green",
    str_detect(party, "Māori") ~ "Māori Party",
    TRUE ~ "Unknown Party"      
  ),
  # Fix date 
  year = year(dmy(date_text)),
  yearmat = case_when(
    year < 2010 ~ "<2010",
    year < 2015 ~ "2010-14",
    year < 2020 ~ "2015-19",
    year < 2024 ~ "2020-23",
    TRUE        ~ "2024-26"
  ),
  ai_mention = str_detect(title, "\\bAI\\b|artificial intelligence") |
    str_detect(summary, "\\bAI\\b|artificial intelligence"),
  fill_group = if_else(ai_mention, party, "No AI mention")
  ) %>%
  filter(ministers != "")

# Plot me 
beehive_plot <- new_beehive %>%
  ggplot() + 
  geom_bar(aes(x = yearmat, fill = fill_group)) +
  scale_fill_manual(values = c(
    "No AI mention" = "grey",
    "National"      = "blue",
    "Labour"        = "red",
    "Māori Party"   = "orange",
    "Green"         = "darkgreen",
    "Unknown Party" = "black"
  )) + labs(
    title    = "When the Beehive talks about AI in employment releases, it's mostly National",
    subtitle = "Beehive releases for 'Employment AI'; coloured bars mention AI, grey bars don't",
    x        = "Year band",
    y        = "Number of releases",
  ) + 
  theme_dark()

ggsave("my_viz.png", beehive_plot)
