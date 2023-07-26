run_analysis <- function() {
    # Load libraries
    library(data.table)
    library(dplyr)
    library(tidyr)
    
    # Data Column Names
    setwd("~/TidyData/UCI HAR Dataset")
    features <- readLines("features.txt")
    features <- gsub("^[0-9]+", "", features)
    features <- trimws(features)
    colNames <- append(features, "Subject", after = 0)
    colNames <- append(colNames, "Activity")
    
    # Loading Train Data
    setwd("~/TidyData/UCI HAR Dataset/train")
    subject_train <- read.table("subject_train.txt")
    X_train <- read.table("X_train.txt")
    y_train <- read.table("y_train.txt")
    
    # Train Data Table
    train_data <- data.table(subject_train, X_train, y_train) 
    names(train_data) <- colNames
    
    # Loading Test Data
    setwd("~/TidyData/UCI HAR Dataset/test")
    subject_test <- read.table("subject_test.txt")
    X_test <- read.table("X_test.txt")
    y_test <- read.table("y_test.txt")
    
    # Test Data Table
    test_data <- data.table(subject_test, X_test, y_test) 
    names(test_data) <- colNames
    
    # Merge, Order, Select, & Label Data
    merged <- bind_rows(train_data, test_data)
    setorderv(merged, c("Subject", "Activity"), c(1,1))
    selected <- select(merged, c(1, grep("mean[^Freq]", colNames), grep("std", colNames), 563))
    setwd("~/TidyData/UCI HAR Dataset")
    activities <- readLines("activity_labels.txt")
    activities <- gsub("^[0-9]+", "", activities)
    activities <- trimws(activities)
    labeled <- mutate(selected, Activity = activities[as.numeric(Activity)])
    setwd("~/TidyData")
    
    # Second Dataset
    splitted <- split(labeled, by = c("Subject", "Activity"))
    tidydata <- data.frame(matrix(ncol=68, nrow = 0))
    for (i in 1:length(splitted)) {
        means <- colMeans(as.data.table(splitted[i])[,2:67])
        labels <- unlist(strsplit(names(splitted[i]), split = '\\.'))
        table <- data.frame(t(means))
        table <- cbind(labels[1], table, labels[2])
        names(table) <- c("Subject", names(table)[2:67], "Activity")
        names(table) <- gsub("([X])(\\d+)(\\.)([A-Z]+)(_?)([A-Z]*)(\\.)", "", names(table))
        tidydata <- rbind(tidydata, table)
    }
    write.table(tidydata, file = "tidy_data.txt", row.names = FALSE)
}