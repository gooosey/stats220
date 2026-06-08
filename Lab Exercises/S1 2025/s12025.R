#library(tidyverse)
#library(rvest)
################
## Q2
################
ed_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vS0KP0zEnwhekrBrUk_AC0_kCFb8Eu2LlWpwBHNxP8m7SXaVZXw5zlXDXOrMabFh591RVF6MX0SsDv5/pub?gid=0&single=true&output=csv")
ed_data <- ed_data %>%
  mutate(date = dmy(date))
## Part A
# Part A
view_data <- ed_data %>%
  filter(views > 0)
view_data %>%
  ggplot() +
  geom_bar(aes(date))

## Part B
active_data <- ed_data %>%
  mutate(active = ifelse(contributions > 0 | views > 0, "yes", "no")) 
active_per_day <- active_data %>%
  filter(str_detect(active, "yes")) %>%
  group_by(date) %>%
  summarise(num_users = n())
  
active_per_day
## Part C
top_10_student_contributors <- ed_data %>%
  group_by(user_id) %>%
  summarise(mean_num_contributions = mean(contributions)) %>%
  arrange(desc(mean_num_contributions)) 
top_10_student_contributors[1,]  

## Part D
wday_viewed_data <- ed_data %>%
  mutate(weekday = wday(date, label=TRUE))
  
wday_viewed_data %>%
  ggplot() +
  geom_col(aes(x = weekday, y = views))

################
## Q5
################
url <- "https://datalandscapes.online/scrapeable/scrappy.html"
# print the URL so you can copy into a web browser
url
page <- read_html(url)
course_title <- page %>%
  html_element("h2") %>%
  html_text2()
course_description <- page %>%
  html_element("#description") %>%
  html_text2()
course_topics <- page %>%
  html_element("ul") %>%
  html_text2() %>%
  str_split("\n") %>%
  unlist()
uni_logo <- page %>%
  html_element("img") %>%
  html_attr("src")
course_dco <- page %>%
  html_element(".dco") %>%
  html_attr("href")
website_data <- tibble(course_title, course_description, course_topics, uni_logo, course_dco)
################
## Q6
################
thread_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vS0KP0zEnwhekrBrUk_AC0_kCFb8Eu2LlWpwBHNxP8m7SXaVZXw5zlXDXOrMabFh591RVF6MX0SsDv5/pub?gid=866779028&single=true&output=csv")
## Part A
text_length <- thread_data %>%
  mutate(num_chars_text = nchar(text),
         char_bucket = case_when(
           num_chars_text < 200 ~ "Below 200 characters",
           num_chars_text <= 400 ~ "Between 200 and 400 characters",
           TRUE ~ "More than 400 characters")) %>%
  group_by(category, char_bucket) %>%
  summarise(n = n())
text_length %>%
  ggplot() +
  geom_point(aes(x = char_bucket,
                   y = category,
                   colour = category, size=n))
## Part B
key_words <- c("what", "why", "how", "when", "where")
words <- thread_data %>%
  mutate(clean_text = str_to_lower(text) %>% str_remove_all("[[:punct:]]")) %>%
  separate_rows(clean_text, sep = " ") %>%
  filter(clean_text %in% key_words) %>%
  group_by(clean_text) %>%
  summarise(num_used = n()) 

words %>%
  ggplot() +
  geom_col(aes(y = reorder(clean_text, num_used),
               x = num_used), fill="white")  + 
  labs(y="key_word") +
  geom_text(aes(y = reorder(clean_text, num_used), x = num_used, label = num_used), hjust = -0.2) +
  theme_minimal()

## Part C
get_similarity <- function(phrase1, phrase2){
  words1 <- phrase1 %>% str_squish() %>% str_split(" ") %>% unlist()
  words2 <- phrase2 %>% str_squish() %>% str_split(" ") %>% unlist()
  num_same <- intersect(words1, words2) %>% length()
  num_total <- union(words1, words2) %>% length()
  num_same / num_total
}
longest_titles <- thread_data %>%
  filter(category == "Projects") %>%
  mutate(lengthtitle = nchar(title)) %>%
  arrange(-lengthtitle) %>%
  slice(1:2)
title1 <- longest_titles$title[1]
title2 <- longest_titles$title[2]

sim_score = get_similarity(title1, title2)
sim_score
  