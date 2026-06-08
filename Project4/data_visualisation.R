library(tidyverse)
library(lubridate)
logged_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vTi4w0Il1rmXgdfBpzRxsB6LBiA3gY0HMHg-0JHRQC9Uw7ZCkXe_Kr7KEuT-1GKAQ-NQJxsw2V8CiTn/pub?gid=1435256090&single=true&output=csv")

logged_data <- logged_data %>%
  rename(
    video_type = `What type of video did you watch?`,
    enjoyed = `Did you enjoy your video?`,
    rating = `How would you like to rate your video?`,
    duration = `Duration of video (min) ?\nEnter a number (e.g. 23.14). Estimate if unsure.`,
    watched_full = `Did you watch the entire video?`
  )

# Theme
my_colours <- c("#fee5d9", "#fcbba1", "#fc9272", "#fb6a4a", "#de2d26", "#a50f15", "black", "white")

my_theme <- theme(plot.background = element_rect(fill = my_colours[1], colour = NA),
                  panel.background = element_rect(fill = my_colours[1], colour = NA),
                  strip.background = element_rect(fill = my_colours[2], colour = NA),
                  strip.text = element_text(colour = my_colours[7], face = "bold"),
                  panel.grid.major = element_line(colour = my_colours[2], linewidth = 0.3),
                  panel.grid.minor = element_blank(),
                  axis.ticks = element_blank(),
                  axis.line = element_blank(),
                  axis.text = element_text(colour = my_colours[6]),
                  axis.title = element_text(colour = my_colours[6]),
                  plot.margin = margin(0.5, 0.5, 0.5, 0.5, "cm"),
                  plot.title = element_text(colour = my_colours[6], face = "bold", size = 14),
                  plot.subtitle = element_text(colour = my_colours[7]),
                  plot.caption = element_text(colour = my_colours[7], face = "italic"),
                  legend.background = element_rect(fill = my_colours[1], colour = NA),
                  legend.key = element_rect(fill = my_colours[1], colour = NA))

# Watch videos
num_video <- logged_data %>%
  group_by(video_type) %>%
  summarise(count = n()) %>%
  ungroup()

video_watch <- num_video %>%
  ggplot() + 
  geom_bar(aes(x= reorder(video_type, -count), 
               y=count,), 
           stat="identity",
           fill = my_colours[6]
           ) + my_theme +
  labs(
    title = "What type of videos watched regularly",
    x = "Category of videos",
    y = "Count of videos",
  )
# When watch
time_plot <- logged_data %>%
  mutate(watch_hour = hour(dmy_hms(Timestamp)),
  time_day = case_when(
    watch_hour >= 5  & watch_hour < 12 ~ "Morning",
    watch_hour >= 12 & watch_hour < 17 ~ "Afternoon",
    watch_hour >= 17 & watch_hour < 21 ~ "Evening",
    TRUE ~ "Night"
  )
)

jitter_watch <- time_plot %>%
  ggplot() + 
  geom_jitter(aes(x=time_day, y=watch_hour, col = video_type), size= 3) +
  labs(
    title = "When do I actually watch YouTube?",
    subtitle = "Each dot is one video, coloured by category",
    x = "Time of day",
    y = "Hour (24h)",
    col = "Video Type",
  ) +
  my_theme

# Liked watching or not

rating_data <- form_data %>%
  group_by(enjoyed, video_type) %>%
  summarise(count = n()) %>%
  ungroup %>%
  ggplot() + 
  geom_col(aes(x=enjoyed, y=count, fill=video_type)) +
  labs(
    title = "What I enjoy watching by video type",
    x = "Enjoyed watching?",
    y = "Number of videos",
    fill = "Video Type",
  ) +
  my_theme


ggsave("plot1.png", video_watch, width = 10, height = 8)
ggsave("plot2.png",jitter_watch, width = 10, height = 8)
ggsave("plot3.png",rating_data, width = 10, height = 8)
