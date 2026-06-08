headlines_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vSzM_3hRnNKMfAv3-bn_yF833sqB7AWrMVEGs2dRKJ77myE7oHX2VKDlKWg6NmiVZ5Cj5Y5gFY4KSo1/pub?gid=0&single=true&output=csv") %>%
  slice(331 : 447)


headline_words1 <- headlines_data$headline[76] %>%
  str_squish() %>%
  str_split(" ") %>%
  unlist()

headline_words2 <- headlines_data$headline[70] %>%
  str_squish() %>%
  str_split(" ") %>%
  unlist() 


all_words <- union(headline_words1, headline_words2)
same_words <- intersect(headline_words1, headline_words2)

get_similarity <- function(phrase1, phrase2){
  
  words1 <- phrase1 %>% str_to_lower() %>% str_remove_all("[[:punct:]]") %>% str_squish() %>% str_split(" ") %>% unlist()
  words2 <- phrase2 %>% str_to_lower() %>% str_remove_all("[[:punct:]]") %>% str_squish() %>% str_split(" ") %>% unlist()
  
  num_same <- intersect(words1, words2) %>% length()
  num_total <- union(words1, words2) %>% length()
  
  num_same / num_total # remember last thing created is returned by default, or use return()
}

get_similarity(headlines_data$headline[34], headlines_data$headline[47])

compare_headlines <- tibble(headline1 = headlines_data$headline[1:58], headline2 = headlines_data$headline[59:116]) 

similarty_data <- compare_headlines %>%
  rowwise() %>%
  mutate(similarty_score = get_similarity(headline1, headline2)) 

density_plot <- similarty_data  %>%
  ggplot() +
  geom_density(aes(x=similarty_score))
  
