library(dplyr)
library(ggplot2)
source("code/data-loading-functions.R")
df_ratings <- read.csv("data/movies/ratings_small.csv")
head(df_ratings)
head(df_movies)

## Binding of observations

### rbind
set.seed(2020)
df_1 <- data.frame(id = 1:99, 
                   condition = rep(c("C", "T", "CT"), 33), 
                   score = rnorm(99, 10, 1))

df_2 <- data.frame(id = 100:198, 
                   condition = rep(c("C", "T", "CT"), 33), 
                   score = rnorm(99, 10, 1))

df_complete <- rbind(df_1, df_2)
range(df_complete$id)
table(df_complete$condition)

### Problems
#### SAME NAMES
df_2 <- data.frame(id = 100:198,
                   score = rnorm(99, 10, 1),
                   condition = rep(c("C", "T", "CT"), 33))

rbind(df_1, df_2)
df_2 <- data.frame(id = 100:198,
                   score2 = rnorm(99, 10, 1),
                   condition = rep(c("C", "T", "CT"), 33))
rbind(df_1, df_2)
df_2 <- data.frame(id = as.character(100:198),
                   score = rnorm(99, 10, 1),
                   condition = rep(c("CE", "TE", "CTE"), 33))
str(rbind(df_1, df_2))

### Same number of columns
df_2 <- data.frame(id = as.character(100:198),
                   score = rnorm(99, 10, 1),
                   condition = rep(c("CE", "TE", "CTE"), 33),
                   came_late = rep(c(TRUE, FALSE, TRUE), 33))
str(rbind(df_1, df_2))
df_1$came_late <- NA
head(df_1)
str(rbind(df_1, df_2))
df_1$came_late <- NULL

## Cbind
head(df_1)
df_2 <- data.frame(id = 1:99, score2 = rnorm(99, 10, 1))
str(cbind(df_1, df_2))
df_2 <- data.frame(score2 = rnorm(99, 10, 1))
str(cbind(df_1, df_2))

df_2 <- data.frame(score2 = rnorm(97, 10, 1))
str(cbind(df_1, df_2))
df_2 <- rbind(df_2, data.frame(score2=c(NA, NA)))
tail(df_2)
str(cbind(df_1, df_2))

## Merging
path_mat <- "https://raw.githubusercontent.com/hejtmy/cebex-behavioral-analysis-r-2020-summer/master/data/student-alcohol-consumption/student-mat.csv"
path_por <- "https://raw.githubusercontent.com/hejtmy/cebex-behavioral-analysis-r-2020-summer/master/data/student-alcohol-consumption/student-por.csv"
df_mat <- read.csv(path_mat)
df_por <- read.csv(path_por)

df_movies <- load_movies_metadata()
df_ratings <- read.csv("data/movies/ratings_small.csv")

### Merge
df_movies_titles <- select(df_movies, title, id)
head(df_movies_titles)
head(df_ratings)
#errors out - merge(df_ratings, df_movies_titles)
merge(df_ratings, df_movies_titles, by="id") #ERRORS out
df_ratings <- merge(df_ratings, df_movies_titles, by.x ="movieId", by.y = "id")
str(df_ratings)

## Shorter without creation of the specific table
df_ratings_merged <- merge(df_ratings, 
                    select(df_movies, title, id), 
                    by.x ="movieId", by.y = "id")

df_ratings_merged <- merge(df_ratings, 
                    select(df_movies, title, movieId = id), 
                    by = "movieId") %>%
  select(-movieId)
head(df_ratings_merged)

### JOINS
str(df_ratings)
str(df_movies_titles)
df_ratings %>%
  mutate(movieId = as.character(movieId)) %>%
  left_join(df_movies_titles, by=c("movieId" = "id")) %>%
  count(title)

df_ratings %>%
  mutate(movieId = as.character(movieId)) %>%
  inner_join(df_movies_titles, by=c("movieId" = "id")) %>%
  head()

df_ratings %>%
  group_by(movieId) %>%
  summarise(mean = mean(rating)*2) %>%
  mutate(movieId = as.character(movieId)) %>%
  inner_join(df_movies, by=c("movieId" = "id")) %>%
  select(title, vote_average, mean) %>%
  head()

head(df_mat)
