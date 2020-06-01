Getting and Cleaning Data Final Project
---------------------------------------

### Version 1.0

### Juan F. Osorio

### Data Science Specialization - John Hopkins University

This projects takes the data from experiments with the accelerometer of
the Samsung Galaxy S smartphone. The full description of the data could
be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.
The purpose of this project is to clean the data in a specific way such
that the resulting data set is tidy (according to the course criteria).

Two files were the resulting output of the processing. First, the
complete\_data.csv data takes all of the test data and train data and
merge them together in a single big data structure. The second output is
stats\_summary.csv, this file contains the mean and the standard
deviation for every variable in the complete\_data.csv segmented by the
corresponding activity.

### The steps for the processing were:

-   Downloading the zip file and extracting all the data files into a
    folder structure.
-   Reading and merging both train and test data into a single data
    structure.
-   Getting features and activities data.
-   Custom format the string features to make it readble and assign each
    feature to the corresponding variable in the merged data structure.
-   Replacing the activity labels for the matching activity names.
-   Calculate the mean and standard deviation for each variable
    segmented by activity name.
-   Merging the mean and standard deviation data structures into a
    single one.
-   Exporting both output files to csv format.

### The dataset includes the following files:

-   'README.txt'

-   'codebook.txt'

-   'complete\_data.txt': Shows all the combined train and test data.

-   'stats\_summary.txt': Mean and standard deviation for each variable
    segmented by activity.

-   'run\_analysis.R': R file to do the processing.

### Notes:

-   Features are not re-scaled.
-   Variables are always represented as columns.


### License:

None
