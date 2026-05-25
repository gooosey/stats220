library(tidyverse)
library(rvest)
library(jsonlite)

# ---- Load HTML files ----
listfiles <- list.files("html", full.names = TRUE)

# ---- Load scraping function ----
source("scrape_html.R")

# ---- Create Beehive dataset ----
beehive <- map_df(listfiles, scrape_search_results) %>% distinct()
saveRDS(beehive, "beehive.rds")

# ---- Load Wikipedia infobox function ----
source("get_wikipedia_infobox.R")

# ---- Create minister vector ----
minister_names <- beehive %>%
  separate_rows(ministers, sep = ";") %>%
  pull(ministers) %>%
  unique()

# ---- Create ministers dataset from Wikipedia ----
ministers <- map_df(minister_names, get_wikipedia_infobox)

saveRDS(ministers, "ministers.rds")