# TidyData

In this repository, these files/folders are provided:
- UCI HAR Dataset
- CodeBook.md
- first_tidy_data.rda
- run_analysis.R
- second_tidy_data.rda

## UCI HAR Dataset

This features all the original data taken from the UCI Machine Learning Repository including Subject IDs, physical data, and activity labels. For a further description of how this data is used, consult the CodeBook.md

## CodeBook

This features a summary of the original experimental design including how the data was collected, variables tracked, and most importantly, what transformations were made to the data during cleaning. 

## first_tidy_data

To start, there were two main sets of data that came from the UCI HAR Dataset: training and test data. Each dataset featured a list of subject ids, physical measurements that were taken of those subjects during prescribed activities, and the aforementioned activity being done labeled as numbers from 1-6. This first_tidy_data collected those three separate sets of data and turned them into a train data table and test data table. Then, due to sharing common columns already, the data was merged by rows and ordered. Next, the mean and standard deviation measurements of each variable were selected and the rest filtered out. Lastly, the activity numbers were replaced with their corresponding labels (e.g. 1 -> WALKING). For more information, consult the "Transformations/Data Cleaning" section of CodeBook.md. 

## second_tidy_data

This data set derived the mean values of each variable mentioned in first_tidy_data by Subject and Activity. For more information, consult the "Transformations/Data Cleaning" section of CodeBook.md.

## run_analysis

This is the script used to conduct the aforementioned data transformations. For more information, consult the "Transformations/Data Cleaning" section of CodeBook.md or look at the script directly. 
