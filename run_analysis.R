library(data.table)

map_activity <- function(activity_num) {
    as.character(activity.hdr[activity_num, 2])
}

# grab the column headers
features <- read.table("smartphone/features.txt")

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

test$subject <-  list(read.table("smartphone/test/subject_test.txt"))
names(test$subject) <- "subject"

activity.test <- read.table("smartphone/test/Y_test.txt")
test$activity <- sapply(activity.test, map_activity)
names(test$activity) <- "activity"





# For the training data:
#
# 1. read the data
# 2. insert the column headers
# 3. select only the columns that have std() or mean() in the name
#
train <-read.table("smartphone/train/X_train.txt")
names(train) <- hdrs

train$subject <- list(read.table("smartphone/train/subject_train.txt"))
names(train$subject) <- "subject"


activity.train <- read.table("smartphone/train/Y_train.txt")
train$activity <- sapply(activity.train, map_activity)
names(train$activity) <- "activity"



# merge the data sets and save them.
dataset <- rbind(test, train)

datatable <- data.table(dataset)



subset <-dataset[, grep("std\\(\\)|mean\\(\\)", names(dataset))]



# save the results
write.csv(subset, "subset.csv")


# R is mungning the colum names.  Grab the munged names.
#hdrs <-names(test)


