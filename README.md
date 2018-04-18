# getting_and_cleaning_data_project

project week4 for Coursera "getting_and_cleaning" course

##For Citation of RAW data set: 
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================
A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the RAW data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
==================================================================

##Transformation steps:

###Cleaning Data steps:
* clean up the spaces delimiting data and split data into columns
* filter out any true blank columns and rows(with all values being blank)
* We name the variables in training and test data sets with list of names from features.txt
* Adding activity labels  from y_train.txt and y_test.txt files to train and test data sets 
* Adding subject lables  from subject_train.txt and subject_test.txt files to train and test data sets 

###Data Preparation steps:
* Merging train and test  data sets vertically.
* Extracted only the measurements on the mean and standard deviation for each measurement.
* converting all means and std columns to class numeric
* merge this data set horizontally with activity_labels.txt to get training activity class descriptions

###I/O steps: 
* below are the commands executed at R console to write data set to disk before upload to github.
* write.csv(tdydt, file = "C:/Users/smohampc/Documents/Coursera/getting_and_cleaning_data/project/avg_tidy_data.txt",row.names=FALSE)
* write.csv(my_data, file = "C:/Users/smohampc/Documents/Coursera/getting_and_cleaning_data/project/tidy_data.txt",row.names=FALSE)


The final datasets/Files 	| 	Details
-------------------------------------------------------------------------
 'README.txt'		|
 'codebook.txt'		| contains variable categories and naming terminology for each variable
 'features.txt'		| list of varaibles for tidy data set
 'tidy_data.txt'	| tidy data set as a result of merging raw train and raw test data sets and subsetting by variables relating to mean and standard deviation measurements
 'avg_tidy_data.txt'| shows averages of  each variable for each activity and each subject of data set tidy_data.txt




##Notes: 
* All these steps below are aligned as per the steps in Rscript provided with the data set. 
*For more information about this dataset contact: itsamermo@gmail.com

*License*
*Refer to original license for raw data obtained 
from here. https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


