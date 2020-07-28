# Homeworks
All homeworks should be uploaded to the following link. Please follow naming structure defined in each task
https://e.pcloud.com/#page=puplink&code=d1ZzC5vUJQuNIXzdeEIN57WcjdYEu0y

## Deadline
Deadline for homeworks submission is 9.8.2020 11:59 CST

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

### Data wrangling

save the code into a file named [yourname]-data-preprocessing.R

**Big5 dataset**
1. Load the big 5 data.
2. Using the text document, recode all numeric variables such as gender and engnat, to meaningul characters (female, male etc.)
3. Calcualte all big five scores and add them to the table (google big 5 for explanation) (Openess = O1-O10, Extraversion = E1-E10, etc ...). BEWARE that odd numbered question (E1, E3) are ADDING value to the score, whereas even numbered (E2, E4 ..) are SUBSTRACTING from the score.
4. To the dataframe, add variables **z_openness**, **z_extraversion** ... for all 5 values, which contain z_scores of those values (you can use the my_normalize function from day 1).
5. Add column age_group which will contain meaningul age_groups of your choosing(e.g. 0-18, 18-25 etc.). Use function `cut` to convert age to a factor)
6. Create a summary table of average Big5 scores for each gender and age group

**Ratings dataset**
Description of the dataset can be found here: http://files.grouplens.org/datasets/movielens/ml-latest-small-README.html
This seems like a small/short task, but requires you to work a bit with dates and you will need to google a little bit. WE haven't talked about this type of conversion.
1. Load the ratings_small.csv dataset
2. Convert timestamps to year, month, day. See the description above

### ggplot

save the code into a file named [yourname]-ggplot-exploration.R. Put all the answers into commens after the code which generated the graph.

Use the big5 dataset from the previous task. You will need all those extra columns (openness, extraversion, neuroticism, age group etc.)
1. Plot a histogram of openess and color it nicely :)
2. Plot a histogram of neuroticism for both genders next to each other. What can you say about the results?
3. Using a suitable plot, investigate scores of agreeableness across different age groups.
4. Using a suitable plot, investigate normalized scores of conscientiousness across 
5. Using a suitable plot, investigate effect of age on normalized extraversion. Separate conveniently per 
6. Using a suitable plot, investigate the effect of english native speaker on the final scores of all five values.
7. Formulate a hypothesis about the data (e.g. men are less agreeable) - use a plot to visualise that hypothesis. Formulate some of your thoughts about the graph.


Load the ratings_small dataset from the previous task. It contains individual ratings of many users.
1. Calculate the average rating of each user and plot the results in a meaningful histogram. What can you tell about the data from looking at it? 
2. Filter out data of users who rated less than 5 movies and plot the histogram again.
3. Calculate the average rating of each movie and plot the results in a meaningful histogram. What can you tell about the data from looking at it?
4. Filter out data of movies who were rated less than 10 times and plot the histogram again. Comment on how it changed and why.
5. Using the year calculated in the previous homework (year of rating), calcualte average ratings of movies in each year. Filter for those years where not that many people voted (your call). 
    5a. Plot a line chart designating evolution of average movie rating in each year.
    5b. Visualise the graph with boxplots instead of a line to see the dispersion in each year. Use varwidth = TRUE
6. Do the same thing as in previous task, but for months. What can you say about the results? Some months seem to be "special"?

## Day 3

## Day 4