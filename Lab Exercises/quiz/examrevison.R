song_popularity <- c(67, 75, 96, 81, 91, 76, 96, 85, 95, 74, 77, 87, 76, 67, 84, 71, 96, 88, 74, 79, 97, 92, 95, 85, 81, 87, 92, 76, 92, 96, 63, 59, 83, 89, 70, 87, 81, 85, 95, 83, 98, 96, 80, 85, 92, 83, 91, 67, 93, 89, 85, 87, 77, 85, 89, 100, 83, 95, 76, 90, 75, 87, 71, 90, 72, 82, 74, 33, 83, 94, 79, 80, 74, 70, 74, 83, 75, 89, 88, 86, 68, 92, 75, 73)
sort_pop <- sort(song_popularity) 
song_length <- c(161853, 153190, 205946, 231832, 174000, 165760, 215281, 207065, 202226, 186677, 200000, 176146, 153000, 141805, 185680, 206385, 172626, 238805, 257213, 169237, 214416, 213493, 186538, 191013, 193506, 152137, 96825, 136266, 162680, 221693, 167480, 225148, 173549, 214613, 173182, 187111, 213718, 187943, 224694, 226088, 184893, 227527, 193346, 212000, 197442, 206772, 225664, 224773, 185422, 136760, 242965, 216120, 202133, 168873, 175163, 203807, 133613, 143901, 160656, 189560, 256000, 202735, 175344, 178147, 195760, 194050, 200547, 179720, 207853, 179426, 231041, 160239, 210560, 216764, 270586, 195013, 204316, 263288, 254181, 174728, 185855, 212878, 174680, 173381, 185600, 261818, 145800, 258799, 198324, 157890, 164818, 168601, 193279)

song_title <- c("Beers On Me", "One Mississippi", "Buy Dirt", "The Motto", "Hrs and Hrs", "If I Was a Cowboy", "AHHH HA", "Better Days (NEIKED x Mae Muller x Polo G)", "TO THE MOON", "I Hate U", "Fancy Like", "I Wish", "good 4 u", "Light Switch", "Don't Play That", "Essence (feat. Justin Bieber & Tems)", "Cigarettes", "Freaky Deaky", "Doin' This", "MAMIII", "Rocking A Cardigan in Atlanta", "Nail Tech", "INDUSTRY BABY (feat. Jack Harlow)", "Surface Pressure", "she's all i wanna be", "Woman", "Good Morning Gorgeous", "Boyfriend", "Heart On Fire", "Peru", "Bad Habits", "City of Gods", "Never Wanted To Be That Girl", "Save Your Tears (with Ariana Grande) (Remix)", "Easy On Me", "love nwantiti (ah ah ah)", "Usain Boo", "I'm Tired - From 'Euphoria' An HBO Original Series", "23", "Bussin", "Need to Know", "Smokin Out The Window", "Enemy (with JID) - from the series Arcane League of Legends", "half of my hometown (feat. Kenny Chesney)", "Fingers Crossed", "When I’m Gone (with Katy Perry)", "Beautiful Lies", "High", "Rumors (feat. Lil Durk)", "Cold Heart - PNAU Remix", "Pressure", "Oh My God", "Still D.R.E.", "Me or Sum (feat. Future & Lil Baby)", "Closer (feat. H.E.R.)", "I Hate YoungBoy", "You Should Probably Leave", "Worst Day", "Waiting On A Miracle", "What Else Can I Do?", "Come Back As A Country Boy", "Big Energy", "We Don't Talk About Bruno", "Dos Oruguitas", "abcdefu", "The Family Madrigal", "Knife Talk (with 21 Savage ft. Project Pat)", "Broadway Girls (feat. Morgan Wallen)", "Sacrifice", "Banking On Me", "One Right Now (with The Weeknd)", "I Love You So", "Do We Have A Problem?", "Flower Shops (feat. Morgan Wallen)", "Heat Waves", "Shivers", "All Of You", "Numb Little Bug", "Sand In My Boots", "Levitating", "'Til You Can't", "Super Gremlin", "You Right", "pushin P (feat. Young Thug)", "Never Say Never (with Lainey Wilson)", "P power (feat. Drake)", "Iffy", "Circles Around This Town", "Do It To It", "THATS WHAT I WANT", "Scorpio", "By Your Side", "Slow Down Summer", "Home Sweet", "Ghost", "AA", "To Be Loved By You")


song_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vS8ynnfEAOH9G59D6ZS0EhW6X9taKBE2ou0Z6qO_XJUzwCuD_DjNvDNRNuouNivlgptmqyqBZYsrKTs/pub?gid=997193167&single=true&output=csv")

song_data %>%
  arrange(desc(energy)) %>%
  filter(rand_var > 0.3)

song_title <- c("Dos Oruguitas", "Sacrifice", "half of my hometown (feat. Kenny Chesney)", "AA", "Never Say Never (with Lainey Wilson)", "Numb Little Bug", "Freaky Deaky", "You Should Probably Leave", "Smokin Out The Window", "To Be Loved By You", "Do We Have A Problem?", "What Else Can I Do?")

song_length <- c(214613, 188918, 231832, 189560, 176146, 169237, 215281, 213493, 197442, 198324, 207065, 179426)

song_popularity <- c(86, 92, 71, 74, 74, 89, 85, 79, 85, 74, 86, 89)

song_data <- tibble(song_title, song_length, song_popularity) %>%
  mutate(song_income = song_length * 0.01,
         song_title_lower = str_to_lower(song_title))
song_data %>%
  filter(str_detect(song_title,"y"))

         

song_data <- fromJSON("https://stat.auckland.ac.nz/~fergusson/stats220_S124/data/lab3b_json40.json")

song_data %>%
  separate_rows(artist_name, sep = ",") %>%
  pull(artist_name) %>%
  unique()

song_data %>%
  filter(track_popularity > 79 & str_detect(artist_genre, "pop")) %>% nrow()

pop_songs  <- song_data %>%
  mutate(pop = ifelse(str_detect(artist_genre, "pop"), "yes", "no"))

pop_songs %>%
  group_by(pop) %>%
  summarise(median_popularity = median(track_popularity, na.rm = TRUE))

long_songs <- song_data %>%
  mutate(track_name_num_words = str_count(track_name)) %>%
  filter(track_name_num_words > 2) %>%
  nrow()


song_data <- fromJSON("https://stat.auckland.ac.nz/~fergusson/stats220_S124/data/lab4A.json")

summarised_data <- song_data %>%
    mutate(song_speed = ifelse(tempo > 120, 'fast', 'slow')) %>%
    group_by(song_speed) %>%
    summarise(n = n())


ggplot(data = summarised_data) +
  geom_col(aes(x = song_speed, y = n, fill = song_speed)) +
labs(title = 'Comparing the speed of songs', x = 'Speed of song based on tempo', y = 'Number of songs')



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
  geom_point(aes(x = mean_tempo, y = mode_name, col = valence_group), size = 5)


song_data <- fromJSON("https://stat.auckland.ac.nz/~fergusson/stats220_S124/data/lab4B.json")

genre_data <- song_data %>%
  separate_rows(artist_genre, sep = ",") %>%
  group_by(artist_genre) %>%
  filter(n() >= 10)



url1 <- "https://stat.auckland.ac.nz/~fergusson/stats220_S124/zoom_data/participants8.csv"
url2 <- "https://stat.auckland.ac.nz/~fergusson/stats220_S124/zoom_data/participant.csv"

data1 <- read_csv(url1)


data1 %>%
  unique(private_name)
