# Background of Peer-graded-Assignment-Getting-and-Cleaning-Data-Course-Project - 

The purpose of this project is to be able to collect, read, clean and work the data to prepare a tidy dataset. I will be submitting:
1) A tidy data set as named "TidyDataset.txt" 
2) A link to a Github repository with my script for performing the analysis, "run_analysis.R" and
3) A code book that describes the variables, the data, and any transformations or work that I performed to clean up the data called CodeBook.md. 
4) Also a README.md document is included

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## About R Script

*Background work*

1) Downloading the data and saving in a folder
2) Unzipping the files in the folder
3) Reading the data from the files

*Merging the training and the test sets to create one data set*

1) Naming the variables  
2) Merging the columns of the above datasets to create one data set

*Extracts only the measurements on the mean and standard deviation for each measurement*

1) Subsetting by measurements on the mean() and std()
2) Merging datasetsto have selected features columns

*Uses descriptive activity names to label the activities in the data set*

1) Read descriptive activity names from "activity_labels.txt"
2) Assigning a variable names to the variables in activityLabel
3) Merging to label the Activities by the Activity description

*Appropriately labels the data set with descriptive variable names*

1) Names of Feteatures will labelled using descriptive variable names

*Creating a second, independent tidy data set with the average of each variable for each subject and each activity*

1)summarizing multiple column
2) Writing a second tidy data in text file


