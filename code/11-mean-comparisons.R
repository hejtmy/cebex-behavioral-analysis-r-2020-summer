library(ggplot2)
library(dplyr)
library(tidyr)
source("code/data-loading-functions.R")
df_movies <- load_movies_metadata(2500)
df_movies_complete <- load_movies_metadata()

## Comparing two means
df_movies %>%
  filter(revenue > 0) %>%
  mutate(revenue = log10(revenue)) %>%
  ggplot(aes(y=revenue, fill=is_family)) + geom_boxplot() +
  labs(y="Log10 of revenue in millions of dollars")

## 
hist(df_movies$vote_average)
qqnorm(df_movies$vote_average)

df_movies %>%
  filter(vote_count > 0) %>%
  #filter(vote_count > quantile(vote_count, 0.1)) %>%
  ggplot(aes(vote_average)) + geom_histogram()

df_movies %>%
  filter(vote_count > 0) %>%
  filter(vote_count > quantile(vote_count, 0.1)) %>%
  ggplot(aes(sample=vote_average)) + geom_qq() + 
  stat_qq_line()

df_movies %>%
  filter(vote_count > 0) %>%
  filter(vote_count > quantile(vote_count, 0.1)) %>%
  ggplot(aes(sample=vote_average, color=is_family)) + 
  geom_qq() + stat_qq_line() + facet_wrap(~is_family)

df_movies_complete %>%
  filter(vote_count > 0) %>%
  filter(vote_count > quantile(vote_count, 0.1)) %>%
  ggplot(aes(x=vote_average, fill=is_family)) + 
  #geom_histogram(aes(y=..density..)) + facet_wrap(~is_family)
  geom_histogram(aes(y=..density..)) + facet_wrap(~is_family, scales = "free")


## T-test
df_movies_complete %>%
  filter(vote_count > 0) %>%
  filter(vote_count > quantile(vote_count, 0.1)) %>%
  ggplot(aes(x=vote_average, fill=is_family)) + 
  #geom_histogram(aes(y=..density..)) + facet_wrap(~is_family)
  geom_histogram(aes(y=..density..))

df_movies_complete %>%
  filter(vote_count > 0) %>%
  filter(vote_count > quantile(vote_count, 0.1)) %>%
  with(t.test(vote_average ~ is_family, data=.))

df_movies_filtered <- df_movies_complete %>%
  filter(vote_count > 0) %>%
  filter(vote_count > quantile(vote_count, 0.1))

t.test(vote_average ~ is_family, data=df_movies_filtered)

ggplot(df_movies_filtered, aes(is_family, vote_average)) + geom_boxplot()

library(effsize)
df_movies_complete %>%
  filter(vote_count > 0) %>%
  filter(vote_count > quantile(vote_count, 0.1)) %>%
  with(cohen.d(vote_average ~ factor(is_family)))


### equal variances
df_movies_filtered %>%
  sample_n(2000) %>%
  group_by(is_family) %>%
  mutate(avg=mean(vote_average)) %>%
  ungroup() %>%
  ggplot(aes(x = is_family, y = vote_average, color=is_family)) + 
  geom_point(position = position_jitter(0.2)) +
    geom_errorbar(aes(ymax=avg, ymin=avg)) +
    theme(aspect.ratio = 1)

t.test(vote_average ~ is_family, data=df_movies_filtered, var.equal = TRUE)
## One sided t-test
t.test(df_movies_filtered$vote_average[df_movies_filtered$is_comedy], mu = 5.5)

## Paired
df_ratings <- read.csv("data/movies/ratings_small.csv")
head(df_ratings)
length(unique(df_ratings$userId))

## Binding family information
df_ratings_family <- df_ratings %>%
  mutate(movieId = as.character(movieId)) %>%
  inner_join(select(df_movies_complete, id, is_family), by=c("movieId" = "id"))

df_comparing_family <- df_ratings_family %>%
  group_by(userId, is_family) %>%
  summarise(avg = mean(rating),
            n_movies = n()) %>%
  ungroup() %>%
  filter(n_movies > 5) %>%
  select(-n_movies) %>%
  pivot_wider(names_from = "is_family", values_from="avg", names_prefix = "family") %>%
  select(userId, family=familyTRUE, not_family=familyFALSE) %>%
  drop_na()

str(df_comparing_family)
df_comparing_family %>%
  pivot_longer(cols = c("not_family", "family")) %>%
  ggplot(aes(as.numeric(factor(name)), value, color=factor(userId))) + 
  geom_line() + guides(color=FALSE) + geom_point()

t.test(df_comparing_family$family, df_comparing_family$not_family, paired = TRUE)

## Non parametric data
hist(df_movies$revenue)
t.test(revenue~is_family, data=filter(df_movies_complete, revenue > 0)) #wrong, revenue is not normally distributed
df_movies_complete %>%
  filter(revenue > 0) %>%
  with(cohen.d(revenue ~ factor(is_family)))

wilcox.test(revenue~is_family, data=filter(df_movies_complete, revenue > 0))
wilcox.test(revenue~is_drama, data=filter(df_movies_complete, revenue > 0))
