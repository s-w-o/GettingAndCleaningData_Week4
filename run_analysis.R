
install.packages("dplyr")
library("dplyr") 


# path

setwd("C:/tmp")


# download data

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

data <- tempfile()

download.file(fileUrl, data)


data <- unzip(data)


str(data)


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


# create tidy_data

write.table(tidy_data, file = "tidy_data.txt", row.names = F)

head(read.table("tidy_data.txt"),3)


