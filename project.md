# Project description

As a part of your exmination, you are required to submit a data project by the end of August 2020. The project should demostrate your ability to work with data in R, make meaningful visualisations and make inference about the data.

*Submission*
You will submit the project as a completely functioning R code or R notebook (https://blog.rstudio.com/2016/10/05/r-notebooks/, https://rmarkdown.rstudio.com/lesson-10.html). If you submit R file, comment on each of your discoveries using comments

Example of how the code with comments would look.

```{r}
hist(df_movies$vote_average, breaks=25)
# Looking at the data, we can deduce that there are too many 0 votes, which might be a mistake. We can filter them out
df_movies <- df_movies[df_movies$vote_average > 0, ]
hist(df_movies$vote_average, breaks=25)
# The data looks much better after removing the 0 values
```

## General rules about the project

1. *All the code shoudl be your own*: You can naturally search for help, even ask for help online, but you shouldn't be just coping bits and pieces of code from some other assignment. It is fine to copy and modify a code which makes a histogram, it is not fine to copy 50 lines of code which you found online and only changed your variable names. This often becomes aparent, as people usually don't even modify the variables of interest, don't recode values, don't filter outliers properly etc. Please, if you need to copy, copy relevant individual pieces (how to do linear regression, how to investigate qqplots), not entire blocks.
2. *The submited code should be reproducible*: When you submit your code, I should be able to run it on my PC. It should load all necessary packages and if the data is not loaded from the web, you need to send me the data as well and provide proper relative paths (the paths should be "data/movies.csv", not "F:/users/Amanda/Downloads/movies.csv"). Basically zip the entire folder with code and data in. If I cannot run the code, I will not accept it. Make sure the code runs by testing it on a different PC, or asking a friend to run it first.
3. *Extra Information*: If there is something else I have to know to run the code (install packages from github, run it on specific R version, let me know)
4. *Code style*: All the code should be abiding by the R code style https://style.tidyverse.org/

## Get the data
The first step is actually obtaining some interesting ane meaningful dataset. There are many sources which you can search, here is just a few to name:

- https://www.kaggle.com/
- https://datasetsearch.research.google.com/
- https://docs.google.com/spreadsheets/d/1ejOJTNTL5ApCuGTUciV0REEEAqvhI2Rd2FCoj7afops/edit#gid=0
- https://osf.io/th8ew/

The data should be something new, something interesting for you and potentionaly for me :) But mainly for you.

Here are some rules about the data:
1. You cannot use any dataset which comes with a particular package - this is because a lot of R code has been written on those datasets and I couldn't check if you didn't just copy the code from there.
2. The data should have good amount of information, say at least 10 variables and 50+ observations. You cannot make really meaningful explorations on small datasets
3. Make sure your data has all types of variables - continuous, categorical and binary. You shoudl be able to analyse the data using regression, anova and t-tests.

## Preprocess the data

1. *Change types*: Recode all the variables so that they have proper types - 1, 0 or "yes", "no" to logical; numbers shoudl be numbers, not characters.
2. *Recode*: Recode the data to meaningul values - "male" "female" shoudl not be 1 and 0; "en" should be "English", etc.
3. *Tidy data*: Recode the data into tidy format - each value has their own cell. For example: "1999-10-01" should be converted to three values year, month, day; 3-1 to goals_scored, goals_received etc.
4. *Duplicates*: Check that the data doesn't contain any duplicates
5. *Missing values*: Mark missing values properly. E.g. movies making 0 money, football matches which scores 999 goals etc.
6. *Mutate*: Mutate values to be more meaningful - e.g. budgets in milions of dollars ranther than in dollars. 
7. *Create*: Create new variables - e.g.profit = revenue-budget, is_comedy, 
8. *Normalize/scale*: Normalize some data if they need to be normalized. Create new variables rather than override the old.
9. *Rename*: Rename columns/variables to be meaningful. e.g. budget instead of bg, goals_per_year rather than gpy etc.

## Explore the data

Using meaningful visualisations, explore the data of interest. Comment on all findings and what you plan to do about it - e.g. `#looking at the histogram we observe something weird about few outliers in the top right cornes. I might remove the data so it won't affect the regression`

1. Use *histograms* to check for normality and outliers.
2. Use *pairs/geom_points()* to investigate relationships between 
3. Use *geom bars* to investigate "counts"
4. Use *boxplots* to explore for differences in different groups

## Formulate hypotheses

Using the outcomes of data exploration, formulate and state some hypotheses about your data. You should formualte and have *at least 5 hypotheses*.

Modify the data so that you can test for those hypotheses - creating new variables which you might have forgotten about or which arose during your thinking process

## Inferential statistics

Test for the hypotheses defined in the previous step using appropriate statistical test. 

Remember to:
- check for normality and homogenity of variances, if necessary. 
- deal with outliers appropriately. Faulty data should NOT be used in statistical inference. Remember that outliers might heavily influence results of your tests (e.g. shift regressions in unwanted directions, shift group means etc.)

I expect you to use at each of the following tests at least once:

1. t-test/wilcox.test
2. anova
3. linear regression

## Visualise results

Create graphs which meaningfully convey the results. These graphs are different from exploratory graphs, as are they usually summative, filtered for erroneous values and goal oriented. These graphs should be clean, self explanatory and well documented.

This might require you to sumamrise and transform your data (e.g. calculate group means, group errors etc.) to do that.

Remember to plot data which was preprocessed in the same way as the data used for analyses - graphs should represent the data which was used to achive those results.

*Graphs should be self explanatory!* Remember to:
a) Choose appropriate graph for the type of data you want to convey.
b) Label all axes properly
c) Name all guides and legends properly. the graphs should not have information such as "en", "mfe".
d) Add information about any unclear elements (what are error bars representing? confidence intervals, sds, ses etc.)
e) For bonus points, make those graphs nice :) Select your own colors etc.