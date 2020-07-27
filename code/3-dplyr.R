library(dplyr)

pth_movies <- "data/movies/movies_metadata.csv"
df_movies <- read.csv(pth_movies, nrows = 1000)
pth_ratings <- "data/movies/ratings_small.csv"
df_ratings <- read.csv(pth_ratings, nrows = 1000)

glimpse(df_movies)
str(df_movies)

## select
df_movies[, 1]
df_movies[, "adult"]
df_movies[["adult"]]
df_movies$adult
df_movies[, 1:5]

df_movies[, c("vote_count", "vote_average", "revenue", "budget")]

head(select(df_movies, "vote_count", "revenue", "budget", "vote_average"))
head(select(df_movies, vote_average, vote_count, revenue, budget))
select(df_movies, 1, vote_average)
select(df_movies, 1:2)
head(select(df_movies, adult:budget))
head(select(df_movies, 1:budget))

### minus notation
#df_ratings$timestamp <- NULL

head(select(df_ratings, -timestamp))
head(select(df_ratings, -(rating:timestamp)))

### renaming
glimpse(df_movies)
head(select(df_movies, contains_nudity = adult, status:vote_count ))

### Helpers
head(iris)
head(select(iris, starts_with("Sepal")))

readLines("data/big5/big5-data.csv", 2)
head(select(iris, -starts_with("Sepal")))

df_big5 <- read.table("https://github.com/hejtmy/cebex-behavioral-analysis-r-2020-summer/blob/master/data/big5/big5-data.csv?raw=true",
                      nrows = 100, header = TRUE)
glimpse(df_big5)
head(select(df_big5, starts_with("E", ignore.case = FALSE)))

## Select all conscientiousness questions (START with C)
head(select(df_big5, starts_with("C", ignore.case = FALSE)))
## Select all first questions
select(df_big5, ....) # ends with 
## Select all E questions between 1-5
select(df_big5, ....) # num_range


## filter

df_movies[df_movies$budget > 0 & df_movies$revenue > 0, ]

filter(df_movies, budget > 0, revenue > 0)
filter(df_movies, budget > 0 | revenue > 0)

# df_movies <- filter(df_movies, budget > 0, revenue > 0)


filter(df_movies, revenue > mean(revenue))

### sample of filter
select(filter(df_movies, revenue > quantile(revenue, 0.9)), title)


### sample_n
df_movies[sample(1:nrow(df_movies), 1), ]
sample_n(df_movies, 1)


## mutate
head(df_movies[,1])
df_movies$adult <- df_movies$adult == "True"
df_movies$profitability <- df_movies$revenue - df_movies$budget
df_movies$valid <- df_movies$budget > 0 & df_movies$revenue > 0

head(mutate(df_movies, 
       adult = adult == "True",
       profitability = revenue - budget,
       valid = budget > 0 & revenue > 0))
head(df_movies)
df_movies <- mutate(df_movies, 
       adult = adult == "True",
       profitability = revenue - budget,
       valid = budget > 0 & revenue > 0)

## with, attach - not recommended


## in the big5 add:
# Extraversion = sum of all Es
# df_movies <- mutate(df_big5, Extraversion = E1 + E2 + E3 + E4 + E5 ....)
# engnat = recode as per instruction 1 == yes, 2 == NO, 0 == NO
mutate(df_big5, ifelse(engnat == 1), "yes", "no")
recode(df_big5$engnat, `1`="yes", `2`="no", `0`=NA)
# new variable is_old
mutate(df_big5, is_old = age > 65)
# filter out all people from the US (there shoudl be no US people in the final dataset)


## arrange
head(df_movies[order(df_movies$revenue, decreasing = TRUE), "title"])
head(arrange(df_movies, -revenue, runtime))

## summarise
### Creating new summary table
summarise(df_movies, mean_budget=mean(budget), 
          mean_revenue=mean(revenue))

## PIPING

df_movies %>% head(2)

x <- df_movies$budge
x <- mean(x)
x <- log(x)

df_movies$budget %>% mean() %>% log()
## imaginary variable .
#' . <- df_movies$budge
#' . <- mean(.)
#' . <- log(.)
df_movies$budget %>% mean(.) %>% log(.)

df_movies %>%
  filter(budget > 0) %>%
  arrange(-revenue) %>%
  select(title) %>%
  head(10)

df_movies %>%
  filter(budget > 0, revenue > 0) %>%
  mutate(profit = revenue - budget) %>%
  summarise(mean(profit)/10^6)

## group_by

df_movies %>%
  filter(budget > 0, revenue > 0) %>%
  mutate(profit = revenue - budget) %>%
  group_by(good_movie = vote_average > 7) %>%
  summarise(profits = mean(profit)/10^6)

df_movies %>%
## Filter out budget and revenue > 0
  filter(budget > 0, revenue > 0) %>%
## minimum number of votes is quantile 20 and max is top 80 percent
  filter(vote_count > quantile(vote_count, 0.1),
         vote_count < quantile(vote_count, 0.9)) %>%
## group the results by average vote being larger than average
  group_by(above_average_movie = vote_average > mean(vote_average)) %>%
## figure out the average budget and average revenue
  summarise(average_budget = mean(budget)/10^6, 
            average_revenue = mean(revenue)/10^6)
