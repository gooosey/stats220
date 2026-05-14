library(magick)

black <- image_blank(500, 500, "black")
frame1 <- black %>% 
  image_annotate(text="1", gravity = "North", color="white", size=50)

frame2 <- black %>%
  image_annotate(text="2", gravity="South", color="white",size=50)

frame3 <- c(frame1, frame2)
animate <- frame3 %>%
  image_animate(delay = c(50, 50))
animate
