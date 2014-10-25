library(data.table)
library(dplyr)
library(tidyr)

#
# map_activity - converts the activity_num to a human readible format
#
map_activity <- function(activity_num) {
    as.character(activity.hdr[activity_num, 2])
}

# grab the column headers for features
features <- read.table("smartphone/features.txt", header=FALSE)

# grab the column header for the activities
hdrs <- as.character(features[,2])
activity.hdr <- read.table("smartphone/activity_labels.txt")

#
# For the test data
#

# read the test data & insert headers
test <-read.table("smartphone/test/X_test.txt")
names(test) <- hdrs

# read the test subject data and insert the headers
subject <-  read.table("smartphone/test/subject_test.txt")
test$Subject <- subject[,1]
names(test$Subject) <- "Subject"

activity.test <- read.table("smartphone/test/Y_test.txt")
test$Activity <- sapply(activity.test, map_activity, simplify = "vector")
names(test$Activity) <- "Activity"


#
# For the training data
#

# read the training data & insert headers
train <-read.table("smartphone/train/X_train.txt")
names(train) <- hdrs

# read the training subject data and insert the headers
subject <- read.table("smartphone/train/subject_train.txt")
train$Subject <- subject[,1]
names(train$Subject) <- "Subject"

# read in the activity information to for the test dataset.
# convert it to a readabile format and merge it into the test
# dataset.  Also insert column header.
activity.train <- read.table("smartphone/train/Y_train.txt")
train$Activity <- sapply(activity.train, map_activity, simplify = "vector")
names(train$Activity) <- "Activity"


#
# merge the data sets 
dataset <- rbind(test, train)

#
# extract only the the subject, activity, and colmns that have std() or mean() in the names.
subset <-dataset[, grep("Std|Mean|Activity|Subject", names(dataset), ignore.case=TRUE)]
subset$Activity <- factor(subset$Activity) 

tidy.subset <- subset %>%
    tbl_df() %>%
    arrange(Subject, Activity) %>%
    gather(Attribute, Value, -Subject, -Activity)


#
# Group the data by Subject and Activty and generate means for all of the
# variable in each group.
#

tidy.mean.subset <- tidy.subset %>%
    tbl_df() %>%
    group_by(Subject, Activity, Attribute) %>%
    summarise_each(funs(mean)) %>%
    arrange(Subject, Activity) 

# save the results
write.table(tidy.mean.subset, "tidy.mean.subset.csv", row.name=FALSE, )



