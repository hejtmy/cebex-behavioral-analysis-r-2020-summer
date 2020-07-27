# Getting the files

## Loading tables from the web
countries_url <- "https://raw.githubusercontent.com/hejtmy/cebex-behavioral-analysis-r-2020-summer/master/data/world-happinness/world-happiness-country-regions.csv"
countries <- read.table(countries_url, sep=",", header = TRUE)

## download.file
download.file(countries_url, "countries-regions.csv")
getwd()

download.file("https://github.com/hejtmy/cebex-behavioral-analysis-r-2020-summer/blob/master/data/movies/movies_metadata.csv?raw=true",
             "movies_metadata.csv")

# LARGE DATA
## readLines

pth_movies <- "data/movies/movies_metadata.csv"
readLines(pth_movies, n = 10)

## Set the nrows
df_movies <- read.table(pth_movies, sep=",", nrows = 1000, header = TRUE)
df_movies <- read.table(pth_movies, sep=",", nrows = 1000,
                        header = TRUE, fill = TRUE, quote = "\"")
df_movies <- read.csv(pth_movies, sep=",", nrows = 100)

?read.csv
df_movies[4:7, 1:5]
df_movies <- read.csv(pth_movies, nrows = 1000)

format(object.size(df_movies), units = "auto")

## Setting columns beforehand

df_countries <- read.csv(file.path("data", "world-happinness", "world-happiness-country-regions.csv"),
                         colClasses = c("character", "character"))

df_movies <- read.csv(pth_movies, nrows = 1000)
classes <- sapply(df_movies, class)
df_movies <- read.csv(pth_movies, colClasses = classes)
df_movies <- read.csv(pth_movies)


## for loop loading
pth_years <- file.path("data", "world-happinness", "individual-years")
years_files <- list.files(pth_years, full.names = TRUE)

years <- list()
for(file in years_files){
  print(file)
  if(file.exists(file)){
    years[[basename(file)]] <- read.csv(file)
  }
}

list.files(file.path("data", "world-happinness"), full.names = TRUE, recursive = TRUE)

list.files(file.path("data", "world-happinness"), full.names = TRUE, pattern = "*.csv")

## OTHER DATA TYPES
### JSON
#install.packages("jsonlite")
library(jsonlite)
reviews <- fromJSON("https://raw.githubusercontent.com/hejtmy/cebex-behavioral-analysis-r-2020-summer/master/data/data-formats/reviews.json")
dplyr::glimpse(reviews$paper)
reviews$paper$review[1]

### XML
install.packages("xml2")
library(xml2)
u_wingspan <- "https://api.geekdo.com/xmlapi2/thing?id=266192"
download.file(u_wingspan, "wingspan.xml")
out <- read_xml("wingspan.xml")
out$node
xml_children(out)
