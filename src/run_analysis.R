# Merge the training and the test sets to create one data set.
features <- read.table("./data/features.txt", sep = "" , header = F, na.strings ="", stringsAsFactors = F)
colnames(features) <- c("id", "name")

X_train <- read.table("./data/train/X_train.txt", na.strings = "", stringsAsFactors = F)
X_train <- X_train[complete.cases(X_train),]
colnames(X_train) <- features$name

X_test <- read.table("./data/test/X_test.txt", na.strings = "", stringsAsFactors = F)
X_test <- X_test[complete.cases(X_test),]
colnames(X_test) <- features$name

all.data <- rbind(X_train, X_test)

# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
