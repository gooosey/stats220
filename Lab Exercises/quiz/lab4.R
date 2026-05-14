song_data <- fromJSON("https://stat.auckland.ac.nz/~fergusson/stats220_S124/data/lab4B.json")

not_useful_words <- c("feat", "i", "a")

track_word_counts <- song_data %>%
  select(track_name) %>%
  separate_rows(track_name, sep = " ") %>%
  mutate(clean_word = str_to_lower(track_name) %>%
           str_remove_all("[[:punct:]]")) %>%
  filter(!clean_word == "",
         !clean_word %in% not_useful_words) %>%
  group_by(clean_word) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  slice(1 : 10) %>%
  ungroup() 

track_word_counts %>%
  ggplot(aes(x = reorder(clean_word, n),
             y = n)) +
  
  geom_col(fill = "blue") +
  
  geom_text(aes(label = clean_word),
            colour = "blue",
            size = 8,
            position = position_nudge(y = 0.6)) +
  
  geom_text(aes(label = n),
            position = position_nudge(y = -1),
            colour = "white",
            size = 5) +
  
  theme_void()

