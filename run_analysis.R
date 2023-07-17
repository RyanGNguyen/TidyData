run_analysis <- function() {
    # Data Column Names
    setwd("UCI HAR Dataset")
    features <- readLines("features.txt")
    features <- gsub("^[0-9]+", "", features)
    features <- trimws(features)
    colNames <- append(features, "Subject", after = 0)
    colNames <- append(colNames, "Activity")
    
    # Loading Train Data
    setwd("train")
    subject_train <- read.table("subject_train.txt")
    X_train <- read.table("X_train.txt")
    y_train <- read.table("y_train.txt")
    
    # Train Data Table
    train_data <- data.table(subject_train, X_train, y_train) 
    names(train_data) <- colNames
    
    # Loading Test Data
    setwd("UCI HAR Dataset/test")
    subject_test <- read.table("subject_test.txt")
    X_test <- read.table("X_test.txt")
    y_test <- read.table("y_test.txt")
    
    # Test Data Table
    test_data <- data.table(subject_test, X_test, y_test) 
    names(test_data) <- colNames
    
    # Merge Train and Test Data
    
}