# Merge the training and the test sets to create one data set.
features <- read.table("./data/features.txt", na.strings ="", stringsAsFactors = F)
colnames(features) <- c("id", "name")

X_train <- read.table("./data/train/X_train.txt", na.strings = "", stringsAsFactors = F)
colnames(X_train) <- features$name
subject_train <- read.table("./data/train/subject_train.txt", na.strings = "", stringsAsFactors = F)
colnames(subject_train) = ("subject.id")
X_train$subject.id <- subject_train$subject.id

X_test <- read.table("./data/test/X_test.txt", na.strings = "", stringsAsFactors = F)
colnames(X_test) <- features$name
subject_test <- read.table("./data/test/subject_test.txt", na.strings = "", stringsAsFactors = F)
colnames(subject_test) = ("subject.id")
X_test$subject.id <- subject_test$subject.id

all.data <- rbind(X_train, X_test)

# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
cdata <- aggregate(. ~ subject.id, data = all.data, FUN = function(x) c(mean = mean(x), sd = sd(x)))
