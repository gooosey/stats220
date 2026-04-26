library(tidyverse)
library(httr)
library(magick)

api_key <- "api"

url <- "https://api.pexels.com/v1/search?query=call%20ducks&per_page=80"

response <- httr::GET(url, 
                      add_headers(Authorization = api_key))

data <- httr::content(response, 
                      as = "parsed", 
                      type = "application/json")

photo_data <- tibble(photos = data$photos) %>%
  unnest_wider(photos) %>%
  unnest_wider(src)

selected_photos <- photo_data %>%
  # Create me some coloumns
  mutate(
    # It does not tell me enough information about if its landscape or portrait.
    oreintation = ifelse(width > height, "landscape", "portrait"),
    # Get photo aspect ratio
    aspect_ratio = width / height,
    # Maybe the length of name determines how good 
    photographer_length = nchar(photographer)
    
  ) %>%
  # Just want landscape and their names greater than 10
  filter(oreintation == "landscape" | photographer_length > 10) %>%
  # Choose 20 rows after filtering
  slice(1:20)
# Save as photo
write_csv(selected_photos, "selected_photos.csv")

# Mean aspect ratio
mean_aspect_ratio <- round(
  mean(selected_photos$aspect_ratio, na.rm = TRUE),2)
# Mean height
mean_height <- selected_photos$height %>%
  mean(na.rm=T)
# Total characters in all name
total_chrname <- sum(selected_photos$photographer_length, na.rm = T)
# Sort it by landscape and portrait
grouped_photos <- selected_photos %>%
  group_by(oreintation) %>%
  summarise(
    # Find me the mean ration
    mean_aspect_ratio = mean_aspect_ratio,
    count = n()
  )
# Select the first row
mean_area_first_group <- grouped_photos$mean_aspect_ratio[1]


# Create a static png which changes each time when run
img_choose <- selected_photos[sample(nrow(selected_photos), 1),]
img <- image_read(img_choose$small) %>%
  image_resize("800x800")

# Random text
text <- c(
  "tiny duck. big opinions.",
  "I came, I quacked, I conquered",
  "absolutely no thoughts. just quack",
  "why is everyone so tall??",
  "professional puddle enthusiast",
  "I asked for snacks. again.",
  "small body. loud presence.",
  "running on 2% duck energy",
  "this meeting could’ve been a pond",
  "quack attack in progress"
)
text_select <- sample(text, 1)

# Random direction
direction <- c("north", "south", "center")

img_meme <- image_annotate(
  img,
  text = text_select,
  size=40,
  color = "white",
  strokecolor = "black",
  gravity = sample(direction, 1)
)

image_write(img_meme, "creativity.png")

