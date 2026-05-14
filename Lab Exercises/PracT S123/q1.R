num_learning_methods <- c(3, 5, 3, 4, 3, 3, 2, 3, 3, 5, 4, 3, 5)

survey_length <- c("Appropriate in length", "Too long", "Appropriate in length", "Appropriate in length", "Appropriate in length", "Too long", "Appropriate in length", "Appropriate in length", "Appropriate in length", "Appropriate in length", "Appropriate in length", "Appropriate in length", "Appropriate in length")

country <- c("Germany", "Indonesia", "United States of America", "Australia", "United States of America", "China", "Austria", "Canada", "Serbia", "Brazil", "Argentina", "Netherlands", "Spain")

num_languages <- c(10, 5, 2, 5, 7, 3, 8, 4, 8, 8, 2, 4, 13)

codes_R <- c(FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE)

highest_ed_bachelors <- c(FALSE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, TRUE, FALSE)

a <- num_languages - 14
a[3:8]
survey_data <- read_csv("https://stat.auckland.ac.nz/~fergusson/test_data/CQbKSIxYSs.csv")
print(survey_data)
