# Control structures

## If
IQ <- 130
IQ <- 115

if(IQ > 125){
  print("GOOD FOR YOU!")
  warning("TOO HIGH")
}

if(IQ > 125){
  print("GOOD FOR YOU!")
} else {
  print("DO BETTER")
}

if(IQ      > 125){print("GOOD FOR YOU")}

### One line if
if(IQ > 125) print("GOOD FOR YOU")

### Assignments
extraversion <- 70
is_extravert <- extraversion >= 80

characteristic <- NA
if(extraversion >= 80){
  characteristic <- "extravert"
} else {
  characteristic <- "something else"
}

print(characteristic)


### ifelse
?ifelse
characteristic <- ifelse(extraversion >= 80, "extravert", "something else")


### file.exists()
"data/world-happinness/individual-years/2015.csv"
happiness_dir <- file.path("data", "world-happiness", "individual-years")

if(file.exists(file.path(happiness_dir, "2015.csv"))){
  df_happiness <- read.table()
} else {
  warning("The file is not there")
}


## For
for(i in 1:5){
  print(i)
  
}

names <- c("Lukas", "Mina Harker", "Dracula")
for(name in names){
  name
}

for(i in 1:length(names)){
  print(paste(names[i], " is at a position ", i))
}


### Outputing values in loops
for(i in 1:5){
  print(mean(i:100))
}


### looping through other elements
person <- list(name = "Lukas", age = 30, is_smoking = FALSE)
as.data.frame(person)

for(field in person){
  print(field)
}

for(column in iris){
  print(column[1:5])
}

str(iris)
for(column in iris[,1:4]){
  print(mean(column))
}


### next
n_runs <- 0
for(i in 1:100){
  n_runs <- n_runs + 1
  if(i > 5) next
  print(i)
}

### Change is so it skips non numeric columns
str(ggplot2::mpg)
for(column in ggplot2::mpg){
  if(is.numeric(column)){
    print(mean(column))
  }
}

for(column in ggplot2::mpg){
  print(class(column))
  if(!is.numeric(column)) next
  if(is.na(column)) next
  if(is.na(column)) next
  print(mean(column))
}

### break
for(i in 1:10){
  print(sample(1:10, 1))
}

?rnorm
set.seed(666)

n_obs <- 0
for(i in 1:1000){
  if(mean(rnorm(100, 100, 15)) > 103){
    n_obs <- n_obs + 1
    print("GOT IT")
  }
}

n_obs <- 0
for(i in 1:1000){
  if(mean(rnorm(100, 100, 15)) > 103){
    n_obs <- n_obs + 1
    print("GOT IT")
    break
  }
}

### while
i <- 0
while(i <= 5){
  print(i)
  i <- i + 1
}

i <- 0
while(TRUE){
  print(i)
  i <- i + 1
  if(i > 5) break
}

### BETTER TO RUN FOR LOOP 1000000 TIMES THAN WHILE

## Custom functions
set.seed(666)
x <- rnorm(100, 10, 1)
mean(x)
sd(x)
median(x)

x2 <- rnorm(100, 10, 1)
mean(x2)
sd(x2)
median(x2)

x3 <- rnorm(100, 10, 1)
mean(x3)
sd(x3)
median(x3)

mean_sd_median <- function(x){
  mean <- mean(x)
  sd <- sd(x)
  median <- median(x)
  return(c(mean, sd, median))
}

mean_sd_median(x)

rnorm_decriptives <- function(){
  x <- rnorm(100, 10, 1)
  mean <- mean(x)
  sd <- sd(x)
  median <- median(x)
  return(c(mean, sd, median))
}

rnorm_decriptives()

rnorm_decriptives <- function(n = 100, mu = 0, sd = 1){
  x <- rnorm(n, mu, sd)
  results <- mean_sd_median(x)
  return(results)
}

rnorm_decriptives(n = 1000, mu = 100, sd = 10)

## apply, sapply, lapply

mat <- matrix(rep(c(1,2,3,4), 4), ncol=4)
mat

apply(mat, 1, mean)
apply(mat, 2, mean)

person1 <- list(name="Lukas", age=30)
person2 <- list(name="Martin", age=26)
people <- list(person1, person2)

lapply(people, nchar)
sapply(people, nchar)


for(column in iris){
  print(mean(column))
}
sapply(iris, mean)

sapply(iris, function(x){is.numeric(x)})
sapply(iris, function(x){if(is.numeric(x)) mean(x)})
