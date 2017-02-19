# A helper method to check dependency packages, install it if necessary 
InstallPackagesIfNotExist <- function(...) {
  lapply(list(...), function(lib) {
    if (!lib %in% installed.packages()) 
      install.packages(lib)
  })
}

# Get the dataset
if (is.na(file.info('UCI HAR Dataset')$isdir)) {
  dataFile <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
  download.file(dataFile, 'dataset.zip')
  unzip('dataset.zip')
}

# Merges the training and the test sets to create one data set.
subject.train <- read.table('UCI HAR Dataset/train/subject_train.txt', header = FALSE)
subject.test <- read.table('UCI HAR Dataset/test/subject_test.txt', header = FALSE)
subject.all <- rbind(subject.train, subject.test)

activity.train <- read.table('UCI HAR Dataset/train/y_train.txt', header = FALSE)
activity.test <- read.table('UCI HAR Dataset/test/y_test.txt', header = FALSE)
activity.all <- rbind(activity.train, activity.test)

feature.train <- read.table('UCI HAR Dataset/train/X_train.txt', header = FALSE)
feature.test <- read.table('UCI HAR Dataset/test/X_test.txt', header = FALSE)
feature.all <- rbind(feature.train, feature.test)

names(subject.all) <- c("subject")
names(activity.all) <- c("activity")

features.name <- read.table('UCI HAR Dataset/features.txt', header = FALSE)
names(feature.all) <- features.name$V2

data = cbind(subject.all, activity.all)
data.all = cbind(data, feature.all)

# Extracts only the measurements on the mean and standard deviation for each measurement.
features.selected <- features.name$V2[grep("mean\\(\\)|std\\(\\)", features.name$V2)]
columns <- c("subject", "activity", as.character(features.selected))
data.selected <- subset(data.all, select=columns)

# Uses descriptive activity names to name the activities in the data set
activity.names <- read.table('UCI HAR Dataset/activity_labels.txt', header = FALSE)
data.selected$activity <- activity.names[data.selected[,2],2]

# Appropriately labels the data set with descriptive variable names
names(data.selected)<-gsub("^t", "time", names(data.selected))
names(data.selected)<-gsub("^f", "frequency", names(data.selected))
names(data.selected)<-gsub("Acc", "Accelerometer", names(data.selected))
names(data.selected)<-gsub("Gyro", "Gyroscope", names(data.selected))
names(data.selected)<-gsub("Mag", "Magnitude", names(data.selected))
names(data.selected)<-gsub("BodyBody", "Body", names(data.selected))
names(data.selected)<-gsub("\\(|\\)", "", names(data.selected))

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
InstallPackagesIfNotExist("plyr")
data.tidy<-aggregate(. ~subject + activity, data.selected, mean)
data.tidy<-data.tidy[order(data.tidy$subject,data.tidy$activity),]
write.table(data.tidy, file = "tidy_data.txt", row.name=FALSE)
 
