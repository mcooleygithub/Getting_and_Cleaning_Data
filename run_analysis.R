# This program is for my Coursera Getting and Cleaning Data course project
# Author:  MAC
# Date: 15-Dec-2014

# First, establish that the data files are present and ready for processing
 
# Set the location of the data to be retrieved and processed 
dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
 
# Set the name of the folder in which to store the data 
dataFolder <- "./HumanActivityRecognitionData"
 
# Check to see if a folder for the data already exists 
folderCheck <- is.na(file.info(dataFolder)[1, "isdir"])
 
# If the folder does not exist, create the folder for the data 
if(folderCheck) { dir.create(dataFolder)}
 
# If the folder does not exist, download the data into the folder
if(folderCheck) { download.file(dataURL, paste(dataFolder,"/Data.zip", sep=""))}
 
# If the folder does not exist, unzip the file, and put the unzipped folders... 
# there in the data folder
if(folderCheck) {unzip(paste(dataFolder,"/Data.zip", sep=""), exdir=dataFolder)} 
folderPath <- paste(dataFolder,"/UCI HAR Dataset", "/", sep="")
 
 
# Now, begin the data processing
 
# Read in the "features” file so column names can be assigned to the datasets 
columnNamesFile <- paste(folderPath, "features.txt", sep="") 
columnNames <- read.table(columnNamesFile, col.names = c("column_id", "column_name"), header = FALSE)  
 
# Evaluate the column names, so later those not pertaining to mean or standard deviation can be dropped.
# The parentheses are special characters, so they must be "escaped” with the "\\” 
columnsToKeep <- grepl("mean\\(\\)|std\\(\\)", columnNames$column_name)
 
# Read in the "activity_label" file so activities can be decoded in the data set 
activitiesFile <- paste(folderPath, "activity_labels.txt", sep="") 
activities <- read.table(activitiesFile, col.names = c("activity_id", "activity"))
 

# Now, read in the train files 
X_train_file <- paste(folderPath, "/train/X_train.txt", sep="") 
X_train <- read.table(X_train_file, header = FALSE)
colnames(X_train) <- columnNames$column_name
 
y_train_file <- paste(folderPath, "/train/y_train.txt", sep="") 
y_train <- read.table(y_train_file, col.names = c("activity_id"), header = FALSE)
 
subject_train_file <- paste(folderPath, "/train/subject_train.txt", sep="") 
subject_train <- read.table(subject_train_file, col.names = c("subject_id"), header = FALSE)
 
# Keep only those columns in X_train reporting a mean or standard deviation 
X_train <- X_train[, columnsToKeep]
 
# Add the activity id from y_train into a new column in X_train 
X_train$activity_id <- as.factor(y_train$activity_id)
 
# Add the subject id from subject_train into a new column in X_train 
X_train$subject_id <- as.factor(subject_train$subject_id)
 
 
# Next, read in the test files and give the column names
X_test_file <- paste(folderPath, "/test/X_test.txt", sep="") 
X_test <- read.table(X_test_file, header = FALSE)
colnames(X_test) <- columnNames$column_name
 
y_test_file <- paste(folderPath, "/test/y_test.txt", sep="") 
y_test <- read.table(y_test_file, col.names = c("activity_id"), header = FALSE)
 
subject_test_file <- paste(folderPath, "/test/subject_test.txt", sep="") 
subject_test <- read.table(subject_test_file, col.names = c("subject_id"), header = FALSE)
 
# Keep only those columns in X_test reporting a mean or standard deviation 
X_test <- X_test[, columnsToKeep]
 
# Add the activity id from y_test into a new column in X_test 
X_test$activity_id <- as.factor(y_test$activity_id)
 
# Add the subject id from subject_test into a new column in X_test 
X_test$subject_id <- as.factor(subject_test$subject_id)
 
 
# Combine the two "X” datasets into one
combinedDataSet <- rbind(X_test, X_train)
 
# Join the combinedDataSet to the activities table to bring over the descriptive activities
combinedDataSet <- merge(x=combinedDataSet, y=activities, by.x="activity_id", by.y="activity_id")
 
# Grouping by subject_id and activity_id, calculate the mean for each column
summarizedDataSet <- ddply(combinedDataSet, .(subject_id, activity), numcolwise(mean))


# Finally, write out the table with the grouped mean for each column
write.table(summarizedDataSet, "./tidy_data.txt",  row.name=FALSE)
