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
features <- read.tablesub("smartphone/features.txt")

# grab the column header for the activities
hdrs <- as.character(features[,2])
activity.hdr <- read.table("smartphone/activity_labels.txt")

# For the test data
#
# 1. read the data
# 2. insert the column headers
# 3. select only the columns that have std() or mean() in the name
#


test <-read.table("smartphone/test/X_test.txt")
names(test) <- hdrs

subject <-  read.table("smartphone/test/subject_test.txt")
test$subject <- factor(subject[,1])
names(test$subject) <- "subject"

activity.test <- read.table("smartphone/test/Y_test.txt")
test$activity <- sapply(activity.test, map_activity, simplify = "vector")
names(test$activity) <- "activity"





# For the training data:
#
# 1. read the data
# 2. insert the column headers
# 3. select only the columns that have std() or mean() in the name
#
train <-read.table("smartphone/train/X_train.txt")
names(train) <- hdrs

subject <- read.table("smartphone/train/subject_train.txt")
train$subject <- factor(subject[,1])
names(train$subject) <- "subject"


activity.train <- read.table("smartphone/train/Y_train.txt")
train$activity <- sapply(activity.train, map_activity, simplify = "vector")
names(train$activity) <- "activity"



# merge the data sets and save them.
dataset <- rbind(test, train)

datatable <- data.table(dataset)

#subset <-dataset[, grep("std\\(\\)|mean\\(\\)", names(dataset))]

subset <-dataset[, grep("std\\(\\)|mean\\(\\)|activity|subject", names(dataset))]
subset$activity <- factor(subset$activity)

subset1 <- group_by(subset, activity, subject)



#### method #2 melting

melted <- melt(subset, id.vars=c("activity", "subject"))
dcast(melted, activity ~ variable, fun=mean)
dcast(melted, subject ~ variable, fun=mean)

name# save the results
write.csv(subset, "subset.csv")


# R is mungning the colum names.  Grab the munged names.
#hdrs <-names(test)



