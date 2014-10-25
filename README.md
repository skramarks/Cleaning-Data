The script run_analysis.R expectes to find the dataset  in directory named smarphone.

The dataset get be fectched from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Details on the dataset can be found here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The script uses the following files from this dataset:
    smartphone/features.txt
    smartphone/activity_labels.txt
    smartphone/test/X_test.txt
    smartphone/test/subject_test.txt
    smartphone/test/Y_test.txt
    smartphone/train/X_train.txt
    smartphone/train/subject_train.txt
    smartphone/train/Y_train.txt
    
Refer to the link above for details on the information in the files.

run_analysis.R performs the following steps:

    1) Merges the training and the test sets to create one data set.
    2) Extracts only the measurements on the mean and standard deviation for each measurement. 
    3) Uses descriptive activity names to name the activities in the data set
    4) Appropriately labels the data set with descriptive variable names. 
    5)From the data set in step 4, creates a second, independent tidy data set with the average of each 
      variable for each activity and each subject.

