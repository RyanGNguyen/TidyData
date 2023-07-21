# TidyData

The purpose of this project is to prepare tidy data that can be used for later analysis. I designed this script according to project specifications and used the data.table, dplyr, and tidyr libraries to conduct this data cleaning. 

# Merging The Train And Test Data Sets 

Before I could begin to merge the data sets, I realized that each data set had a common set of variables (i.e. column names) that I needed to set. So, I read in those column names from the features.txt file provided. Then, I edited the variable names to appear more tidy (e.g. removing line numbers, cutting out white space, etc.). To finish this part of the process, I added a column to the start, "Subject", referring to the id numbers the subjects assigned to each volunteer. I also added an "Activity" column to the end to refer to what activity the subject was doing while measurements were recorded. 

Afterwards, I made the train and test datasets in a similar manner. In both the test and train data sets, they possessed three separate text files that contained the following: subject IDs, X data, and y data. I simply loaded in each file as data tables, combined them into larger data tables, and named their columns according to the features in the first part of this section. 

Lastly, I merged the datasets into one large dataset simplying by binding the rows of the train data to the rows of the test data. For the sake of future tidiness, I reordered the data by Subject and Activity. 

# Selecting Merged Data

