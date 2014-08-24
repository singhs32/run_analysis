Summary
=======
run_analysis function reads the zip data file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and creates a file in the running directory called tidydata.txt. This file shows an independent tidy data set with the average of each variable for each activity and each subject.


This submission includes the following files:
=============================================

- 'README.txt'

- 'codebook.txt': Explain the fields in tidydata.txt

- 'tidydata.txt': Final output

- "run_analysis.R": R code for transforming raw data into tidy data


Detailed explanation of how raw data was tranformed into tidy data
===================================================================
Internally the functions performs the following steps to produce output

1 - Reads the zip data file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2 - Unzips the downloaded file

3 - Reads the data files namely "X_train.txt", "Y_train.txt", and "subject_train.txt" from training folder and coresponding files from the test folder to create a single data set. Note that this data set only has the mean and standard deviation measurements from "x_train.txt" and "x_test.txt" files

4 - Adds activity descriptions by joining the resulting data with activity_labels.txt file data

5 - Finally, uses melt and dcast functions to create and write a file in the running directory called tidydata.txt. This file shows an independent tidy data set with the average of each variable for each activity and each subject.
