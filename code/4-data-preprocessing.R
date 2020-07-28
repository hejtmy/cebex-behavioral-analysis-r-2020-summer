library(dplyr)
# Tidy data

## Each variable must have its own column
## Each observation must have its own row
## Each value must have its own cell

pth_movies <- "data/movies/movies_metadata.csv"
df_movies <- read.csv(pth_movies)
df_big5 <- read.table("https://github.com/hejtmy/cebex-behavioral-analysis-r-2020-summer/blob/master/data/big5/big5-data.csv?raw=true",
                      nrows = 100, header = TRUE)

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

## in the big5 add:
# engnat = recode as per instruction 1 == yes, 2 == NO, 0 == NO
head(df_big5$engnat)
df_big5 %>%
  mutate(engnat = as.character(engnat)) %>%
  mutate(engnat = recode(engnat, "1"="yes", "2"="no", "0"="missing")) %>%
  mutate(gender = recode(gender, `1`="male", `2`="female", `3`="other", .default ="missed")) %>%
  select(engnat, gender) %>%
  head()

df_big5 <- df_big5 %>%
  mutate(engnat = as.character(engnat)) %>%
  mutate(engnat = recode(engnat, "1"="yes", "2"="no", "0"="missing")) %>%
  mutate(gender = recode(gender, `1`="male", `2`="female", `3`="other", .default ="missed"))


## Factors
head(df_big5$gender)
head(factor(df_big5$gender))

### Factors are numbers with defined levels
factor_gender <- factor(df_big5$gender)
as.numeric(factor_gender)
as.numeric(df_big5$gender)

factor_gender <- factor(df_big5$gender, levels = c("male", "female", "other"))
as.numeric(factor_gender)

## Strings/character
df_movies$genres[1]
df_movies$original_language[1:20]

### Regular expression
### GREP, GREPL

txt <- df_movies$genres[1]
grep("Comedy", txt)

grep("Comeasdasddy", txt)

head(df_movies$genres)
grep("Comedy", head(df_movies$genres))

i_comedy <- grep("Comedy", df_movies$genres)
head(df_movies[i_comedy, ])

### Grepl returns logical vector of a match being present
all(grep("Comedy", head(df_movies$genres)) == which(grepl("Comedy", head(df_movies$genres))))

grepl("Comedy", head(df_movies$genres))

df_movies %>%
  mutate(is_comedy = grepl("Comedy", genres)) %>%
  select(genres, is_comedy, title) %>%
  head()

## Add 5 new columns of 5 different genres 


