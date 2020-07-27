# Homeworks
All homeworks should be uploaded to the following link. Please follow naming structure defined in each task
https://e.pcloud.com/#page=puplink&code=d1ZzC5vUJQuNIXzdeEIN57WcjdYEu0y


## Day 1

### Loops and fors
Save the code into a file named [yourname]-looping.R

Set the seed to 2020. Start randomizing default normal distributions (mu=0,sd=1) of 100 values. When the randomized distribution has the mean more than 0.2 away from 0 (> 0.2 or < -0.2), stop randomizing, print the number of iterations you had to do and plot the histogram of the final distribution.

Set the seed to 2020. Using loops, randomize 1000 sets of two normal distributions of 100 values with mu=0, sd=1 and count how many times the means of those distributions differed from each other by more than 0.3. Output that value.

### Functions

save the code into a file named [yourname]-function.R

Write a function which normalizes (creates z-scores) of values in passed vector (https://www.statisticshowto.com/probability-and-statistics/z-score/)

The function takes a numeric vector to normalize, and optionally mu value and sd value to normalize the vector around - if either of them is empty, then the vector mean and sd are used. The function should return warning and NULL if the passed vector is not numeric or if any of the arguments are non valid (e.g. mu=NA)

```
my_normalize_function <- function(x, mu=NULL, sd=NULL){
  Your code
}

my_normalize_function(1:5)
-1.2649111 -0.6324555  0.0000000  0.6324555  1.2649111
my_normalize_function(c(-1,0,1))
-1 0 1
my_normalize_function(c(-1,0,1), mu = 1)
 -2 -1  0
my_normalize_function(c(-1,0,1), sd = 10)
 -0.1  0.0  0.1
```

### Data loading
save the code into a file named [yourname]-loading.R

In the data folder, you can find loading examples folder and in it 9 files. Write script which loads the files from their urls. The person running the script should not have to download anything, all files should be loaded directly from the web. You don't have to use loop, just one line of code for each table being loaded. You might need to install some package to deal with the xlsx file.

Data are here: https://github.com/hejtmy/cebex-behavioral-analysis-r-2020-summer/tree/master/data/loading-examples

### Dplyr 
save the code into a file named [yourname]-dplyr.R

Load the world happiness data at https://github.com/hejtmy/cebex-behavioral-analysis-r-2020-summer/blob/master/data/world-happinness/world-happiness.csv. Using dplyr and piping syntax, do the following tasks. Each one should be one "pipe"

1. Filter for year 2019 and show first 10 countries with highest corruption.
2. Group by year and calculate average GDP
3. Filter countries who have above average social support and health for year 2018, and arrange per their score and corruption.
4. Calculate average rank for each country (average for years 2015-2019)
5. What is the average corruption for countries which rank in the top 20 countries vs the rest? Calculate for each year separately

using the ggplot2::mpg dataset (investigate using `str()` and see description with `?mpg`) and using dplyr and piping syntax, do the following tasks. Each one should be one "pipe"
1. Calculate the average city miles per gallon for vehicle type and arrange from highest to lowest.
2. Calculate the average highway miles per gallon and city miles per gallon in years 1999 and 2008.
3. Calculate the average city miles per gallon for different cylinder numbers.
4. What is the average cylinder number for various types of transmissions?
5. Calculate the average displacement for each vehicle type and arrange from lowest.

## Day 2

## Day 3

## Day 4