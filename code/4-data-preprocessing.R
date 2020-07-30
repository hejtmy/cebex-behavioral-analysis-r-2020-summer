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

### gsub
df_movies$imdb_id[1:5]
gsub("tt", "", df_movies$imdb_id[1:5])
df_movies$genres[1]
res <- gsub("\\[\\{'id'\\: ", "", df_movies$genres[1])
res <- gsub(", 'name'\\: ", "", res)

## paste
#"hello" + "world"
paste("hello", "world")
paste("hello", "world", sep="-")
paste("hello", "world", "!", sep=" is this happening? ")
paste("hello", "world", collapse="!")
paste(c("hello", "world"), collapse="!")
paste(c("hello", "world"), c("hello", "world"), sep="-", collapse="!")

df_movies %>%
  mutate(bud_rev = paste(budget, revenue, sep="-")) %>%
  select(bud_rev) %>%
  head()

df_movies %>%
  mutate(action_com = paste(is_comedy, is_action, sep="-")) %>%
  select(action_com) %>%
  head()

## Separate
library(tidyr)
?separate
df_movies %>%
  separate(release_date, c("year", "month", "day"), sep="-") %>%
  head()

df_temp <- data.frame(question = c("E1", "E2", "E3", "C1", "C2", "C3"),
                      answer = sample(1:10, 6, replace=TRUE))
df_temp <- rbind(df_temp, df_temp)
df_temp

df_temp <- df_temp %>%
  separate(question, c("type", "number"), sep=1)
df_temp %>%
  ggplot(aes(answer, fill=type)) + geom_bar(position="dodge")

## Unite (oposite of separate)
df_temp %>%
  unite(type_number, "type", "number")

## Aggregations
aggregate(df_movies$budget, by=list(rep(1, 2500)), mean)
aggregate(df_movies$budget, by=list(year=df_movies$year), mean)

df_movies %>%
  group_by(year) %>%
  summarise(average_budget= mean(budget))

df_movies %>%
  group_by(month, is_family) %>%
  summarise(average_revenue = mean(revenue), n_movies = n()) %>%
  filter(month %in% c(7,8,12))


## Data reshaping
df_example <- data.frame(cond1 = rnorm(100,100,5), cond2 = rnorm(100,110,5),
                         cond3 = rnorm(100,112,5), cond4 = rnorm(100,150,5))
head(df_example)

library(tidyr)
## pivot_longer (gather)
df_example %>%
  select(cond1) %>%
  pivot_longer(cols = c("cond1"), names_to="condition")

df_example %>%
  pivot_longer(cols = c("cond1", "cond2", "cond3", "cond4"), 
               names_to="condition")

df_example %>%
  pivot_longer(cols = c("cond1", "cond2", "cond3", "cond4"), 
               names_to="condition") %>%
  ggplot(aes(value, fill=condition)) + geom_boxplot()

head(df_example)

## pivot_wider (spread)
