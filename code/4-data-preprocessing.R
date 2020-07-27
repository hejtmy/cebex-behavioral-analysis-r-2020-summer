library(dplyr)
# Tidy data
## Each variable must have its own column
## Each observation must have its own row
## Each value must have its own cell

pth_movies <- "data/movies/movies_metadata.csv"
df_movies <- read.csv(pth_movies)

## variable should have meaningful names
## variable should have meaningful types
## only meaninful variables are kept

df_movies <- df_movies %>%
  mutate(adult = adult == "True",
         budget = as.numeric(budget)/10^6,
         revenue = budget/10^6)

df_movies <- df_movies %>%
  select(-c(overview, homepage, belongs_to_collection, production_companies,
           production_countries, tagline, poster_path))


format(object.size(df_movies), units = "auto")
table(df_movies$status)
table(df_movies$original_language)

## Recoding
recode(df_movies$original_language, "en" = "English", "jp" = "Japanese",
       "de" = "German", "fr"="French", "es"="English", "eu"="English", 
       "uk"="English") %>%
  table()


"f" = "female" = 1
"m" = "male" = 2
"o" = "other" = 3

## Factors


## Strings
df_movies$genres[1]
