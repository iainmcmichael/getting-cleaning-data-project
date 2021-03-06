Getting and Cleaning Data Project
=================================

### Overview

The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

We start with the "Human Activity Recognition Using Smartphones Dataset", Version 1.0, data of Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.  

We have created an R script called [run_analysis.R](https://github.com/paul-reiners/getting-cleaning-data-project/blob/master/src/run_analysis.R) that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

### Running the project

To run the project, simply run the R command below from the root directory of this project (i.e., the directory
containing this README file).

    source("./src/run_analysis.R")  

The original data will be downloaded and deleted after the program is run.  It will take about a minute to run.  The output file "TidyData.txt" will be in the project root directory.
