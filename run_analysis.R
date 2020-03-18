#Set Working Directory

setwd("D:/ProjectData/GettingAndCleaningData/data")

#Load necessary package
library(dplyr)


#Load data into R

features <- read.table("./features.txt", col.names = c("n","functions"))
activities <- read.table("./activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("./test/subject_test.txt", col.names = "subject")
x_test <- read.table("./test/X_test.txt", col.names = features$functions)
y_test <- read.table("./test/y_test.txt", col.names = "code")
subject_train <- read.table("./train/subject_train.txt", col.names = "subject")
x_train <- read.table("./train/X_train.txt", col.names = features$functions)
y_train <- read.table("./train/y_train.txt", col.names = "code")


#Merge data together
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

#Select only the columns we are interested in to create our tidy dataset
TidyData <- Merged_Data %>% 
        select(subject, code, contains("mean"), contains("std"))


#Use the values in activities to rename the values in the code column of the tidy dataset
TidyData$code <- activities[TidyData$code, 2]

#Give More descriptive names to the columns in our dataset

names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

#create the final tidy dataset that includes means by subject and activity
FinalData <- TidyData %>%
        group_by(subject, activity) %>%
        summarise_all(funs(mean))

#Write ridy dataset of means to a table called FinalData.txt
write.table(FinalData, "FinalData.txt", row.name=FALSE)