data_url <- "https://stat.auckland.ac.nz/~fergusson/stats220_S124/data/lab3B.json"

data <- fromJSON(data_url)

data %>%
  separate_rows(artist_name, sep=",") %>%
  pull(artist_name) %>%
  unique() %>%
  length()

data_filtered <- data %>%
  filter(track_popularity > 76 & str_detect(artist_genre, "pop")) %>%
  length()


pop_songs <- data %>%
  mutate(pop = ifelse(str_detect(str_to_lower(artist_genre), "pop"), "yes", "no"))

pop_songs %>%
  group_by(pop) %>%
  summarise(median_pop = median(track_popularity, na.rm=T))

long_songs <- data %>%
  mutate(track_name_num_words = str_count(track_name, "\\S+"))

long_songs %>%
  filter(track_name_num_words > 4) %>%
  nrow()


song_data <- fromJSON("https://stat.auckland.ac.nz/~fergusson/stats220_S124/data/lab3b_json20.json")

song_data %>% 
  pull(track_popularity) %>%
  unique() %>%
  length()
song_data %>%
  separate_rows(artist_name, sep = ", ") %>%
  pull(artist_name) %>%
  unique() %>%
  length()



song_data %>%
  filter(
    track_popularity > 73,
    str_detect(artist_genre, "pop")
  ) %>%
  nrow()
pop_songs <- song_data %>%
  mutate(pop = ifelse(str_detect(artist_genre, "pop"), "yes", "no"))


pop_songs %>%
  group_by(pop) %>%
  summarise(median_popularity = median(track_popularity))


long_songs <- song_data %>%
  mutate(track_name_num_words = str_count(track_name, "\\S+"))

long_songs %>%
  filter(track_name_num_words > 2) %>%
  nrow()
