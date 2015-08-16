# CodeBook for the Getting and Cleaning Data Project

 This codebook details the variables, the data and any transformations that were performed to clean up the data.

## Source Data
The data set can be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and pertains to experiments carried out by UCI as part of their research into Human Activity Recognition Using Smartphone data. From the readme.txt file supplied with the data set, the folowing description of the experiments is provided:

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

* README.txt

* features_info.txt - Shows information about the variables used on the feature vector.

* features.txt - List of all features.

* activity_labels.txt - Links the class labels with their activity name.

* train/X_train.txt - Training set.

* train/y_train.txt - Training labels.

* test/X_test.txt - Test set.

*test/y_test.txt - Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

* train/subject_train.txt - Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

* train/Inertial Signals/total_acc_x_train.txt - The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

* train/Inertial Signals/body_acc_x_train.txt - The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

* train/Inertial Signals/body_gyro_x_train.txt - The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

## Transformation

The transformation of the UCI data set (into a tidy data set comprising the averages of each variable pertaining to "std"" or "mean" for each activity and each subject) is carried out by the run_analysis.r script. This script relies upon the UCI Dataset been downloaded into a subdirectory (within the current working directory) entitled "UCI HAR Dataset", and contians the following processing steps:

### 1. Read the data

The script begins by readng the following files into individual tables:

* UCI HAR Dataset/features.txt
* UCI HAR Dataset/activity_labels.txt
* UCI HAR Dataset/train/subject_train.txt
* UCI HAR Dataset/train/X_train.txt
* UCI HAR Dataset/train/y_train.txt
* UCI HAR Dataset/test/subject_test.txt
* UCI HAR Dataset/test/y_test.txt
* UCI HAR Dataset/test/X_test.txt

Those features pertaining "std" or "mean" are then extracted from the features table using grep().

### 2. Merge the data

The various files of the training data (subject_train.txt, X_train.txt and y_train.txt) are merged using row number as a common key. The same process is performed on the test dataset (subject_test.txt, y_test.txt and X_test.txt) before the two resultant tables are combined using rbind(). Using the list of features pertaining to "std" or "mean" (produced in step 1) the columns of the combined datset are reduced down to only those relating to "std" or "mean".

### 3. Apply descriptive activity names and labels

Using the data held in the activity_labels.txt file, descriptive activity labels are merged with the dataset and the columns renamed using descriptive features obtained from the list of features pertaining to "std" or "mean" gathered in step 1.

### 4. Create tidy data set
Finally a tidy data file (tidydata.txt) is written to the current working directory. This file contains the average of each variable for each activity and each subject, which is calculated using the aggregate() function.


 
