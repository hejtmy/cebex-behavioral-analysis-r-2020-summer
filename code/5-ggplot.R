#install.packages("ggplot2")
#install.packages("tidyverse")
library(ggplot2)
library(dplyr)

pth_movies <- "data/movies/movies_metadata.csv"
df_movies <- read.csv(pth_movies)

df_movies <- df_movies %>%
  sample_n(5000)

hist(df_movies$vote_average, breaks = 25)
plot(df_movies$vote_average)