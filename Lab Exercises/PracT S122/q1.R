song_title <- c("Who Let the Dogs Out", "She Bangs - English Version", "Most Girls", "All The Things She Said", "noflowrs[instrw]", "Lose Yourself", "AMAZING", "Always On Time", "Get The Party Started - P!nk Noise Disco - Edit", "Family Affair", "U Got It Bad", "The Tide Is High - Radio Mix", "Round & Round")

song_length <- c(150581, 280626, 298960, 214440, 66206, 320626, 209200, 245133, 223493, 265866, 247840, 206093, 186493)

song_popularity <- c(38, 64, 56, 86, 36, 76, 78, 77, 23, 82, 73, 70, 59)

song_released_after_2015 <- c(TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)

mystery_vector <- song_title[c(3,6,11)]


song_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vRZWC8O9g6_mHh6Hs0E4E2YwSeasXXUDB5hxCLtA8UEnVrrvf6_d2pYbfkMufBqoDx-AfaxDpcpJlED/pub?gid=476987712&single=true&output=csv") %>%
  rename(artist_name = 5)

artist_data <- song_data %>%
  separate_rows(artist_name, sep = ", ")

artist_data$artist_name %>% 
  nchar() %>% 
  max()

song_data %>%
  ggplot() +
  geom_bar(aes(y=track_popularity, fill=key_name))

           