#library(tidyverse)
#library(rvest)
#library(jsonlite)

# Find me list of files
listfiles <- list.files("html", full.names = TRUE)

source("scrape_html.R")

# bee dataset
beehive <- map_df(listfiles, scrape_search_results) %>% distinct()
saveRDS(beehive, "beehive.rds")

source("get_wikipedia_infobox.R")

minister_names <- beehive %>%
  pull(ministers) %>% 
  unique()


ministers <- map_df(minister_names, get_wikipedia_infobox)

saveRDS(ministers, "ministers.rds")