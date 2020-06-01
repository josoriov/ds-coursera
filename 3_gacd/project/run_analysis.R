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

# Getting the test data
test_values <- fread("./data/test/X_test.txt", header = F, sep = " ")
test_labels <- fread("./data/test/y_test.txt", header = F, sep = " ")
test_all <- cbind(test_values, test_labels)
rm(test_values, test_labels)
names(test_all)[[length(test_all)]] <- "label"
# Getting the train data
train_values <- fread("./data/train/X_train.txt", header = F, sep = " ")
train_labels <- fread("./data/train/y_train.txt", header = F, sep = " ")
train_all <- cbind(train_values, train_labels)
rm(train_values, train_labels)
names(train_all)[[length(train_all)]] <- "label"
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
  a <- gsub("fBody", "fourierBody", a)
  return(a)
}

activities[, 2] <- apply(activities[, 2], 1, tolower) # Parsing activity labels as lowercase
features[, 2] <- apply(features[, 2], 1, my_str_format) # Parsing features with custom format
names(all_data)[1:561] <- as.vector(features$V2) # Assigning names to variables

# Takes an activity num and returns the activity label
set_label <- function (label_value) {
  return(activities[activities$V1 == label_value, 2][[1]])
}

# Correctly setting activity labels and exporting the table to a csv
all_data[, 562] <- apply(all_data[, 562], 1, set_label)
write.csv(all_data, "complete_data.csv")

# Creating a data table with the mean and sd info by activity
mean_data <- aggregate(all_data[, 1:561], list(all_data$label), mean)
sd_data <- aggregate(all_data[, 1:561], list(all_data$label), sd)

# Function to concatenate any 2 given strings
cat_string <- function (og_string, to_cat) {
  return(paste(og_string, to_cat, sep=""))
}

# Adding the suffix of correspondece 
mean_data[, 1] <- sapply(mean_data[, 1], cat_string, to_cat="_mean")
sd_data[, 1] <- sapply(sd_data[, 1], cat_string, to_cat="_sd")

# Merging the data tables and exporting the result to a csv
all_stats <- rbind(mean_data, sd_data)
rm(mean_data, sd_data)
names(all_stats)[[1]] <- "activity_stat"
write.csv(all_data, "stats_summary.csv")