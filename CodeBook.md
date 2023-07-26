# Experiment Set Up
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/subject_train.txt': Each row identifies the subject, who is identical to the equivalent subject number in subject_train.txt. However, the range is smaller (2, 4, 9, 10, 12, 13, 18, 20, 24).   

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

# Features 

Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'

# Activities 

The labels below were obtained from activity_labels.txt

1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING

# Transformations/Data Cleaning

The purpose of this project is to prepare tidy data that can be used for later analysis. I designed this script according to project specifications and used the data.table, dplyr, and tidyr libraries to conduct this data cleaning. 

## Merging The Train And Test Data Sets 

Before I could begin to merge the data sets, I realized that each data set had a common set of variables (i.e. column names) that I needed to set. So, I read in those column names from the features.txt file provided. Then, I edited the variable names to appear more tidy (e.g. removing line numbers, cutting out white space, etc.). To finish this part of the process, I added a column to the start, "Subject", referring to the id numbers the subjects assigned to each volunteer. I also added an "Activity" column to the end to refer to what activity the subject was doing while measurements were recorded. 

Afterwards, I made the train and test datasets in a similar manner. In both the test and train data sets, they possessed three separate text files that contained the following: subject IDs, X data, and y data. I simply loaded in each file as data tables, combined them into larger data tables, and named their columns according to the features in the first part of this section. 

Lastly, I merged the datasets into one large dataset simplying by binding the rows of the train data to the rows of the test data. For the sake of future tidiness, I reordered the data by Subject and Activity. 

## Extracting Measurements

I used the function "select" from the dplyr library to select the data. Besides the mandatory "Subject" and "Activity" columns, I also selected every column that featured the pattern "std" for standard deviation and "mean[^Freq]" for mean but not mean frequency. 

## Labeling Activities

I loaded in the activities featured in the activity_labels.txt file, and processed them into a list of character vectors. Using the fact that each activity corresponded to an assigned number from 1-6, I simply used the mutate function to redefine the the Activity column and used the assigned numbers as indices that corresponded to their activity label. As an example, "WALKING" was represented with a number 1, and its index within the list of labels was 1. Therefore, I simply called list[activity number] to get "WALKING". 

## Labeling Data With Descriptive Variable Names

This was done earlier in the process when I initially named each column according to their measurement names. 

## Second Data Set

This portion of the process was more difficult than I initially expected, but I nonetheless got it done. In order to ensure I would properly find the means of each measurement according to their subject id and activity, I split the data by those two attributes, which generated a 180 element long list of data frames (e.g. first element of the list was Subject 1's "WALKING" measurements, second element was Subject 1's "WALKING_UPSTAIRS" data, etc.) Then, I looped through each dataframe in this list, applied the colMeans function (as well as other string/label tidying), and merged the data into one mega data table. After the work was done, I saved all of this as the second data set. 

