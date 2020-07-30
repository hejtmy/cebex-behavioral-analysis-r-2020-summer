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

cor(df_movies$vote_count, df_movies$revenue)
cov(df_movies$vote_count, df_movies$revenue)
cov(df_movies$vote_count/100, df_movies$revenue/100)

cor.test(df_movies$vote_count, df_movies$revenue)

## Regression

models <- tibble(
  int = runif(250, 0, 5),
  slope = runif(250, -5, 5)
)

ggplot(df_movies, aes(budget, vote_count)) + geom_point() +
  geom_smooth(method = "lm")


lm_visits_budget <- lm(vote_count ~ budget, data = df_movies)
summary(lm_visits_budget)

plot(lm_visits_budget)

hist(log(df_movies$vote_count), breaks = 50)
hist(log(df_movies$revenue), breaks = 50)

lm_visits_budget <- df_movies %>%
  filter(budget > 0, vote_count > 0) %>%
  lm(vote_count ~ budget, data = .)

summary(lm_visits_budget)
plot(lm_visits_budget)

res <- data.frame(residual = residuals(lm_visits_budget),
                  observation = 1:length(residuals(lm_visits_budget)))
ggplot(res, aes(observation, residual)) + 
  geom_point() + geom_hline(yintercept = 0)
hist(res$residual, breaks = 25)


head(residuals(lm_visits_budget))

lm_visits_budget <- df_movies %>%
  filter(budget > 0, vote_count > 0) %>%
  lm(vote_count ~ budget, data = .)
summary(lm_visits_budget)


### Little bit more complex data
ggplot(df_facebook_plt, aes(likes, likes_received)) +
  geom_point() + geom_smooth(method="lm") +
  scale_x_continuous(trans = "log10") +
  scale_y_continuous(trans = "log10")

df_facebook <- df_facebook %>%
  filter(likes > 10, likes_received > 10) %>%
  mutate(log_likes = log10(likes),
         log_likes_received = log10(likes_received))

df_facebook_plt <- df_facebook_plt %>%
  filter(likes > 10, likes_received > 10) %>%
  mutate(log_likes = log10(likes),
         log_likes_received = log10(likes_received))

summary(lm(likes_received ~ likes, data = df_facebook))

###
ggplot(df_facebook_plt, aes(likes, likes_received)) +
  geom_point() + geom_smooth(method="lm") +
  coord_fixed(xlim =c(0,50), ylim=c(0,50))


ggplot(df_facebook_plt, aes(log_likes, log_likes_received)) +
  geom_point() + geom_smooth(method="lm")

summary(lm(log_likes_received ~ log_likes, data = df_facebook))

### Logistic regression
log_gender_likes <- glm(factor(gender) ~ likes_received, 
                        data = df_facebook, 
                        family=binomial(link="logit"))

df_facebook_plt %>%
  ggplot(aes(x = log_likes_received, y = 2-as.numeric(factor(gender)))) + 
  geom_point(size = 1.5, position = position_jitter(height = 0.01)) + 
    theme(aspect.ratio = 1) +
    stat_smooth(method="glm", se=FALSE, method.args = list(family=binomial))

summary(log_gender_likes)
log_gender_likes_2 <- glm(factor(gender) ~ likes_received + likes + age, 
                        data = df_facebook, 
                        family=binomial(link="logit"))
summary(log_gender_likes_2)
