Tidy Mean and Standard Deviation Data from the UCI HAR Data Set
=============================================================================
The Data

This script uses the data from UC Irvine's Human Activity Recognition Using Smartphones Data Set. 

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
=============================================================================

Requirements:

Perform analysis on local directory : C:/tmp 
=============================================================================

The Script:

This repository contains a script called run_analysis.R.

The script does the following:

1. Merges the subjects, features and labels for both the training and test sets.
2. Filters out features to have only the measurements on the mean and standard deviation for each measurement.
3. Replaces activity identifiers with descriptive activity names.
4. Updates column names to provide representative names.
5. Computes the average of each variable for each activity and each subject.
6. Writes the tidy data set without row names 


Step by step breakdown:

# install dplyr package
install.packages("dplyr")
library("dplyr") 

# path
setwd("C:/tmp")

# download data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
data <- tempfile()
download.file(fileUrl, data)

# unzip data
data <- unzip(data)

# view data
data

# read data
subject_test <- read.table(data[[14]])
subject_train <- read.table(data[[26]])
X_test <- read.table(data[[15]])
X_train<- read.table(data[[27]])
y_test <- read.table(data[[16]])
y_train<- read.table(data[[28]])

# merge data
subject_data <- rbind(subject_test, subject_train)
activity_data <- rbind(y_test, y_train)
features_data <- rbind(X_test, X_train)

merged_data <- cbind(activity_data, subject_data, features_data)

# add column names
features <- read.table(data[[2]])
names(merged_data) <- c(c("activity", "subject"), as.character(features$V2))

# extracts columns: mean & std
mean_std_data <- merged_data[ , grepl( "activity|subject|mean|std" , names(merged_data) ) ]

# add activity labels 
activities <- read.table(data[[1]])
mean_std_data$activity <- activities$V2[mean_std_data$activity]

# data set with descriptive variable names
names(mean_std_data)<-gsub("^t", "time", names(mean_std_data))
names(mean_std_data)<-gsub("^f", "freqency", names(mean_std_data))
names(mean_std_data)<-gsub("Acc", "Accelerometer", names(mean_std_data))
names(mean_std_data)<-gsub("Gyro", "Gyroscope", names(mean_std_data))
names(mean_std_data)<-gsub("Mag", "Magnitude", names(mean_std_data))

# tidy data set with the average of each variable for each activity and each subject
tidy_data <- mean_std_data  %>%  group_by(activity, subject) %>% summarise_each(funs(mean))

# write the tidy data set to C:/tmp/tidy_data.txt

write.table(tidy_data, file = "tidy_data.txt", row.names = F)

# view tidy data
head(read.table("tidy_data.txt"),3)
=============================================================================


Code Book:

The tidy_data.txt contains the following columns:

Activity - the descriptive name of the activity performed.
Subject - an identifier of the subject who carried out the experiment.

The set of time and frequency domain variables that were estimated from these signals are: 
mean(): Mean value 
std(): Standard deviation:
timeBodyAccelerometer-mean()-X
timeBodyAccelerometer-mean()-Y
timeBodyAccelerometer-mean()-Z
timeBodyAccelerometer-std()-X
timeBodyAccelerometer-std()-Y
timeBodyAccelerometer-std()-Z
timeGravityAccelerometer-mean()-X
timeGravityAccelerometer-mean()-Y
timeGravityAccelerometer-mean()-Z
timeGravityAccelerometer-std()-X
timeGravityAccelerometer-std()-Y
timeGravityAccelerometer-std()-Z
timeBodyAccelerometerJerk-mean()-X
timeBodyAccelerometerJerk-mean()-Y
timeBodyAccelerometerJerk-mean()-Z
timeBodyAccelerometerJerk-std()-X
timeBodyAccelerometerJerk-std()-Y
timeBodyAccelerometerJerk-std()-Z
timeBodyGyroscope-mean()-X
timeBodyGyroscope-mean()-Y
timeBodyGyroscope-mean()-Z
timeBodyGyroscope-std()-X
timeBodyGyroscope-std()-Y
timeBodyGyroscope-std()-Z
timeBodyGyroscopeJerk-mean()-X
timeBodyGyroscopeJerk-mean()-Y
timeBodyGyroscopeJerk-mean()-Z
timeBodyGyroscopeJerk-std()-X
timeBodyGyroscopeJerk-std()-Y
timeBodyGyroscopeJerk-std()-Z
timeBodyAccelerometerMagnitude-mean()
timeBodyAccelerometerMagnitude-std()
timeGravityAccelerometerMagnitude-mean()
timeGravityAccelerometerMagnitude-std()
timeBodyAccelerometerJerkMagnitude-mean()
timeBodyAccelerometerJerkMagnitude-std()
timeBodyGyroscopeMagnitude-mean()
timeBodyGyroscopeMagnitude-std()
timeBodyGyroscopeJerkMagnitude-mean()
timeBodyGyroscopeJerkMagnitude-std()
freqencyBodyAccelerometer-mean()-X
freqencyBodyAccelerometer-mean()-Y
freqencyBodyAccelerometer-mean()-Z
freqencyBodyAccelerometer-std()-X
freqencyBodyAccelerometer-std()-Y
freqencyBodyAccelerometer-std()-Z
freqencyBodyAccelerometer-meanFreq()-X
freqencyBodyAccelerometer-meanFreq()-Y
freqencyBodyAccelerometer-meanFreq()-Z
freqencyBodyAccelerometerJerk-mean()-X
freqencyBodyAccelerometerJerk-mean()-Y
freqencyBodyAccelerometerJerk-mean()-Z
freqencyBodyAccelerometerJerk-std()-X
freqencyBodyAccelerometerJerk-std()-Y
freqencyBodyAccelerometerJerk-std()-Z
freqencyBodyAccelerometerJerk-meanFreq()-X
freqencyBodyAccelerometerJerk-meanFreq()-Y
freqencyBodyAccelerometerJerk-meanFreq()-Z
freqencyBodyGyroscope-mean()-X
freqencyBodyGyroscope-mean()-Y
freqencyBodyGyroscope-mean()-Z
freqencyBodyGyroscope-std()-X
freqencyBodyGyroscope-std()-Y
freqencyBodyGyroscope-std()-Z
freqencyBodyGyroscope-meanFreq()-X
freqencyBodyGyroscope-meanFreq()-Y
freqencyBodyGyroscope-meanFreq()-Z
freqencyBodyAccelerometerMagnitude-mean()
freqencyBodyAccelerometerMagnitude-std()
freqencyBodyAccelerometerMagnitude-meanFreq()
freqencyBodyBodyAccelerometerJerkMagnitude-mean()
freqencyBodyBodyAccelerometerJerkMagnitude-std()
freqencyBodyBodyAccelerometerJerkMagnitude-meanFreq()
freqencyBodyBodyGyroscopeMagnitude-mean()
freqencyBodyBodyGyroscopeMagnitude-std()
freqencyBodyBodyGyroscopeMagnitude-meanFreq()
freqencyBodyBodyGyroscopeJerkMagnitude-mean()
freqencyBodyBodyGyroscopeJerkMagnitude-std()
freqencyBodyBodyGyroscopeJerkMagnitude-meanFreq()


=============================================================================
Notes:

This script has currently only been tested on Windows.