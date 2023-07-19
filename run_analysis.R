run_analysis <- function() {
    # Load libraries
    library(data.table)
    library(dplyr)
    
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
    
    # Merge, Select, & Label Data
    merged <- bind_rows(train_data, test_data)
    selected <- select(merged, c(1, grep("mean[^Freq]", colNames), grep("std", colNames), 563))
    setwd("UCI HAR Dataset")
    activities <- readLines("activity_labels.txt")
    activities <- gsub("^[0-9]+", "", activities)
    activities <- trimws(activities)
    labeled <- mutate(selected, Activity = activities[as.numeric(Activity)])
    
    # Second Dataset
    split(labeled, by = c("Subject", "Activity"))
    tapply(labeled, c("Subject", "Activity"), mean)
}