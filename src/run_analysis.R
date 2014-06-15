## Paul Reiners
## June 15, 2014
## Getting and Cleaning Data
## Course Project

# 1. Merge the training and the test sets to create one data set.
features <- read.table("./data/features.txt", na.strings ="", stringsAsFactors = F)
colnames(features) <- c("id", "name")
columnNames <- features$name

train <- read.table("./data/train/subject_train.txt", na.strings = "", stringsAsFactors = F)
colnames(train) = ("subject")
Y_train <- read.table("./data/train/Y_train.txt", na.strings = "", stringsAsFactors = F)
colnames(Y_train) <- c("activity")
train <- cbind(train, Y_train)
X_train <- read.table("./data/train/X_train.txt", na.strings = "", stringsAsFactors = F)
colnames(X_train) <- columnNames
train <- cbind(train, X_train)

test <- read.table("./data/test/subject_test.txt", na.strings = "", stringsAsFactors = F)
colnames(test) = ("subject")
Y_test <- read.table("./data/test/Y_test.txt", na.strings = "", stringsAsFactors = F)
colnames(Y_test) <- c("activity")
test <- cbind(test, Y_test)
X_test <- read.table("./data/test/X_test.txt", na.strings = "", stringsAsFactors = F)
colnames(X_test) <- columnNames
test <- cbind(test, X_test)

all.data <- rbind(train, test)

# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
is.mean.or.std <- grepl("-(mean|std)\\(\\)", columnNames, ignore.case = TRUE)
all.data <- all.data[, c(TRUE, TRUE, is.mean.or.std)]

# 3. Use descriptive activity names to name the activities in the data set
MapActivityNumberToActivityDescription <- function(index) {
        descriptions <- c("walking", "walking upstairs", "walking downstairs", "sitting", "standing", "playing")
        
        return(descriptions[index])
}

all.data$activity <- sapply(all.data$activity, MapActivityNumberToActivityDescription)
all.data$activity <- as.factor(all.data$activity)

# 4. Appropriately labels the data set with descriptive variable names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
getRidOfBadChars <- function(s) {
        s <- gsub("-", "", s)
        s <- gsub("\\(", "", s)
        s <- gsub(")", "", s)
        s <- gsub(",", "", s)
        
        return(s)
}

columnNames <- lapply(columnNames, getRidOfBadChars)

addSuffix <- function(str, suffix) {
        return(paste(str, suffix, sep="_"))
}

means <- aggregate(. ~ subject.id, data = all.data, FUN = mean)
meansColNames <- colnames(means)[2:length(colnames(means))]
meansColNames <- c("subject.id", meansColNames)
colnames(means) <- meansColNames
