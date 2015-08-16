# Getting and Cleaning Data Project

This repository contains the work carried out to satisfy the final project of the Getting and Cleaning Data course.
The contents of this repository are discussed below:

 * UCI HAR Dataset - Data collected from the Samsung Galaxy S Smartphone (downloaded from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
 * run_analysis.r - An R script that processes the dataset and produces a tidy dataset (tidydata.txt) comprising averages for those vraiables pertaining to mean and std for each activity and subject.
 * tidydata.txt - The tidy data set produced by the run_analysis.r script.
 * CodeBook.md - The code book that details the variables, the data and any transformations that were performed to clean up the data.
 
 
## The run_analysis.r script

The script relies upon the UCI HAR Dataset been downloaded into a subdirectory (within the current working directory) entitled "UCI HAR Dataset". The script begins by loading all of the required files from this subdirectory and then extracts only those features pertaining to mean and std from the features.txt file.

The test and training data files are then merged and the variables pertaing to the std and mean are extracted for each subject and activity. Descriptive activity labels are added to the columns of the merged dataset before creating an independent tidy data set with the average of each variable for each activity and each subject. The resultant data set is written away to the tidydata.txt file.