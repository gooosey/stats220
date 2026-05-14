library(tidyverse)

############
# DO NOT change the URL used below
# DO NOT attempt to open this URL in a browser
# INSTEAD you must run the line below within RStudio

source("https://raw.githubusercontent.com/elb0/stats220-2026-s1/refs/heads/main/data_25S1_q1.R")

# The source function will create the data objects you need
# which will appear in your Environment panel
############

############
# Part A
############
# What type of values does the vector named youtube_channel contain? Enter the word character, logical or numeric

character


############
# Part B
############
# What is the name of the YouTube channel in position 55 of the vector named youtube_channel?

youtube_channel[55]
@CuriousArchive
############
# Part C
############
# Find the number of characters of each value in the vector named youtube_channel, then find the sum of all of these values. 
# What number value do you get as a result? 
sum(nchar(youtube_channel))

1802
############
# Part D
############
# Using the vector named time_spent, what was the shortest time spent on the Foundation Project?
min(time_spent)
921 sec


############
# Part E
############
# What was the total time spent by students on the Foundation Project, converted from seconds to minutes?

sum(time_spent) / 60
139938.1


############
# Part F
############
# Create a new vector named some_drawings by keeping the values in positions 58 to 92 of the vector named drawing_word. 

# How many values are in the vector named some_drawings?

values <- drawing_word[58:92]
35 !!

############
# Part G
############
# Extract the variable pudding_article_year_published as a vector from the data frame named project_data, and name this vector year_published. 

# Create a vector named article_age by finding the differences between 2025 and each value of the vector named year_published. 

# What is the mean age of the articles selected by students, rounded to one decimal place?
year_published <- project_data$pudding_article_year_published
article_age <- 2025 - year_published
round(mean(article_age), 1) # 2
############
# Part H
############
# Slice the data frame named project_data to only keep the rows 48 to 106. 

# Give this new smaller data frame the name less_responses. 

# Did the student on row 58 of the less_responses data frame use the word "like" in their response about what they liked about the pudding article selected? Enter yes or no.

less_responses <- project_data %>%
  slice(48:106)
less_responses[58,]
