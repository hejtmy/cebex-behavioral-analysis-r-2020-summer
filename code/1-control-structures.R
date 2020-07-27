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
for(column in ggplot2::mpg){
  print(mean(column))
}

