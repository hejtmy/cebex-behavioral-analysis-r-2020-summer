#install.packages("ggplot2")
#install.packages("tidyverse")
library(ggplot2)
library(dplyr)

pth_movies <- "data/movies/movies_metadata.csv"
df_movies <- read.csv(pth_movies)
set.seed(666)
df_movies <- df_movies %>%
  sample_n(5000)

hist(df_movies$vote_average, breaks = 25)
plot(df_movies$vote_average, df_movies$revenue)
boxplot(df_movies$vote_average)

## Binding data
plt <- ggplot(df_movies, aes(x = vote_average, y=revenue, fill=adult)) +
  geom_point()

ggplot(data = df_movies, aes(x = vote_average, y=revenue, color=status)) +
  geom_point()

### Binding aesthetics in the geoms
ggplot(df_movie) +
  geom_histogram(aes(vote_average))

## Histograms
ggplot(df_movies, aes(x = vote_average))

ggplot(df_movies, aes(vote_average)) +
  geom_histogram()

ggplot(df_movies, aes(vote_average)) +
  geom_histogram(binwidth = 1)

ggplot(df_movies, aes(vote_average)) +
  geom_histogram(bins = 20)

ggplot(df_movies, aes(vote_average)) +
  geom_histogram(bins = 200)

ggplot(df_movies, aes(vote_average)) +
  geom_histogram(bins = 100)

### DPLYR with GGPLOT
df_movies %>%
  filter(vote_average == 0) %>%
  ggplot(data = ., aes(vote_count)) + geom_histogram(bins = 5)


### Removing outliers
df_movies <- read.csv(pth_movies)
set.seed(666)
df_movies <- df_movies %>%
  #mutate(vote_count = ifelse(vote_count == 0), NA, vote_count) %>%
  select(-c(overview, homepage, belongs_to_collection, production_companies,
            production_countries, tagline, poster_path)) %>%
  filter(vote_count > 10) %>% #removing rows
  mutate(adult = adult == "True",
         budget = as.numeric(budget)/10^6,
         revenue = budget/10^6) %>%
  mutate(is_comedy = grepl("Comedy", genres),
         is_action = grepl("Action", genres),
         is_family = grepl("Family", genres),
         is_drama = grepl("Drama", genres),
         is_thriller = grepl("Thriller", genres)) %>%
  sample_n(5000)

ggplot(df_movies, aes(vote_average)) +
  geom_histogram(bins = 100)

head(df_movies)
ggplot(df_movies, aes(vote_average, after_stat(density), 
                      fill = is_comedy, 
                      color = is_comedy)) +
  #geom_histogram() +
  geom_freqpoly(size=2)

df_movies %>%
  ggplot(aes(runtime, after_stat(density),
                        color = is_family)) +
    geom_freqpoly(size=2)
## Seems there is an error in the runtime
summary(df_movies$runtime)
## Non destructive filtering
df_movies %>%
  filter(runtime < 180) %>%
  ggplot(aes(runtime, after_stat(density),
             color = is_family)) +
  geom_freqpoly(size=2)

