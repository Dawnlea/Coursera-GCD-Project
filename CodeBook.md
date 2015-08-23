# CodeBook for the Getting and Cleaning Data Project

 This codebook details the variables, the data and any transformations that were performed to clean up the data.

## Source Data
The data set can be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and pertains to experiments carried out by UCI as part of their research into Human Activity Recognition Using Smartphone data. From the readme.txt file supplied with the data set, the following description of the experiments is provided:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

### Record attributes:

For each record, the following attributes are provided

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

### The dataset includes the following files:

* README.txt

* features_info.txt - Shows information about the variables used on the feature vector.

* features.txt - List of all features.

* activity_labels.txt - Links the class labels with their activity name.

* train/X_train.txt - Training set.

* train/y_train.txt - Training labels.

* test/X_test.txt - Test set.

* test/y_test.txt - Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

* train/subject_train.txt - Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

* train/Inertial Signals/total_acc_x_train.txt - The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

* train/Inertial Signals/body_acc_x_train.txt - The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

* train/Inertial Signals/body_gyro_x_train.txt - The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

## Transformation

The transformation of the UCI data set (into a tidy data set comprising the averages of each variable pertaining to "std"" or "mean" for each activity and each subject) is carried out by the run_analysis.r script. This script relies upon the UCI dataset been downloaded into a subdirectory (within the current working directory) entitled "UCI HAR Dataset", and contains the following processing steps:

### 1. Read the data

The script begins by reading the following files into individual tables:

* UCI HAR Dataset/features.txt
* UCI HAR Dataset/activity_labels.txt
* UCI HAR Dataset/train/subject_train.txt
* UCI HAR Dataset/train/X_train.txt
* UCI HAR Dataset/train/y_train.txt
* UCI HAR Dataset/test/subject_test.txt
* UCI HAR Dataset/test/y_test.txt
* UCI HAR Dataset/test/X_test.txt

Those features pertaining to "std" or "mean" are then extracted from the features table using grep().

### 2. Merge the data

The various files of the training data (subject_train.txt, X_train.txt and y_train.txt) are merged using row number as a common key. The same process is performed on the test dataset (subject_test.txt, y_test.txt and X_test.txt) before the two resultant tables are combined using rbind(). Using the list of features pertaining to "std" or "mean" (produced in step 1) the columns of the combined datset are reduced down to only those relating to "std" or "mean".

### 3. Apply descriptive activity names and labels

Using the data held in the activity_labels.txt file, descriptive activity labels are merged with the dataset and the columns renamed using descriptive features obtained from the list of features pertaining to "std" or "mean" gathered in step 1.

### 4. Create tidy data set
Finally a tidy data file (tidydata.txt) is written to the current working directory. This file contains the average of each variable for each activity and each subject, which is calculated using the aggregate() function.


## Tidy data set description

The tidy data set contains 180 observations, each with the following variables:

Variable Name                  | Data Type
------------------------------ | -------------
activitylabel                  | Character
activityid                     | Numeric
subjectid                      | Numeric
tBodyAccmean()X	               | Double
tBodyAccmean()Y	               | Double
tBodyAccmean()Z	               | Double
tBodyAccstd()X	               | Double
tBodyAccstd()Y	               | Double
tBodyAccstd()Z	               | Double
tGravityAccmean()X	           | Double
tGravityAccmean()Y	           | Double
tGravityAccmean()Z	           | Double
tGravityAccstd()X	             | Double
tGravityAccstd()Y	             | Double
tGravityAccstd()Z	             | Double
tBodyAccJerkmean()X	           | Double
tBodyAccJerkmean()Y	           | Double
tBodyAccJerkmean()Z	           | Double
tBodyAccJerkstd()X	           | Double
tBodyAccJerkstd()Y 	           | Double
tBodyAccJerkstd()Z	           | Double
tBodyGyromean()X	             | Double
tBodyGyromean()Y	             | Double
tBodyGyromean()Z	             | Double
tBodyGyrostd()X	               | Double
tBodyGyrostd()Y	               | Double
tBodyGyrostd()Z	               | Double
tBodyGyroJerkmean()X	         | Double
tBodyGyroJerkmean()Y	         | Double
tBodyGyroJerkmean()Z        	 | Double
tBodyGyroJerkstd()Y	           | Double
tBodyGyroJerkstd()Z	           | Double
tBodyAccMagmean()	             | Double
tBodyAccMagstd()	             | Double
tGravityAccMagmean()	         | Double
tGravityAccMag-std()	         | Double
tBodyAccJerkMag-mean()         | Double
tBodyAccJerkMagstd()	         | Double
tBodyGyroMagmean()   	         | Double
tBodyGyroMagstd()	             | Double
tBodyGyroJerkMagmean()	       | Double
tBodyGyroJerkMagstd()	         | Double
fBodyAccmean()X	               | Double
fBodyAccmean()Y	               | Double
fBodyAccmean()Z	               | Double
fBodyAccstd()X	               | Double
fBodyAccstd()Y	               | Double
fBodyAccstd()Z	               | Double
fBodyAccmeanFreq()X       	   | Double
fBodyAccmeanFreq()Y	           | Double
fBodyAccmeanFreq()Z	           | Double
fBodyAccJerkmean()X	           | Double
fBodyAccJerkmean()Y	           | Double
fBodyAccJerkmean()Z	           | Double
fBodyAccJerkstd()X	           | Double
fBodyAccJerkstd()Y	           | Double
fBodyAccJerkstd()Z             | Double
fBodyAccJerkmeanFreq()X	       | Double
fBodyAccJerkmeanFreq()Y	       | Double
fBodyAccJerkmeanFreq()Z        | Double
fBodyGyromean()X	             | Double
fBodyGyromean()Y	             | Double
fBodyGyrostd()X	               | Double
fBodyGyrostd()Y	               | Double
fBodyGyrostd()Z	               | Double
fBodyGyromeanFreq()X	         | Double
fBodyGyromeanFreq()Y	         | Double
fBodyGyromeanFreq()Z	         | Double
fBodyAccMagmean()	             | Double
fBodyAccMagstd()	             | Double
fBodyAccMagmeanFreq()	         | Double
fBodyBodyAccJerkMagmean()	     | Double
fBodyBodyAccJerkMagstd()	     | Double
fBodyBodyAccJerkMagmeanFreq()	 | Double
fBodyBodyGyroMagmean()	       | Double
fBodyBodyGyroMagstd()	         | Double
fBodyBodyGyroMagmeanFreq()     | Double
fBodyBodyGyroJerkMagmean()     | Double
fBodyBodyGyroJerkMagstd()	     | Double
fBodyBodyGyroJerkMagmeanFreq() | Double

 
