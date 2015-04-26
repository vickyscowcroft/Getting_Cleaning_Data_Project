# Getting_Cleaning_Data_Project

-- Description of data files:

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'train/subject_train.txt': Training subject labels


- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt': Test subject labels


# run_analysis.R

1. Read in the data files using read.table
 - Reading in all the files from the test and train folders into their corresponding data frames.
 - Changing the data frames to data tables to make them easier to work with.
 
2. Read in the features.txt file and the activity_labels.txt file to get the descriptive names for the activities and the features of the file.
 
 
3. Join the data tables together to create two large data tables -- one for test data and one for train data
 - This links the activity label and the subject identity to the accelerometer data.
 - Use cbind() to add the single column data tables to the x_train_dt and x_test_dt data tables.
 - Use names() to give the subject and activity columns names so they don't have the same names as any of the test or train set names
 


