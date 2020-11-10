####$$$$ Peer-graded Assignment: Getting and Cleaning Data Course Project

## Downloading the data and saving in in DataGCD folder

fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,destfile = "C:/Users/chand_rqrb1g/Documents/DataGCD/Dataset.zip")
unzip("C:/Users/chand_rqrb1g/Documents/DataGCD/Dataset.zip",exdir = "C:/Users/chand_rqrb1g/Documents/DataGCD/Dataset") ## Unzipping


# unzipped files are in the folder UCI HAR Dataset. Seeing the list of all files

path.rf<-file.path("C:/Users/chand_rqrb1g/Documents/DataGCD/Dataset/UCI HAR Dataset")  
filess<-list.files(path.rf,recursive=TRUE) 
filess

## Reading the data from the files

# Reading the activity files

dataActivityTest<-read.table(file.path(path.rf,"test","Y_test.txt"),header=FALSE)      ## "Y_test.txt" is in "test" folder which is in path.rf (defined earlier),there're >1 folder 
dataActivityTrain <-read.table(file.path(path.rf,"train","Y_train.txt"),header=FALSE)

# Reading the subject files

dataSubjectTrain<-read.table(file.path(path.rf,"train","subject_train.txt"),header=FALSE)  
dataSubjectTest <-read.table(file.path(path.rf,"test","subject_test.txt"),header=FALSE)

# Reading the Feature files

dataFeaturesTest<-read.table(file.path(path.rf,"test","X_test.txt"),header=FALSE)
dataFeaturesTrain<-read.table(file.path(path.rf,"train","x_train.txt"),header=FALSE)

# Looking at the above data

str(dataActivityTest)
str(dataActivityTrain)
str(dataSubjectTrain)
str(dataSubjectTest)

#######$$$$$ Q1- Merging the training and the test sets to create one data set- 

# a)Row binding the datasets

datasubject<-rbind(dataSubjectTrain,dataSubjectTest)
dataActivity<-rbind(dataActivityTrain,dataActivityTest)
dataFeature<-rbind(dataFeaturesTrain,dataFeaturesTest)

str(datasubject)
str(dataActivity)
str(dataFeature)

# b) Naming the variables      

names(datasubject)<-c("Subject")
names(dataActivity)<-c("Activity_ID")
dataFeatureNames<-read.table(file.path(path.rf,"features.txt"),head=FALSE)

names(dataFeature)<-dataFeatureNames$V2        ## names of the variables in the dataFeature will be assigned as the per features text file
str(dataFeature)

# c) Merging the columns of the above 3 datasets to create one data set

dataCombine<-cbind(datasubject,dataActivity)
Data_Com<-cbind(dataCombine,dataFeature)

str(Data_Com)

#######$$$$$ Q2- Extracts only the measurements on the mean and standard deviation for each measurement

# a) Subsetting by measurements on the mean() and std()

library(dplyr)

?select
subdataFeature<-dataFeature %>%
  select(contains("mean()")|contains("std()"))

str(subdataFeature)

# b) Merging dataCombine & subdataFeature by columns to have selected features and Subject & Activity_ID columns

DATA<-cbind(dataCombine,subdataFeature)
str(DATA)

#######$$$$$ Q3- Uses descriptive activity names to name the activities in the data set

# a) Read descriptive activity names from "activity_labels.txt"

activityLabels<-read.table(file.path(path.rf,"activity_labels.txt"),header = FALSE)

# b) Assigning a variable names fo the variables in activityLabel

names(activityLabels)<-c("Activity_ID","ActivityDescription")
str(activityLabels)

# c) Merging to label the Activities by the Activity description

DATA_Descriptive<-merge(DATA,activityLabels,by.x="Activity_ID",by.y = "Activity_ID",all=TRUE)

# d) Dropping Activity_ID since we already have Activity Description

str(DATA_Descriptive2)
DATA_Descriptive2<-subset(DATA_Descriptive,select=-(Activity_ID))

# e) Checkin

tail(DATA_Descriptive2$ActivityDescription,100)


#######$$$$$ Q4.Appropriately labels the data set with descriptive variable names

# a) Names of Feteatures will labelled using descriptive variable names

names(DATA_Descriptive2)<-gsub("^t","time",names(DATA_Descriptive2))
names(DATA_Descriptive2)<-gsub("Acc","Accelerometer",names(DATA_Descriptive2))
names(DATA_Descriptive2)<-gsub("Gyro","Gyroscope",names(DATA_Descriptive2))
names(DATA_Descriptive2)<-gsub("^f","frequency",names(DATA_Descriptive2))
names(DATA_Descriptive2)<-gsub("Mag","Magnitude",names(DATA_Descriptive2))
names(DATA_Descriptive2)<-gsub("BodyBody","Body",names(DATA_Descriptive2))

?gsub

#######$$$$$ Q5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each subject and each activity

library(tidyr)
library(tidyverse)
library(dplyr)

Data2Tidy<-DATA_Descriptive2 %>%
  group_by(Subject,ActivityDescription) %>%
  summarise(across(everything(),list(mean)))   ## summarizing multiple column with dplyr
Data2Tidy

names(DATA_Descriptive2)  

View(Data2Tidy)

write.table(Data2Tidy,file="TidyDataset.txt",row.names = FALSE)  ## impoting to a text file

library(knitr)
knit2html("codebook.Rmd")
