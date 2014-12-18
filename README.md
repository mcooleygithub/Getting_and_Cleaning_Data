# Getting and Cleaning Data Course Project
This project was accomplished by me, Michael Cooley, for my Coursera **_Getting and Cleaning Data_** course between December 1, 2014 and December 20, 2014.
## Assignment
The assignment for the Getting and Cleaning Data course project is to take a dataset, combine and subset some of that data, and then produce a tidy dataset showing some summary calculations of several variables.  A GitHub repository is to be created, complete with a ReadMe file describing the process of transforming the data and a CodeBook describing the tidy data set.  The tidy data set is also to be saved in the repository.
## Data
The dataset is provided by the University of California Irvine and has to do with the recognition of human activity based on variables recorded from smartphones during the activity.  An experiment was conducted at UCI where 30 subjects performed six activities while wearing a smartphone.  The data collected from the smartphones is a series of recordings of aspects of their movement along three dimensions.  Then, for many of these movement aspects, there are a number of statistical measures captured such as the mean, the standard deviation, and a number of others.  There are a total of 561 of these *features*.

For this assignment, fortunately, I did not have to fully understand how these features described the movement of these subjects through their activities.  What I did have to do was identify those features (the 561 columns in the dataset) that were means or standard deviations.  There are 66 of these, and they can be identified by the presence of the string *mean()* or *std()* in their column (feature) name.
## Data Processing
The R code I have written processes the data as follows:
- ensures the presence of a folder in the working directory containing the dataset
- reads in the column (features) names and identifies those pertaining to mean or standard deviation
- reads in the activity labels, the word descriptions of the activities performed by the subjects
- reads in the train and test data sets containing all of the measurements from the study (the data was broken into these two groups by the experimenters)
- then, only those features pertaining to mean and standard deviation are kept
- the activity identifier and subject identifiers are appended to the remaining features
- the activity identifier is replaced with the activity label
- the remaining test and train data are combined into one data set
- a summary data set (the *tidy data set*) is the mean of each of the remaining features when grouped by subject identifier and activity
