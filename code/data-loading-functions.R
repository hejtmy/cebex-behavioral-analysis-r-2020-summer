load_movies_metadata <- function(sample = NULL){
  pth_movies <- "data/movies/movies_metadata.csv"
  df_movies <- read.csv(pth_movies)
  set.seed(666)
  df_movies <- df_movies %>%
    #mutate(vote_count = ifelse(vote_count == 0), NA, vote_count) %>%
    select(-c(overview, homepage, belongs_to_collection, production_companies,
              production_countries, tagline, poster_path)) %>%
    mutate(adult = adult == "True",
           budget = as.numeric(budget)/10^6,
           revenue = revenue/10^6) %>%
    mutate(is_comedy = grepl("Comedy", genres),
           is_action = grepl("Action", genres),
           is_horror = grepl("Horror", genres),
           is_family = grepl("Family", genres),
           is_drama = grepl("Drama", genres),
           is_thriller = grepl("Thriller", genres))
  if(is.numeric(sample)){
    df_movies <- sample_n(df_movies, sample)
  }
  return(df_movies)
}
