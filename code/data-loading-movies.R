pth_movies <- "data/movies/movies_metadata.csv"
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
         is_horror = grepl("Horror", generes),
         is_family = grepl("Family", genres),
         is_drama = grepl("Drama", genres),
         is_thriller = grepl("Thriller", genres)) %>%
  sample_n(5000)

