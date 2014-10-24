library(data.table)
library(dplyr)
library(reshape2)

#
# map_activity - converts the activity_num to a human readible format
#
map_activity <- function(activity_num) {
    as.character(activity.hdr[activity_num, 2])
}

# grab the column headers for features
features <- read.table("smartphone/features.txt")

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
test$subject <- factor(subject[,1])
names(test$subject) <- "subject"

# read in the activity information to for the test dataset.
# convert it to a readabile format and merge it into the test
# dataset.  Also insert column header.
activity.test <- read.table("smartphone/test/Y_test.txt")
test$activity <- sapply(activity.test, map_activity, simplify = "vector")
names(test$activity) <- "activity"


#
# For the training data
#

# read the training data & insert headers
train <-read.table("smartphone/train/X_train.txt")
names(train) <- hdrs

# read the training subject data and insert the headers
subject <- read.table("smartphone/train/subject_train.txt")
train$subject <- factor(subject[,1])
names(train$subject) <- "subject"

# read in the activity information to for the test dataset.
# convert it to a readabile format and merge it into the test
# dataset.  Also insert column header.
activity.train <- read.table("smartphone/train/Y_train.txt")
train$activity <- sapply(activity.train, map_activity, simplify = "vector")
names(train$activity) <- "activity"


#
# merge the data sets 
dataset <- rbind(test, train)

#
# extract only the the subject, activity, and colmns that have std() or mean() in the names.
subset <-dataset[, grep("std\\(\\)|mean\\(\\)|activity|subject", names(dataset))]
subset$activity <- factor(subset$activity)

#
# 
melted <- melt(subset, id.vars=c("activity", "subject"))
dcast(melted, activity ~ variable, fun=mean)
dcast(melted, subject ~ variable, fun=mean)

# save the results
write.csv(melted, "melted.csv")


#
# try it using dplyr

tbl_subset <- subset %>%
    tbl_df() %>%
    group_by(subject, activity) %>%
    summarise_each(funs(mean)) %>%
    arrange(subject, activity)




# R is mungning the colum names.  Grab the munged names.
#hdrs <-names(test)



