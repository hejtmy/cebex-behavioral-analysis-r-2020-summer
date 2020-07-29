library(ggplot2)
library(dplyr)

source("code/data-loading-functions.R")
df_movies <- load_movies_metadata(2500)

df_movies %>%
  filter(revenue > 0, revenue < 300) %>%
  ggplot(aes(x=is_action, y=revenue)) +
    geom_boxplot()

df_movies %>%
  filter(revenue > 0, revenue < 300) %>%
  group_by(is_action) %>%
  summarise(mean(revenue))

df_movies %>%
  filter(revenue > 0, budget > 0) %>%
  ggplot(aes(budget, revenue)) + geom_point() +
  geom_smooth(method="lm")

df_movies %>%
  filter(revenue > 0, budget > 0) %>%
  ggplot(aes(year, revenue)) + geom_point() +
  geom_smooth(method="lm")

## Population
## Sample

## p-values
df_movies %>%
  filter(revenue > 0, revenue < 300) %>%
  ggplot(aes(x=revenue)) +
    geom_histogram()

df_movies %>%
  filter(revenue > 0, revenue < 300) %>%
  with(t.test(revenue ~ is_action, data = .))

## effect sizes


### Parametric vs non parametric data
hist(log(as.numeric(df_movies$popularity)))

### Normality of data
set.seed(666)
freq <- rnorm(100,0,1)

hist(freq, breaks=15, probability = TRUE)
x <- seq(-4, 4, length=100)
x_norm <- dnorm(x)
lines(x, x_norm)

qqnorm(freq)
qqline(freq)

hist(df_movies$vote_average, breaks = 15)
qqnorm(df_movies$vote_average)
qqline(df_movies$vote_average)

df_movies <- load_movies_metadata()
df_movies_cleaned <- df_movies %>%
  mutate(vote_average = ifelse(vote_average == 0, NA, vote_average)) %>%
  mutate(m_vote = mean(vote_average, na.rm = TRUE), 
         sd_vote = sd(vote_average, na.rm = TRUE),
         z_vote = (vote_average-m_vote)/sd_vote) %>%
  mutate(vote_average = ifelse(abs(z_vote) > 3, NA, vote_average))
df_movies_cleaned <- df_movies_cleaned %>%
  sample_n(5000)

qqnorm(df_movies_cleaned$vote_average)
qqline(df_movies_cleaned$vote_average)

set.seed(666)
freq <- rnorm(100,0,1)
shapiro.test(freq)

df_movies %>% sample_n(1000) %>%
  with(shapiro.test(vote_average))

df_movies_cleaned %>%
  sample_n(1000) %>%
  with(shapiro.test(vote_average))
hist(df_movies_cleaned$vote_average)


### Homogenity of variances

