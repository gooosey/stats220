library(tidyverse)
library(jsonlite)

song_data <- fromJSON("https://stat.auckland.ac.nz/~fergusson/stats220_S124/data/lab4A.json")

expl_songs <- song_data %>%
  mutate(song_type = ifelse(explicit, "Explicit", "Not Explicit"))

expl_songs %>%
  ggplot() + 
  geom_bar(aes(y= song_type))

group_songs <- expl_songs %>%
  group_by(song_type) %>%
  summarise(num_songs = n())

group_songs %>%
  ggplot() + 
  geom_col(aes(y=song_type, x =num_songs ), stat="identity")

explicit_genre <- expl_songs %>%
  mutate(song_genre = case_when(
    str_detect( artist_genre, "rap") ~ "Rap", 
    str_detect(artist_genre, "pop") ~ "Pop",
    TRUE ~ "Other"
  ))

explicit_genre %>%
  ggplot() + 
  geom_bar(aes(y= song_type, fill= song_genre)) + 
  facet_wrap(vars(song_genre)) + 
  guides(fill="none")

           

library(tidyverse)
library(jsonlite)
song_data <- fromJSON("https://stat.auckland.ac.nz/~fergusson/stats220_S124/data/lab4A.json")

summarised_data <- song_data %>%
  mutate(song_speed = ifelse(tempo > 120, 'fast', 'slow')) %>%
  group_by(song_speed) %>%
  summarise(n = n())

ggplot(data = summarised_data) +
  geom_col(aes(x = song_speed, y = n, fill = song_speed)) +
  labs(subtitle = 'Comparing the speed of songs', x = 'Speed of song based on tempo', y = 'Number of songs')

library(tidyverse)
library(jsonlite)
song_data <- fromJSON("https://stat.auckland.ac.nz/~fergusson/stats220_S124/data/lab4A.json")
summarised_data <- song_data %>%
  mutate(valence_group = case_when(
    valence < 0.33 ~ 'sad',
    valence < 0.67 ~ 'OK',
    TRUE ~ 'happy')) %>%
  group_by(mode_name, valence_group) %>%
  summarise(mean_tempo = mean(tempo, na.rm = TRUE))

summarised_data %>%
  ggplot() +
geom_point(aes(x = mean_tempo, y = mode_name, color = valence_group), size = 5)
