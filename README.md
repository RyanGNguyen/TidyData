# TidyData

The purpose of this project is to prepare tidy data that can be used for later analysis. I designed this script according to project specifications and used the data.table, dplyr, and tidyr libraries to conduct this data cleaning. 

# Merging The Train And Test Data Sets 

Before I could begin to merge the data sets, I realized that each data set had a common set of variables (i.e. column names) that I needed to set. So, I read in those column names from the features.txt file provided. Then, I edited the variable names to appear more tidy (e.g. removing line numbers, cutting out white space, etc.). To finish this part of the process, I added a column to the start, "Subject", referring to the id numbers the subjects assigned to each volunteer. I also added an "Activity" column to the end to refer to what activity the subject was doing while measurements were recorded. 

Afterwards, I made the train and test datasets in a similar manner. In both the test and train data sets, they possessed three separate text files that contained the following: subject IDs, X data, and y data. I simply loaded in each file as data tables, combined them into larger data tables, and named their columns according to the features in the first part of this section. 

Lastly, I merged the datasets into one large dataset simplying by binding the rows of the train data to the rows of the test data. For the sake of future tidiness, I reordered the data by Subject and Activity. 

# Extracting Measurements

I used the function "select" from the dplyr library to select the data. Besides the mandatory "Subject" and "Activity" columns, I also selected every column that featured the pattern "std" for standard deviation and "mean[^Freq]" for mean but not mean frequency. 

# Labeling Activities

I loaded in the activities featured in the activity_labels.txt file, and processed them into a list of character vectors. Using the fact that each activity corresponded to an assigned number from 1-6, I simply used the mutate function to redefine the the Activity column and used the assigned numbers as indices that corresponded to their activity label. As an example, "WALKING" was represented with a number 1, and its index within the list of labels was 1. Therefore, I simply called list[activity number] to get "WALKING". 

# Labeling Data With Descriptive Variable Names

This was done earlier in the process when I initially named each column according to their measurement names. 

# Second Data Set

This portion of the process was more difficult than I initially expected, but I nonetheless got it done. In order to ensure I would properly find the means of each measurement according to their subject id and activity, I split the data by those two attributes, which generated a 180 element long list of data frames (e.g. first element of the list was Subject 1's "WALKING" measurements, second element was Subject 1's "WALKING_UPSTAIRS" data, etc.) Then, I looped through each dataframe in this list, applied the colMeans function (as well as other string/label tidying), and merged the data into one mega data table. After the work was done, I saved all of this as the second data set. 

