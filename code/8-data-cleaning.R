library(dplyr)
library(ggplot2)

path_mat <- "https://raw.githubusercontent.com/hejtmy/cebex-behavioral-analysis-r-2020-summer/master/data/student-alcohol-consumption/student-mat.csv"
path_por <- "https://raw.githubusercontent.com/hejtmy/cebex-behavioral-analysis-r-2020-summer/master/data/student-alcohol-consumption/student-por.csv"
df_mat <- read.csv(path_mat)
df_por <- read.csv(path_por)

match_columns <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob",
                   "reason","nursery","internet", "higher","famsup","freetime","goout", "romantic",
                   "activities", "health","famrel", "guardian", "traveltime", "schoolsup", "Dalc", "Walc")

df_students <- merge(df_mat, df_por, by = match_columns, suffixes = c("_mat", "_por"), all = TRUE)
df_students$Fedu <- factor(df_students$Fedu, levels = c(0,1,2,3,4),
                                 labels = c("none", "primary", "5th primary", "secondary", "higher"))

df_mat$subject <- "math"
df_por$subject <- "portugese"
df_math_por_wrong <- rbind(df_mat, df_por)
df_math_por_wrong$Fedu <- factor(df_math_por_wrong$Fedu, levels = c(0,1,2,3,4), 
                                 labels = c("none", "primary", "5th primary", "secondary", "higher"))
table(df_math_por_wrong$Fedu)

### Duplicit data
ggplot(df_math_por_wrong, aes(Fedu)) + geom_bar() +
  xlab("Father's education") + ylim(0, 350)

ggplot(df_students, aes(Fedu)) + geom_bar() +
  xlab("Father's education") +ylim(0, 350)

table(duplicated(df_math_por_wrong))
table(duplicated(df_math_por_wrong[, match_columns]))
table(duplicated(df_por[, match_columns]))

i_duplicated <- duplicated(df_math_por_wrong[, match_columns])

df_math_por_wrong[!i_duplicated, ]

### distinct
distinct(df_math_por_wrong, school, sex, famrel, Fedu)


## Outliers
source("code/data-loading-functions.R")
df_movies <- load_movies_metadata()
df_ratings <- read.csv("data/movies/ratings_small.csv")

### Unreal data
df_movies %>%
  ggplot(aes(vote_average)) + geom_histogram()

df_movies %>%
  ggplot(aes(budget)) + geom_histogram() + xlim(0,50)

### Extreme data
df_movies %>%
  ggplot(aes(y=revenue)) + geom_boxplot()
summary(df_movies$revenue)
sum(is.na(df_movies$revenue))

df_movies %>%
  ggplot(aes(x=vote_average)) + geom_histogram()

df_movies %>%
  filter(vote_average > 0) %>% # absolute cutoff -
  mutate(m_vote = mean(vote_average, na.rm = TRUE), 
         sd_vote = sd(vote_average, na.rm = TRUE),
         z_vote = (vote_average-m_vote)/sd_vote) %>%
  filter(abs(z_vote) < 3) %>%
  ggplot(aes(x=vote_average)) +
    geom_histogram()

## What to do with outliers
### Remove entire observations
df_movies_filtered <- df_movies %>%
  filter(vote_average > 0) %>% # absolute cutoff -
  mutate(m_vote = mean(vote_average, na.rm = TRUE), 
         sd_vote = sd(vote_average, na.rm = TRUE),
         z_vote = (vote_average-m_vote)/sd_vote) %>%
  filter(abs(z_vote) < 3)


### Replace the values with NA
df_movies_cleaned <- df_movies %>%
  mutate(vote_average = ifelse(vote_average == 0, NA, vote_average)) %>%
  mutate(m_vote = mean(vote_average, na.rm = TRUE), 
         sd_vote = sd(vote_average, na.rm = TRUE),
         z_vote = (vote_average-m_vote)/sd_vote) %>%
  mutate(vote_average = ifelse(abs(z_vote) > 3, NA, vote_average))

table(is.na(df_movies_cleaned$vote_average))
nrow(df_movies_filtered)


### Replacing values with other values
df_movies_averaged <- df_movies %>%
  mutate(vote_average = ifelse(vote_average == 0, NA, vote_average)) %>%
  mutate(m_vote = mean(vote_average, na.rm = TRUE), 
         sd_vote = sd(vote_average, na.rm = TRUE),
         z_vote = (vote_average-m_vote)/sd_vote) %>%
  mutate(vote_average = ifelse(abs(z_vote) > 3, NA, vote_average)) %>%
  mutate(vote_average = ifelse(is.na(vote_average), m_vote, vote_average))

df_movies_averaged %>%
  ggplot(aes(x=vote_average)) +
    geom_histogram()


## Transformations
hist(df_movies$revenue)
hist(log(df_movies$revenue))

df_movies %>%
  filter(revenue > 0) %>%
  mutate(log_revenue = log(revenue)) %>%
  ggplot(aes(revenue)) + geom_histogram() +
    scale_x_continuous(trans = "log")
