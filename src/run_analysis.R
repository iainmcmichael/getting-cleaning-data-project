## Paul Reiners
## June 15, 2014
## Getting and Cleaning Data
## Course Project

# Download original data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfile <- "Dataset.zip"
download.file(url, zipfile, "curl")
unzip(zipfile)
file.remove(zipfile)
data.dir <- "./UCI HAR Dataset/"

# 4. Appropriately label the data set with descriptive variable names. 
features <- read.table(paste(data.dir, "features.txt", sep=""), na.strings ="", stringsAsFactors = F)
colnames(features) <- c("id", "name")
columnNames <- features$name

# 1. Merge the training and the test sets to create one data set.
train.dir <- paste(data.dir, "train/", sep="")
train <- read.table(paste(train.dir, "subject_train.txt", sep=""), na.strings = "", stringsAsFactors = F)
colnames(train) = ("subject")
Y_train <- read.table(paste(train.dir, "Y_train.txt", sep=""), na.strings = "", stringsAsFactors = F)
colnames(Y_train) <- c("activity")
train <- cbind(train, Y_train)
X_train <- read.table(paste(train.dir, "X_train.txt", sep=""), na.strings = "", stringsAsFactors = F)
colnames(X_train) <- columnNames
train <- cbind(train, X_train)

test.dir <- paste(data.dir, "test/", sep="")
test <- read.table(paste(test.dir, "subject_test.txt", sep=""), na.strings = "", stringsAsFactors = F)
colnames(test) = ("subject")
Y_test <- read.table(paste(test.dir, "Y_test.txt", sep=""), na.strings = "", stringsAsFactors = F)
colnames(Y_test) <- c("activity")
test <- cbind(test, Y_test)
X_test <- read.table(paste(test.dir, "X_test.txt", sep=""), na.strings = "", stringsAsFactors = F)
colnames(X_test) <- columnNames
test <- cbind(test, X_test)

all.data <- rbind(train, test)

# Clean up original data
unlink(data.dir, recursive = TRUE)

# 2. Extract only the measurements on the mean and standard deviation for each 
#    measurement. 
is.mean.or.std <- grepl("-(mean|std)\\(\\)", columnNames, ignore.case = TRUE)
all.data <- all.data[, c(TRUE, TRUE, is.mean.or.std)]

# 3. Use descriptive activity names to name the activities in the data set
MapActivityNumberToActivityDescription <- function(index) {
        descriptions <- c("walking", "walking upstairs", "walking downstairs", "sitting", "standing", "playing")
        
        return(descriptions[index])
}

all.data$activity <- sapply(all.data$activity, MapActivityNumberToActivityDescription)
all.data$activity <- as.factor(all.data$activity)

# 5. Create a second, independent tidy data set with the average of each 
#    variable for each activity and each subject. 
tidy.data <- aggregate(. ~ subject + activity, data = all.data, FUN = mean)

# Write data
write.table(tidy.data, "TidyData.txt")
