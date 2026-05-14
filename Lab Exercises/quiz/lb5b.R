url1 <- read_csv("https://stat.auckland.ac.nz/~fergusson/stats220_S124/zoom_data/participants14.csv")
url2 <- read_csv("https://stat.auckland.ac.nz/~fergusson/stats220_S124/zoom_data/participants11.csv")

all_data <- bind_rows(url1, url2) 


all_data %>% 
  group_by(private_name ) %>%
  summarise(total_time = sum(duration_minutes)) %>%
  summarise(max_total = max(total_time))

all_data %>%
  filter(in_waiting_room == "Yes") %>%
  group_by(date_lecture) %>%
  summarise(nstudents = n()) %>%
  arrange(desc(nstudents))
