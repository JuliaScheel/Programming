GETTING AND CLEANING DATA: COURSE PROJECT

ABOUT REPOSITORY
This repository contains my work for the course R programming AND GETTING AND CLEANING DATA. Both coruses are part of the Data Science specialization.  

ABOUT RAW DATA (getting and cleaning data course project)
The data has been downloaded here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
This data contains the information: "subjects" "activity" and "features". 
- "activity" is coded (in downloaded folder as y_test.txt)
-  activity labels are in activity_labels.txt
- "features" is unlabeled (in downloaded folder as x_test.txt). In total 561 features are in the file
- the subjects are in subject_test.txt

ASSUMPTIONS
- the UCI HAR Dataset is downloaded and unzipped into the folder "UCI HAR Dataset"

ABOUT SCRIPT
The script for this project is run_analysis.R which
- loads files from the downloaded folder
- merges training sets
- calculates mean and std of columns of interest
- makes a tydier new data table
- relabelles "activity" acording to "activity_labels.txt"
