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


### 
source('code/data-loading-functions.R')
df_movies <- load_movies_metadata() %>%
  filter(vote_count > 0) %>%
  sample_n(2500)

### MULTIPLE LAYERS
df_movies %>%
  filter(runtime < 180) %>%
  ggplot(aes(runtime)) +
    geom_histogram(aes(y=..density..)) +
    geom_density(size = 1, fill="#fff85d", alpha=1)

### Specific coloring
df_movies %>%
  filter(runtime < 180) %>%
  ggplot(aes(runtime)) +
  geom_histogram(aes(y=..density..), fill="#eaeaee", color="#1e3063") +
  geom_density(size = 1, fill="#1470af", alpha=0.2)

### Competing coloring - works kinda weird
df_movies %>%
  filter(runtime < 180) %>%
  ggplot(aes(runtime, color=is_comedy)) +
  geom_histogram(aes(y=..density..), fill="#eaeaee", color="#1e3063") +
  geom_density(size = 1, fill="#1470af", alpha=0.2)

## Boxplots
ggplot(df_movies, aes(runtime)) + geom_histogram()

df_movies %>%
  filter(runtime < 180) %>%
  ggplot(aes(y=runtime)) + geom_boxplot()

df_movies %>%
  filter(runtime < 180) %>%
  ggplot(aes(y=runtime, color=is_comedy)) + 
    geom_boxplot(varwidth = TRUE)

df_movies %>%
  filter(runtime < 180) %>%
  ggplot(aes(x=is_comedy, y=runtime)) + 
    geom_boxplot() +
    geom_point(color="red") +
    geom_jitter(color="blue", width = 0.2, height = 0)

df_movies %>%
  filter(runtime < 180, runtime > 1) %>%
  ggplot(aes(x=is_comedy, y=runtime)) + 
    geom_boxplot() +
    geom_jitter(color="blue", width = 0.2, height = 0)

### Hiding outliers
df_movies %>%
  filter(runtime < 180, runtime > 1) %>%
  ggplot(aes(x=is_comedy, y=runtime)) + 
  geom_boxplot(outlier.alpha = 0) 

### Hiding outliers
df_movies %>%
  filter(runtime < 180, runtime > 1) %>%
  ggplot(aes(x=is_comedy, y=runtime, color=is_family)) + 
    geom_boxplot(outlier.alpha = 0, varwidth = TRUE)

## Scatter plots
df_movies %>%
  filter(budget > 0) %>%
  ggplot(aes(budget, vote_average)) +
    geom_point()

df_movies %>%
  filter(budget > 0, budget < 500, revenue > 0, revenue < 400) %>%
  ggplot(aes(budget, revenue)) +
    geom_point()
### preprocessing
df_movies_cleaned <- df_movies %>%
  filter(budget > 0, budget < 500, revenue > 0, revenue < 400)

df_movies_cleaned %>%
  ggplot(aes(budget, revenue, color = is_comedy)) +
  geom_point(size=2.5)

df_movies_cleaned %>%
  ggplot(aes(budget, revenue, color = is_comedy, size=is_comedy,
             shape = is_comedy)) +
  geom_point()

## Possible but not recommended- keep it to two features MAX
df_movies_cleaned %>%
  ggplot(aes(budget, revenue, 
             color = is_comedy, 
             size = is_family,
             shape = is_action)) +
  geom_point()

df_movies_cleaned %>%
  ggplot(aes(budget, revenue, 
             color = is_comedy, 
             shape = is_comedy)) +
  geom_point(size = 3) +
  geom_smooth(method = "lm")

df_movies_cleaned %>%
  ggplot(aes(budget, revenue,
             color = is_comedy, 
             shape = is_family)) +
  geom_point(size = 3) +
  geom_smooth(method = "lm")

## Bar charts for categorical data
ggplot(df_movies, aes(vote_average)) +
  geom_histogram(bins = 10)

ggplot(df_movies, aes(is_comedy, fill=is_comedy)) +
  geom_bar()

ggplot(df_movies, aes(status, fill=status)) +
  geom_bar()
table(df_movies$status)

df_movies %>%
  filter(status != "Released") %>%
  ggplot(aes(status, fill=status)) +
   geom_bar()


df_movies %>%
  filter(status != "Released") %>%
  ggplot(aes(status, fill=is_action)) +
  geom_bar(position = "dodge")

df_movies %>%
  ggplot(aes(original_language)) + geom_bar()

# Summative and inferential visualisatons

## Line graphs
x <- 1995:2020
y <- rnorm(length(x))
df_temp <- data.frame(x=x, y=y)
ggplot(df_temp, aes(x=x, y=y)) + geom_point(size = 2)
ggplot(df_temp, aes(x=x, y=y)) + geom_point(aes(color = y>0), size = 2)
ggplot(df_temp, aes(x=x, y=y)) + geom_line(size = 2)

### NOT THIS - connecting elements not ment to be connected
df_movies %>%
  group_by(original_language) %>%
  summarise(mean=mean(vote_average)) %>%
  ggplot(aes(as.numeric(factor(original_language)), mean)) + geom_line()

df_movies <- load_movies_metadata()
df_movies %>%
  filter(revenue > 0, budget > 0) %>%
  group_by(year) %>%
  summarise(average_revenue = mean(revenue),
            sd_revenue = sd(revenue),
            n_movies = n()) %>%
  filter(n_movies > 10) %>%
  ggplot(aes(year, average_revenue)) + geom_line() +
  geom_smooth(method = "lm")


