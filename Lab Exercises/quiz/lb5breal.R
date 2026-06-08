#library(tidyverse)

apple_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vR6jVuO3F3DNwX1WApTvCfYqfjehcNKHmuDqupk2_0vJe0lnf81dmUlsXZGkZKmaCeallS5Dqch05ks/pub?gid=1338968646&single=true&output=csv") %>%
  slice(16 : 80)

# Create both new variables
apple_data <- apple_data %>%
  mutate(
    track_name_lower = str_to_lower(trackName),
    track_name_clean = str_remove_all(track_name_lower, "[[:punct:]]")
  )

# Q1: characters in trackName of row 4
nchar(apple_data$trackName[10])

# Q2: track_name_lower of row 27
apple_data$track_name_lower[63]

# Q3: track_name_clean of row 9
apple_data$track_name_clean[59]

# Q4: total number of words across all track names
apple_data %>%
  separate_rows(track_name_clean, sep = " ") %>%
  nrow()

# Q5: number of unique words across all track names
apple_data %>%
  separate_rows(track_name_clean, sep = " ") %>%
  distinct(track_name_clean) %>%
  nrow()
