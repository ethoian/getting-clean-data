##getting and cleaning data course work week3
### create a directory where you can store all the data
Line 1-3
The directory is ./data
check if it already exists otherwise create the directory.data
### download and unzip Dataset.zip
line 5-10
check if the file has not been already been downloaded
if not proceed to the download to directory ./data
and store it into the variable fileURL 
unzip the Dataset.zip in the directory .data
## Read files and uploaded them into a dataframe call files
Line 12-13
the subfolder "UCI HAR Dataset" in folder ./data contains all the data:
- a folder "test"
- a folder "train"
- activity labels in a text document "activity_labels"
- features labels in a text document "features"
- feature information in a text document "features_info"
- a Readme txt
Line 12- we load the directory path to "UCI HAR Dataset" folder into a variable dir_data using file.path
Line 13- we read recursively all the files in "UCI HAR Dataset" and load them into dataframe files
## Read the data from the files and load them into variables
The data is split into training data and testing data.
- training data values are in : X_train.txt
- testing data values are in: X_test.txt
- the features data are in:
-- the X_train.txt and X_test.txt
The subjects variables are in
- subject_train.txt for subject in training data set
- subject_test.txt for subject in testing data set
The level of activities are in activity_labels.txt
Line 16-23 we are going to read data from the files and store them into variables
Line 16-17 Read the Activity files both Training and Test
Line 19-20 Read the Subject files both Training and Test
Line 22-23 Read the Features files both Training and Test
## 1- Merge the Training and Test Set to Create One Data Set
Line 27 ActivityData Training and Test Data merging with rbind 
Line 28 SubjectData Training and Test Data merging with rbind
Line 29 FeaturesData Training and Test Data merging with rbind
Line 31-34 gives names to variables
## Merge columns to create consolidated dataframe "mergeColData"
Line 36 combine data using cbind on subjectData and activityData
Line 37 combine the above data with featuresData into a consolidated mergeColData data frame
## Extacts only the measurements on the mean and std deviation for each measurement
Line 42 extracts only measurements that have mean and/or std deviation
Line 45 subset the data frame "mergeColData" by selected names of Features
Line 49 read activity names from "activity_labels"
## label the data with descriptive variable names
line 51-56 Labels the date set with descriptive variables
## Create a second, independent tidy data set with the average of each activity and subject
line 59-60 aggregate and merge using plyr
line 61 write file tidymergeColData.txt into ./data
