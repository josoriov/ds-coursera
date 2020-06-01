# Libraries used
library(data.table)
library(dplyr)

# Download the zip file
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile="data.zip")

# Extract the zip file
unzip("data.zip")

# Renaming the folder with the data
file.rename("UCI HAR Dataset", "data")
file.remove("data.zip")

# Getting the test data
test_values <- fread("./data/test/X_test.txt", header = F, sep = " ")
test_labels <- fread("./data/test/y_test.txt", header = F, sep = " ")
test_all <- cbind(test_values, test_labels)
rm(test_values, test_labels)
names(test_all)[[length(test_all)]] <- "activity"
# Getting the train data
train_values <- fread("./data/train/X_train.txt", header = F, sep = " ")
train_labels <- fread("./data/train/y_train.txt", header = F, sep = " ")
train_all <- cbind(train_values, train_labels)
rm(train_values, train_labels)
names(train_all)[[length(train_all)]] <- "activity"
all_data <- rbind(train_all, test_all)
rm(test_all, train_all)

# Getting the features and labels
features <- fread("./data/features.txt", header = F, sep = " ")
activities <- fread("./data/activity_labels.txt", header = F, sep = " ")

# Function to format the features according to my preference
my_str_format <- function(some_string) {
  a <- gsub(",", "_", some_string)
  a <- gsub("-", "_", a)
  a <- gsub("\\(", "", a)
  a <- gsub("\\)", "", a)
  a <- gsub("tBody", "timeBody", a)
  a <- gsub("tGravity", "timeGravity", a)
  a <- gsub("BodyBody", "Body", a)
  a <- gsub("fBody", "frequencyBody", a)
  return(a)
}

activities[, 2] <- apply(activities[, 2], 1, tolower) # Parsing activity names as lowercase
features[, 2] <- apply(features[, 2], 1, my_str_format) # Parsing features with custom format
names(all_data)[1:561] <- as.vector(features$V2) # Assigning names to variables

# Takes an activity label and returns the activity name
set_label <- function (label_value) {
  return(activities[activities$V1 == label_value, 2][[1]])
}

# Correctly setting activity names
all_data[, 562] <- apply(all_data[, 562], 1, set_label)

# Creating a data table with the mean and sd info by activity
mean_data <- aggregate(all_data[, 1:561], list(all_data$activity), mean)
sd_data <- aggregate(all_data[, 1:561], list(all_data$activity), sd)

# Function to concatenate any 2 given strings
cat_string <- function (og_string, to_cat) {
  return(paste(og_string, to_cat, sep=""))
}

# Adding the suffix of correspondece 
mean_data[, 1] <- sapply(mean_data[, 1], cat_string, to_cat="_mean")
sd_data[, 1] <- sapply(sd_data[, 1], cat_string, to_cat="_sd")

# Merging the data tables
all_stats <- rbind(mean_data, sd_data)
rm(mean_data, sd_data)
names(all_stats)[[1]] <- "activity_stat"

# Writing the data to csv files
write.table(all_data, "complete_data.txt", row.name=F)
write.table(all_stats, "stats_summary.txt", row.name=F)
