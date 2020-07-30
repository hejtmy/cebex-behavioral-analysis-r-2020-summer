library(ggplot2)
library(dplyr)
library(tidyr)
source("code/data-loading-functions.R")
df_movies <- load_movies_metadata(2500)

df_movies %>%
  filter(revenue > 0, vote_average > 0) %>%
  ggplot(aes(vote_average, revenue)) + geom_point() +
  geom_smooth(method="lm")

pairs(select(df_movies, year, vote_average, vote_count, revenue))
