source("code/data-loading-functions.R")
df_movies <- load_movies_metadata(sample = 2500)
df_movies_complete <- load_movies_metadata()

ggplot(df_movies, aes(vote_average, runtime)) +
  geom_point()  

df_movies %>%
  filter(vote_average > 0, runtime > 0, vote_count > 10) %>%
  ggplot(aes(vote_average, runtime)) +
  geom_point()  

# when analysis voting averages, remove all values which have vote count less than 10

## Scaling
df_movies %>%
  filter(vote_average > 0, runtime > 0, revenue > 0, vote_count > 10) %>%
  ggplot(aes(vote_average)) +
    geom_point(aes(y=runtime), color="blue") +
    geom_point(aes(y=revenue), color="red")

df_movies %>%
  filter(vote_average > 0, runtime > 0, revenue > 0, vote_count > 10) %>%
  mutate(z_runtime = scale(runtime), z_revenue = scale(revenue)) %>%
  filter(abs(z_revenue) < 3, abs(z_runtime) < 3) %>%
  ggplot() + 
    geom_histogram(aes(z_runtime), fill="blue") +
    geom_histogram(aes(z_revenue), fill="green", alpha=0.4)
    #geom_histogram(aes(x=runtime), fill="red")

df_movies %>%
  filter(vote_average > 0, runtime > 0, budget > 0, vote_count > 10) %>%
  mutate(z_runtime = scale(runtime), z_budget = scale(budget)) %>%
  filter(abs(budget) < 3, abs(z_runtime) < 3) %>%
  ggplot(aes(y=vote_average)) + 
    geom_point(aes(z_runtime), color="blue") +
    geom_point(aes(z_budget), color="green")


## Labels
plt_year_revenue <- df_movies_complete %>%
  filter(revenue > 0, budget > 0) %>%
  group_by(year) %>%
  summarise(average_revenue = mean(revenue),
            sd_revenue = sd(revenue),
            n_movies = n()) %>%
  filter(n_movies > 10) %>%
  ggplot(aes(year, average_revenue)) +
    geom_line() +
    geom_smooth(method = "lm")

plt_year_revenue +
  labs(x="Release Year",
       y="Average movie revenue",
       title="Average movie revenues per year",
       caption="With fitted linear regression")

plt_year_revenue +
  ylab("Average movie revenue") +
  xlab("Movie Release year") +
  ggtitle("Average movie revenue per year", subtitle = "With fitted linear regression")


plt_year_revenue <- df_movies_complete %>%
  filter(revenue > 0, budget > 0) %>%
  group_by(year) %>%
  summarise(average_revenue = mean(revenue),
            sd_revenue = sd(revenue),
            n_movies = n()) %>%
  ggplot(aes(year, average_revenue)) +
    geom_line() +
    geom_smooth(method = "lm") +
    geom_point(aes(color = n_movies > 10, size = as.numeric(n_movies > 10)))

plt_year_revenue +
  labs(y = "Average movie revenue", 
       color = "More than 10 movies came out",
       size = "More than 10 movies came out")

## Chaning guides
plt_year_revenue +
  guides(size = FALSE)

plt_year_revenue +
  scale_color_discrete(name = "More than 10 movies") +
  scale_size(name = "More than 10 movies", 
             breaks = c(0,1), labels = c("True", "False"))

## Adding errorbars
df_movies_complete %>%
  filter(revenue > 0, budget > 0) %>%
  group_by(year) %>%
  summarise(average_revenue = mean(revenue),
            sd_revenue = sd(revenue),
            n_movies = n()) %>%
  filter(n_movies > 10) %>%
  ggplot(aes(year)) +
    geom_line(aes(y=average_revenue)) +
    geom_errorbar(aes(ymin=average_revenue-sd_revenue,
                      ymax=average_revenue+sd_revenue))

plt_year_revenue <- df_movies_complete %>%
  filter(revenue > 0, budget > 0) %>%
  group_by(year) %>%
  summarise(average_revenue = mean(revenue),
            sd_revenue = sd(revenue),
            n_movies = n(),
            se_revenue = sd_revenue/sqrt(n_movies),
            ci_revenue = ........) %>%
  filter(n_movies > 10) %>%
  ggplot(aes(year)) +
  geom_line(aes(y=average_revenue)) +
  geom_errorbar(aes(ymin=average_revenue-se_revenue,
                    ymax=average_revenue+se_revenue))

plt_year_revenue + 
  labs(x="Release Year",
       y="Average movie revenue",
       title="Average movie revenues per year",
       subtitle ="Errorbars represent standard error of the mean")

## Theming

## Faceting

## Multiple plots


