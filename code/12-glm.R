library(ggplot2)
library(dplyr)
library(tidyr)
source("code/data-loading-functions.R")
df_movies <- load_movies_metadata(2500)
df_movies_complete <- load_movies_metadata()

## Analysis of variance
set.seed(666)
df_example <- data.frame(mozart = rnorm(100,100,5), bach = rnorm(100,110,5),
                         haydn = rnorm(100,112,5), beethowen = rnorm(100,150,5))

df_example %>% # all groups together
  pivot_longer(cols = everything()) %>%
  mutate(avg=mean(value)) %>%
  ggplot(aes(x=1, y = value)) + 
  geom_point(position = position_jitter(0.2)) +
  geom_errorbar(aes(ymax=avg, ymin=avg)) +
  theme(aspect.ratio = 1)

df_example %>% #groups separated
  pivot_longer(cols = everything()) %>%
  group_by(name) %>%
  mutate(avg=mean(value)) %>%
  ungroup() %>%
  ggplot(aes(x = name, y = value, color=value)) + 
  geom_point(position = position_jitter(0.2)) +
  geom_errorbar(aes(ymax=avg, ymin=avg)) +
  theme(aspect.ratio = 1)

df_musicians <- df_example %>%
  pivot_longer(cols = everything(), names_to="musician", values_to="score")
aov_score_musician <- aov(score ~ musician, data=df_musicians)
summary(aov_score_musician)

### Post-hoc test
TukeyHSD(aov_score_musician)
t.test(df_example$haydn, df_example$bach)


### Multiple predictors
aov_revenue_language <- df_movies %>%
  filter(original_language %in% c("en", "fr", "de"), revenue > 0) %>%
  mutate(revenue = log10(revenue)) %>%
  with(aov(revenue ~ original_language, data=.))

summary(aov_revenue_language)
TukeyHSD(aov_revenue_language)

lm_revenue_budget_language <- df_movies %>%
  filter(original_language %in% c("en", "fr", "de"), revenue > 0) %>%
  mutate(revenue = log10(revenue)) %>%
  #with(lm(revenue ~ 0 + budget + original_language, data = . ))
  with(lm(revenue ~ budget + original_language, data = . ))

summary(lm_revenue_budget_language)

lm_revenue_budget_language <- df_movies %>%
  filter(original_language %in% c("en", "fr", "de"), revenue > 0) %>%
  mutate(revenue = log10(revenue)) %>%
  with(lm(revenue ~ budget + original_language + budget:original_language, data = . ))
  #with(lm(revenue ~ budget*original_language, data = . )) # exactly the same as previous line

summary(lm_revenue_budget_language)
