# check if ./data directory exits
if (!file.exists("./data")){
     dir.create("./data")}
#check if Dataset.zip has been already downloaded in ./data
if (!file.exists("./data/Dataset.zip")){
  fileUrl<-("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
  download.file(fileUrl,destfile="./data/Dataset.zip")}

# unzip Dataset.zip into ./data
unzip(zipfile="./data/Dataset.zip",exdir="./data")
# read files
dir_data <- file.path("./data","UCI HAR Dataset")
files<-list.files(dir_data,recursive=TRUE)
# read data from the files into variables
# read activity files
activityDataTest <- read.table(file.path(dir_data,"test","Y_test.txt"),header=FALSE)
activityDataTrain <- read.table(file.path(dir_data,"train","Y_train.txt"),header=FALSE)
# read subject files
subjectDataTest <- read.table(file.path(dir_data,"test","subject_test.txt"),header=FALSE)
subjectDataTrain <- read.table(file.path(dir_data,"train","subject_train.txt"),header=FALSE)
# read feattures files
featuresDataTest <- read.table(file.path(dir_data,"test","X_test.txt"),header=FALSE)
featuresDataTrain <- read.table(file.path(dir_data,"train","X_train.txt"),header=FALSE)

#1- MERGE THE TRAINING AND THE TEST SET TO CREATE ONE DATA SET.
# concatenate data tables by rows
activityData <- rbind(activityDataTest, activityDataTrain)
subjectData <- rbind(subjectDataTest, subjectDataTrain)
featuresData <- rbind(featuresDataTest, featuresDataTrain)
#give names to variables
names(activityData)<-c("activity")
names(subjectData)<-c("subject")
featuresDataNames<-read.table(file.path(dir_data,"features.txt"),head=FALSE)
names(featuresData)<-featuresDataNames$V2
#merge columns to create consolidated dataframe "mergeColData"
combineData <-cbind(subjectData,activityData)
mergeColData <-cbind(featuresData,combineData)

#2- EXTRACTS ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT
# Subset name of features by measurements on the mean and std deviation
# aka taken Names of Features with "mean()" or "std()"
subfeaturesDataNames<- featuresDataNames$V2[grep("mean\\(\\)|std\\(\\)",featuresDataNames$V2)]
#3- USES DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET
# Subset the data frame "mergeColData" by selected names of Features
selectedNames<-c(as.character(subfeaturesDataNames),"subject","activity")
mergeColData<-subset(mergeColData,select=selectedNames)
#3- USES DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET
#Read descriptive activity names from "activity_labels.text"
activityLabels <- read.table(file.path(dir_data,"activity_labels.txt"),header=FALSE)
#4- APPROPRIATELY LABELS THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES
names(mergeColData) <- gsub("^t","time",names(mergeColData))
names(mergeColData) <- gsub("^f","frequency",names(mergeColData))
names(mergeColData) <- gsub("Acc","Accelerometer",names(mergeColData))
names(mergeColData) <- gsub("Gyro","Gyroscope",names(mergeColData))
names(mergeColData) <- gsub("Mag","Magnitude",names(mergeColData))
names(mergeColData) <- gsub("BodyBody","Body",names(mergeColData))
#5- CREATES A SECOND, INDEPENDENT TIDY DATA SET WITH THE AVERAGE OF EACH ACTIVITY AND EACH SUBJECT
library(plyr);
mergeColData2 <- aggregate(.~subject + activity, mergeColData, mean)
mergeColData2 <- mergeColData2[order(mergeColData2$subject,mergeColData2$activity),]
write.table(mergeColData2,file="./data/tidymergeColData.txt",row.name=FALSE)
