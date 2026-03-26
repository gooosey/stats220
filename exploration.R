
logged_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vTi4w0Il1rmXgdfBpzRxsB6LBiA3gY0HMHg-0JHRQC9Uw7ZCkXe_Kr7KEuT-1GKAQ-NQJxsw2V8CiTn/pub?gid=1435256090&single=true&output=csv")

# Renaming variables
latest_data <- logged_data %>%
  rename(
    category = 2,
    enjoy = 3, 
    rating = 4, 
    watch_time = 5,
    full_video = 6
  )

print(latest_data)

# summary watch time
max(latest_data$watch_time)
min(latest_data$watch_time)
mean(latest_data$watch_time)

# summary ratings
mean(latest_data$rating)

# Plotting plots

ggplot(data = latest_data) +
  geom_bar(aes(x=rating),
           fill = "yellow") +
  labs(title="Distrubution of video ratings",
       subtitle = "Shows how frequently each rating score occurs") +
  theme_minimal()

ggplot(data = latest_data) + 
  geom_bar(aes(x = category, fill = category)) +
  labs(
    title = "Video Categories by Watching Mode",
    subtitle = "Displays the number of videos in each category"
  ) +
  theme_minimal()

ggplot(data = latest_data) + 
  geom_bar(aes(x = enjoy, fill = enjoy)) +
  labs(
    title = "Video Categories by Watching Mode",
    subtitle = "Enjoyment level among videos"
  ) +
  theme_minimal()
