library(data.table)
library(dplyr)
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

## merged data table created using the data table rbind

merged_dt <- rbind(train_dt, test_dt)

## Extract the mean and std columns using select() and contains()
## Remember to use multiple calls to contains, rather than lumping them all in one
extracted_dt <- select(merged_dt, contains("activity"), contains("subject"), contains("mean", ignore.case=TRUE), contains("std", ignore.case=TRUE), -contains("angle", ignore.case=TRUE))

## Add in the activity names
activity_levels <- data.frame(act_labels)
activity_vector <- extracted_dt$activity
activity_names <- activity_levels$V2[activity_vector]

## Replace the activity factor with the activity names using mutate

new_extracted_data <- mutate(extracted_dt, activity=activity_names)

## Get average for each variable for each activity and each subject
activity_summary <- new_extracted_data %>% group_by(activity) %>% summarise_each(funs(mean), vars=-subject)
subject_summary <- new_extracted_data %>% group_by(subject) %>% summarise_each(funs(mean), vars=-activity)

## merge the data into one output file, filling the missing data with NAs
## Data will be missing in the subject column where the row is about an activity and vice versa

final_merged_data <- rbind(activity_summary, subject_summary,  fill=TRUE)

write.table(final_merged_data, "output_file.txt", row.name=FALSE)

