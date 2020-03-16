Getting and Cleaning Data
================

**Iyen-osa Iyamuosa**

## **Project Summary**

The goal of this project is to create a tidy data data set using R to
analyze experimental results which were captured in the [Human Activity
Recognition Using
Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
study.

The `run_analysis.R` script will complete the following steps when run
on the
[data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
to transform the data into a tidy set that we are able to glean
information out of.

1.  Merges the training and the test sets to create one data set.

2.  Extracts only the measurements on the mean and standard deviation
    for each measurement.

3.  Uses descriptive activity names to name the activities in the data
    set

4.  Appropriately labels the data set with descriptive variable names.

5.  From the data set in step 4, creates a second, independent tidy data
    set with the average of each variable for each activity and each
    subject.

## **Repository Information**

This repository contains 4 main files:

`README.md`

`run_analysis.R` - Builds up and performs the analysis on the required
sample data.

`tidy.txt` - Final output from the run\_analysis.R script. It contains a
cleansed version of the original data.

`CodeBook.md` - Defines and lists each of the columns in our generated
tidy.txt file.
