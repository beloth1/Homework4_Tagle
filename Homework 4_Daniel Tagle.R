
#title: "Homewok 4"
#author: "Danny Tagle"
#date: "July 3, 2018"
#output: html_document



#Calling libraries
library(reshape2)
library(dplyr)
library(DescTools)




#Setting the working directory
work_directory <-"C:/Users/Danny/Documents/Data Tools and Techniques/Homework 4"
setwd(work_directory)

#Getting Features data
features <- read.table("features.txt")

#Create variable list 
variablelist <- features$V2

#Find the mean and std variables in the features data set
std_mean_variables <- variablelist %like any% c("%mean%", "%std%")

features$V3 <- std_mean_variables

#Creating feature list of only mean and std
features2 <- features[features$V3 == "TRUE",]
#add to list
vlist <- features2$V2

#Read in subject test data
subject_test <- read.table("./test/subject_test.txt")
#Rename the key variable
names(subject_test) <- "SubjectID"
#Add dataset identitfier
subject_test$set <- "test"

#Read in X test data
x_test <- read.table("./test/X_test.txt")
#Rename x test data columns
names(x_test) <- features$V2
#Keeping only where variables are in features2 which is only mean and std
x_test <- x_test[paste(vlist,sep=",")]

#Read in the Y test data
y_test <- read.table("./test/y_test.txt")
#Renaming y variable
names(y_test) <- "activity_outcome"

#Read in the inertia signal data from test
body_acc_x_test <- read.table("./test/Inertial Signals/body_acc_x_test.txt")
body_acc_y_test <- read.table("./test/Inertial Signals/body_acc_y_test.txt")
body_acc_z_test <- read.table("./test/Inertial Signals/body_acc_z_test.txt")
body_gyro_x_test <- read.table("./test/Inertial Signals/body_gyro_x_test.txt")
body_gyro_y_test <- read.table("./test/Inertial Signals/body_gyro_y_test.txt")
body_gyro_z_test <- read.table("./test/Inertial Signals/body_gyro_z_test.txt")
total_acc_x_test <- read.table("./test/Inertial Signals/total_acc_x_test.txt")
total_acc_y_test <- read.table("./test/Inertial Signals/total_acc_y_test.txt")
total_acc_z_test <- read.table("./test/Inertial Signals/total_acc_z_test.txt")

#Read in subject train data
subject_train <- read.table("./train/subject_train.txt")
#Rename the key variable
names(subject_train) <- "SubjectID"
#Add dataset identitfier
subject_train$set <- "train"

#Read in X train data
x_train <- read.table("./train/X_train.txt")
#Rename x train data columns
names(x_train) <- features$V2
#Keeping only where variables are in features2 which is only mean and std
x_train <- x_train[paste(vlist,sep=",")]

#Read in the Y train data
y_train <- read.table("./train/y_train.txt")
#Rename y variable
names(y_train) <- "activity_outcome"

#Read in the inertia signal data from train
body_acc_x_train <- read.table("./train/Inertial Signals/body_acc_x_train.txt")
body_acc_y_train <- read.table("./train/Inertial Signals/body_acc_y_train.txt")
body_acc_z_train <- read.table("./train/Inertial Signals/body_acc_z_train.txt")
body_gyro_x_train <- read.table("./train/Inertial Signals/body_gyro_x_train.txt")
body_gyro_y_train <- read.table("./train/Inertial Signals/body_gyro_y_train.txt")
body_gyro_z_train <- read.table("./train/Inertial Signals/body_gyro_z_train.txt")
total_acc_x_train <- read.table("./train/Inertial Signals/total_acc_x_train.txt")
total_acc_y_train <- read.table("./train/Inertial Signals/total_acc_y_train.txt")
total_acc_z_train <- read.table("./train/Inertial Signals/total_acc_z_train.txt")

#Reading in the activity label data
activity_label <- read.table("activity_labels.txt")
#Naming the activity label columns
names(activity_label)<-c("activityID","activity")

#Combining the training data
train <- cbind(subject_train,x_train,y_train)
#Combining the testing data
test <- cbind(subject_test,x_test,y_test)
#Combiining all the data
data <- rbind(train,test)

## GET ACTIVITY LABELS
finaldata<-merge(data,activity_label)
finaldata$activityID <- NULL

#Summarizing the data
finaldata3<-finaldata


#using the aggregate function
summary_data = aggregate(finaldata3[,names(finaldata3) != c('SubjectID','activity_outcome','set')],by=list(SubjectID=finaldata3$SubjectID,activity_outcome=finaldata3$activity_outcome),mean,na.rm=TRUE)


#Removing extra columns
summary_data$set <- NULL
summary_data$activity <- NULL
summary_data <- summary_data[,-82]

#Renaming columns
names(finaldata) <- gsub("-","_",names(finaldata))
names(finaldata) <- gsub("\\()","_",names(finaldata))

names(summary_data) <- gsub("-","_",names(summary_data))
names(summary_data) <- gsub("\\()","_",names(summary_data))

#Exporting the csv files
write.csv(finaldata, "C:/Users/Danny/Documents/Data Tools and Techniques/Homework 4/tidydata.csv")
write.csv(summary_data, "C:/Users/Danny/Documents/Data Tools and Techniques/Homework 4/Daniel_Tagle_tidydata.csv")
