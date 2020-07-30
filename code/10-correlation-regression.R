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

download.file("https://raw.githubusercontent.com/hejtmy/cebex-behavioral-analysis-r-2020-summer/master/data/facebook.csv", 
              "data/facebook.csv")
df_facebook <- read.csv("data/facebook.csv")
df_facebook_plt <- sample_n(df_facebook, 2000)
#pairs(sample_n(select(df_facebook, -userid, -gender), 500)) # too instese


hist(log(df_facebook$friend_count), breaks = 25)
hist(df_facebook$friendships_initiated)

qqnorm(sample(df_facebook$friend_count, 5000, replace = FALSE))
qqline(sample(df_facebook$friend_count, 5000, replace = FALSE))


cor(df_facebook$friend_count, df_facebook$friendships_initiated)
plot(df_facebook_plt$friendships_initiated, df_facebook_plt$friend_count)

cor_f_i <- cor(df_facebook$friend_count, df_facebook$friendships_initiated)
cor_f_i ^ 2

?cor
cor(df_movies$vote_average, df_movies$revenue, method = "spearman")
cor(select(df_movies, vote_average, vote_count, revenue, budget))


