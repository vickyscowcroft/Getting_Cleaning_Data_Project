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

4. Merge the test and train data tables to create a single data table
 - Using the dplyr rbind command
 
5. Extract the columns with mean or std in their name using the dplyr select() command and the contains() option
 - Using multiple calls to contains() to get out the mean, std, activity and subject columns
 - Using -contains to remove the columns that are labelled 'angle' - we don't need these
 - Using ignore.case() to catch all instances of mean and std

6. Using mutate, replace the numeric activity IDs with the descriptive names

7. Create average for each variable for each activity and each subject
 - Use group_by() and summarise_each() to grab the right summary statistics
 - Using rbind() with fill=TRUE to fill missing data with NAs.
 - data will be missing on the activity when the row is about a subject and vice versa.
 
8. Print the final information to the output file
 - Using write.table() with row.names =FALSE.
 - Output file is output_file.txt