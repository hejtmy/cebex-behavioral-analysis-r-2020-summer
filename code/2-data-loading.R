# Getting the files

## Loading tables from the web
countries_url <- "https://raw.githubusercontent.com/hejtmy/cebex-behavioral-analysis-r-2020-summer/master/data/world-happinness/world-happiness-country-regions.csv"
countries <- read.table(countries_url, sep=",", header = TRUE)

## download.file
download.file(countries_url, "countries-regions.csv")
getwd()

download.file("https://github.com/hejtmy/cebex-behavioral-analysis-r-2020-summer/blob/master/data/movies/movies_metadata.csv?raw=true",
              "movies_metadata.csv")

## readLines

readLines("movies_metadata.csv",n = 10)

df_movies <- read.table("movies_metadata.csv", sep=",", nrows = 100, header = TRUE)
df_movies <- read.table("movies_metadata.csv", sep=",", nrows = 100, 
                        header = TRUE, fill = TRUE)
df_movies[4:7, ]
