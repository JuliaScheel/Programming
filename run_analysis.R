setwd("E:/Documents and Settings/Y5187122S/Mis documentos/Downloads/UCI HAR Dataset")
#check that those two packages are loaded!
library(plyr)
library(data.table)

##1.) Merges the training and the test sets to create one data set
#load data
subjectTrain = read.table('./train/subject_train.txt',header=FALSE)
xTrain = read.table('./train/x_train.txt',header=FALSE)
yTrain = read.table('./train/y_train.txt',header=FALSE)

subjectTest = read.table('./test/subject_test.txt',header=FALSE)
xTest = read.table('./test/x_test.txt',header=FALSE)
yTest = read.table('./test/y_test.txt',header=FALSE)
#merge data

xData <- rbind(xTrain, xTest)
yData <- rbind(yTrain, yTest)
subject <- rbind(subjectTrain, subjectTest)

##Extracts only the measurements on the mean and standard deviation for each measurement
## xData is a subset of the columns of interest (newsubset standarddeviation(std) and mean

xDataSet_mean_std <- xDataSet[, grep("-(mean|std)\\(\\)", read.table("features.txt")[, 2])]
names(xDataSet_mean_std) <- read.table("features.txt")[grep("-(mean|std)\\(\\)", read.table("features.txt")[, 2]), 2] 

##3. Use descriptive activity names to name the activities in the data set
#get activity names from "activity_labels.txt"
yData[, 1] <- read.table("activity_labels.txt")[yData[, 1], 2]
names(yData) <- "Activity"

##4. Appropriately label the data set with descriptive activity names
names(subject) <- "Subject"
summary(subject)

# Organizing and combining all data sets into single one.

singleData <- cbind(xDataSet_mean_std, yData, subject)

# Defining descriptive names for all variables.

names(singleData) <- make.names(names(singleData))
names(singleData) <- gsub('Acc',"Acceleration",names(singleData))
names(singleData) <- gsub('GyroJerk',"AngularAcceleration",names(singleData))
names(singleData) <- gsub('Gyro',"AngularSpeed",names(singleData))
names(singleData) <- gsub('Mag',"Magnitude",names(singleData))
names(singleData) <- gsub('^t',"TimeDomain.",names(singleData))
names(singleData) <- gsub('^f',"FrequencyDomain.",names(singleData))
names(singleData) <- gsub('\\.mean',".Mean",names(singleData))
names(singleData) <- gsub('\\.std',".StandardDeviation",names(singleData))
names(singleData) <- gsub('Freq\\.',"Frequency.",names(singleData))
names(singleData) <- gsub('Freq$',"Frequency",names(singleData))


##5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
# final_data = organized data frame of "analyzed data"

final_data <-aggregate(. ~Subject + Activity, singleData, mean)
final_data <-final_data[order(final_data$Subject,final_data$Activity),]
