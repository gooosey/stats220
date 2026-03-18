library(tidyverse)
library(magick)

image_read("https://images.unsplash.com/photo-1773262726194-7f2ad2fb0152?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwxOHx8fGVufDB8fHx8fA%3D%3D") %>% 
  image_resize("90%") %>% 
  image_annotate(" Start your projects early! ",
                 gravity = "center",
                 boxcolor = "white",
                 color = "black",
                 size = "35") %>%
  image_annotate("-A former STATS 220 student", 
                 gravity = "south",
                 size = "15",
                 color = "purple")
