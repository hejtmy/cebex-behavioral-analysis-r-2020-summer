library(car)
library(ggplot2)
library(dplyr)
library(tidyr)
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

ggplot(faithful, aes(x=eruptions)) +
  geom_histogram()
shapiro.test(faithful$eruptions)

ggplot(faithful, aes(x=waiting)) +
  geom_histogram()

faithful %>%
  filter(waiting > 70) %>%
  ggplot(aes(x=eruptions)) + geom_histogram()

shapiro.test(faithful$eruptions[faithful$waiting > 68])

qqnorm(faithful$eruptions)
qqline(faithful$eruptions)


df_movies_cleaned %>%
  ggplot(aes(x=vote_average, fill=is_comedy)) +
    geom_histogram()

### Homogenity of variances
set.seed(666)
df_example <- data.frame(cond1 = rnorm(100,100,5), cond2 = rnorm(100,110,5),
                         cond3 = rnorm(100,112,5), cond4 = rnorm(100,150,5))
df_example <- data.frame(cond1 = rnorm(100,100,1), cond2 = rnorm(100,110,5),
                         cond3 = rnorm(100,112,10), cond4 = rnorm(100,150,20))

df_example %>%
  pivot_longer(cols = everything()) %>%
  group_by(name) %>%
  mutate(avg=mean(value)) %>%
  ungroup() %>%
  ggplot(aes(x = name, y = value, color=value)) + 
    geom_point(position = position_jitter(0.2)) +
    geom_errorbar(aes(ymax=avg, ymin=avg)) +
    theme(aspect.ratio = 1)


set.seed(666)
df_example <- data.frame(x = 1:100, y=1:100+rnorm(100))
df_example <- data.frame(x = 1:100, y=1:100+rnorm(100)*exp(seq(0,3,length.out = 100)))
df_example %>%
  ggplot(aes(x,y)) +
  geom_point() + geom_smooth(method = "lm")

dplyr::recode # BEWARE OF RECODE

df_example %>%
  pivot_longer(cols = everything(), names_to="condition") %>%
  with(leveneTest(value, condition))

df_example %>%
  select(cond2, cond3) %>%
  pivot_longer(cols = everything(), names_to="condition") %>%
  with(leveneTest(value, condition))

df_example %>%
  pivot_longer(cols = everything(), names_to="condition") %>%
  head()
