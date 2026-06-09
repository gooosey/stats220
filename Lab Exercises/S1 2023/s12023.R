total_minutes_delivered <- panopto_data %>%
  group_by(session_name) %>%
  mutate(total_minutes = sum(minutes_delivered)) %>% !summarise
  arrange(desc()) %>%
  slice(1:10)

students_per_recirdubg + 
  ggplot((aes(x=num_students, y = reorder(session_namem, -lecture_num)))) + 
  geom_col(aes(fill = num_student)) +
  geom_text(aes(label=)) + 
  labs(title="", x="", y="") + 
  guides(fill="none")

query1<- "Link"

response <- fromJSON(query1)
track_data1 <- repsonse1$quey1

qurey2 <- "Link"
response <- fromJson(qurey2)
track_data2< - reposne2$qurey2

track_data <0- bind_row(track_dat1, track_data2) %>%
  select(wrappty_tye, kind, trakcId, track_name, releaseDAte)


course_data <- map_dfr(1 : 3, function(i){
  url <- paste0("https://courseoutline.auckland.ac.nz/dco/course/
                advanceSearch?...&pageNumber=", i)
  page <- read_html(url)
  course_prescription <- page %>%
    html_elements("table") %>%
    html_table()
  return(course_prescription)
})