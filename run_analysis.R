library(data.table)
setwd("/Users/vs/Dropbox/Data_Science_Course/Getting_Cleaning_Data/Course_Project/UCI HAR Dataset")

## Read in the training files
x_train <- read.table("train/X_train.txt") 
y_train <- read.table("train/Y_train.txt")
subj_train <- read.table("train/subject_train.txt")

## Read in the testing files
x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/Y_test.txt")
subj_test <- read.table("test/subject_test.txt")

## Switch the data fromes created above to data.tables to make them easier to work with

x_train_dt <- data.table(x_train)
y_train_dt <- data.table(y_train)
subj_train_dt <- data.table(subj_train)

x_test_dt <- data.table(x_test)
y_test_dt <- data.table(y_test)
subj_test_dt <- data.table(subj_test)

## Read in the feature names
## Using colCalsses='character' so I can use these as the column names
features <- read.table("features.txt", colClasses='character')
## Setting the column names in the train and test data sets to the correct values
names(x_train_dt) <- c(features$V2)
names(x_test_dt) <- c(features$V2)

## Read in the activity lables
act_labels <- read.table("activity_labels.txt")

## cbind the subject and activity together
train_dt <- cbind(subj_train_dt, y_train_dt) 
## Give them columns names
names(train_dt) <- c("subject", "activity")
## Now cbind to the big data table
train_dt <- cbind(train_dt, x_train_dt)

## Repeat for test data set
test_dt <- cbind(subj_test_dt, y_test_dt) 
names(test_dt) <- c("subject", "activity")
test_dt <- cbind(test_dt, x_test_dt)



