library(magick)

# Loading up image
img <- image_read("inspo_meme.gif")

# Modify image
new_meme <- img %>%
  image_scale(400) %>%
  image_annotate("Good night chat",
                 color= "White",
                 size= 50, 
                 font= "Impact",
                 gravity= "north") 
# Saving meme
image_write(new_meme, "my_meme.png")

# Annimations
frame1 <- img[1] %>%
  image_scale(400) %>%
  image_annotate("Good night chat",
                 color= "Red",
                 size= 50, 
                 font= "Impact",
                 gravity= "north") 

frame2 <- img[2] %>%
  image_scale(400) %>%
  image_annotate("Good night chat.",
                 color= "Orange",
                 size= 50, 
                 font= "Impact",
                 gravity= "north") 
frame3 <- img[1] %>%
  image_scale(400) %>%
  image_annotate("Good night chat..",
                 color= "Yellow",
                 size= 50, 
                 font= "Impact",
                 gravity= "north") 
frame4 <- img[1] %>%
  image_scale(400) %>%
  image_annotate("Good night chat...",
                 color= "Blue",
                 size= 50, 
                 font= "Impact",
                 gravity= "north")


frame5 <- img[1] %>% 
  image_scale(400) %>%
  image_annotate("Good night chat...",
                 color= "Blue",
                 size= 50, 
                 font= "Impact",
                 gravity= "north") 
# Blur image
blurF5 <- image_blur(frame5, 10, 5) 

# Black box
blackBox <- image_blank(
  width= 500,
  height= 500,
  color = "black",
)

blackani <- blackBox %>%
  image_annotate("ZZZZZzzzz...",
                 color= "white",
                 size= 50,
                 font= "impact",
                 gravity= "center")

animated_meme <- c(frame1,frame2,frame3,frame4, blurF5, blackani) %>%
  image_animate(delay = c(100,100,100,100,150,150))

image_write(animated_meme, "animated_meme.gif")