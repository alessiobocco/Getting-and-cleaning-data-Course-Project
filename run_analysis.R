rm(list=ls())

setwd("C:/Users/Alessio/Documents/Cursos online/Data Science Specialization/Getting and cleaning data/Week 4/Course Porject")

filename <- "dataset.zip"

## Download and unzip the dataset:
# Download
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename)
}  
# Unzip
if (!file.exists(filename)) { 
  unzip(filename) 
}

## -------------------------------------------------- ##

# Load activity labels and features
actLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
actLabels[,2] <- as.character(actLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

## ----------------------------------------------------------- #

# Extract only the data on X and SD
featuresNeeded <- grep(".*mean.*|.*std.*", features[,2])
featuresNeeded.names <- features[featuresNeeded,2]
featuresNeeded.names = gsub('-mean', 'Mean', featuresNeeded.names)
featuresNeeded.names = gsub('-std', 'Std', featuresNeeded.names)
featuresNeeded.names <- gsub('[-()]', '', featuresNeeded.names)

## ----------------------------------------------------------- #

# Load  datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresNeeded]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresNeeded]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

## ------------------------------------------------------------ #

# Merging labels and datasets
Data <- rbind(train, test)
colnames(Data) <- c("subject", "activity", featuresNeeded.names)

## ---------------------------------------------------------------- #

# Converting in factors
Data$activity <- factor(Data$activity, levels = actLabels[,1], labels = actLabels[,2])
Data$subject <- as.factor(Data$subject)

library(reshape2)
Data.melt <- melt(Data, id = c("subject", "activity"))
Data.mean <- dcast(Data.melt, subject + activity ~ variable, mean)

## ---------------------------------------------------------------- #

# Exporting data
write.table(Data.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
