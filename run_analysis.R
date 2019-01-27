# Program:  run_analysis
# Author:   Joseph Conklin
# Date:     January 2019

# Description:  This program fulfills one of the requirements
# of the Getting and Cleaning Data course project.  The project
# requires the creation of a tidy data set from an online source.
# The source is an archive of exercise performance measurements 
# recorded on subject's cell phones during various forms of 
# physical activity.

# The archive is located at https://d396qusza40orc.cloudfront.net/
# getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

# This program assumes the following datasets from the archive have 
# been downloaded to the R working directory:

# X_train.txt           a training dataset containing performance measurements

# X_test.txt            a test dataset containing performance measurements

# features.txt          a dataset containing the names of the performance
#                       measurements

# y_train.txt           a dataset containing the physical activity codes for 
#                       X_train.txt

# y_test.txt            a dataset containing the physical activity codes for 
#                       X_test.txt

# activity_labels.txt   a dataset providing a crosswalk between the physical
#                       activity name and their corresponding numerical codes

# subject_train.txt     a dataset listing the subjects in the training dataset
#                       by numerical code

# subject_test.txt      a dataset listing the subjects in the test dataset
#                       by numerical code

# More information is available in the files CodeBook.md and README.md
# on the Github repo set up for this course project

# Read in activity_labels.txt for activity code crosswalk

crosswalk <- read.table("./activity_labels.txt",header = FALSE)

# Set column names for crosswalk

colnames(crosswalk) <- c("Activity_Code","Activity_Name")

# Read in subject_train.txt for subjects in training dataset

subject_train <- read.table("./subject_train.txt",header = FALSE)

# Set column name for subject_train

colnames(subject_train) <- "Subject"

# Read in subject_test.txt for subjects in test dataset

subject_test <- read.table("./subject_test.txt",header = FALSE)

# Set column name for subject_train

colnames(subject_test) <- "Subject"

# Read in y_train.txt for physical activity codes of 
#subjects in training dataset

y_train <- read.table("./y_train.txt",header = FALSE)

# Set column name for y_train

colnames(y_train) <- "Activity_Code"

# Create index so y_train can resorted back
# into original sequence after merging with
# crosswalk

case <- seq(1,length(y_train),1)

# Bind index to y_train

y_train <- cbind(case,y_train)

# Merge crosswalk to y_train to replace
# numerical codes for physical activities
# with meaningful names

y_train <- merge(y_train,crosswalk,by.x = "Activity_Code",by.y = "Activity_Code")

# Resort y_train to original sequence after
# merge with crosswalk

y_train <- y_train[order(y_train$case),]

# Add variable to y_train to indicate
# data is from training dataset

y_train$Source <- "Training"

# Remove index and physical activity codes
# from y_train as they are no longer needed

y_train <- subset(y_train, select = -c(Activity_Code,case))

# Read in y_test.txt for physical activity codes of 
#subjects in test dataset

y_test <- read.table("./y_test.txt",header = FALSE)

# Set column name for y_test

colnames(y_test) <- "Activity_Code"

# Create index so y_test can resorted back
# into original sequence after merging with
# crosswalk

case <- seq(1,length(y_test),1)

# Bind index to y_test

y_test <- cbind(case,y_test)

# Remove R object no longer needed

rm(case)

# Merge crosswalk to y_train to replace
# numerical codes for physical activities
# with meaningful names

y_test <- merge(y_test,crosswalk,by.x = "Activity_Code",by.y = "Activity_Code")

# Resort y_train to original sequence after
# merge with crosswalk

y_test <- y_test[order(y_test$case),]

# Add variable to y_test to indicate
# data is from test dataset

y_test$Source <- "Test"

# Remove index and physical activity codes
# from y_test as they are no longer needed

y_test <- subset(y_test, select = -c(Activity_Code,case))

# Remove crosswalk as it is no longer needed

rm(crosswalk)

# Combine physical activity data from training
# and test sources into one R object

y <- rbind(y_train,y_test)

# Remove R objects no longer needed

rm(y_train,y_test)

# Combine subject codes from training
# and test sources into one R object

subject <- rbind(subject_train,subject_test)

# Remove R objects no longer needed

rm(subject_train,subject_test)

# Combine subject codes and physical
# activity data into one R object

subject_activity <- cbind(subject,y)

# Remove R objects no longer needed

rm(subject,y)

# Read in features.txt for names of performance
# measurements in training and test datasets

features <- read.table("./features.txt",header = FALSE)

# Remove first column of features as it is
# not needed

features <- features[,-1]

# Extract names of performance measurements 
# containing "mean".  These are part of the 
# measurements to be analyzed

mu <- grep("mean",features,value = TRUE)

# Extract names of performance measurements 
# containing "std".  These are the other part
# of the measurements to be analyzed

sigma <- grep("std",features,value = TRUE)

# Read in X_train.txt, dataset of training performance
# measurements

fitness_train <- read.table("./X_train.txt",header = FALSE)

# Set column names of fitness_train

colnames(fitness_train) <- features

# Extract performance measures from fitness_train
# for analysis

fitness_train <- fitness_train[,c(mu,sigma)]

# Read in X_test.txt, dataset of test performance
# measurements

fitness_test <- read.table("./X_test.txt",header = FALSE)

# Set column names of fitness_test

colnames(fitness_test) <- features

# Extract performance measures from fitness_test
# for analysis

fitness_test <- fitness_test[,c(mu,sigma)]

# Remove R objects no longer needed

rm(features,mu,sigma)

# Bind train and test datasets of performance
# measurements into one R object

fitness_data <- rbind(fitness_train,fitness_test)

# Remove R objects no longer needed

rm(fitness_train,fitness_test)

# Bind performance measurements data with
# subject and activity data into one R
# object

fitness_data <- cbind(subject_activity,fitness_data)

# Remove R object no longer needed

rm(subject_activity)

# Install tidyr package for operations helpful
# to creating tidy dataset

install.packages("tidyr")

# Activate package tidyr

library("tidyr")

# Install dplyr package to perform required
# analysis of performance measurements

install.packages("dplyr")

# Activate package dplyr

library("dplyr")

# Copy fitness_data into data table
# tidyr operations

new_fitness <- tbl_df(fitness_data)

# Gather all performance measurements into
# a single column where values in rows
# indicate particular performance measurement

fitness_gather <- gather(new_fitness,"Fitness_Variable",
                                     "Fitness_Value",
                                   -c(Subject,Activity_Name,Source))

# Take the single column of performance
# measurements and create new variable 
# to indicate whether measurements is 
# mean or std

fitness_gather$Statistic <- ifelse(grepl("mean", fitness_gather$Fitness_Variable),
                                   "mean", "std")

# Move new variable to second from the
# right in the performance measurements
# dataset

fitness_gather <- fitness_gather[,c("Subject","Activity_Name","Source",
                                    "Fitness_Variable","Statistic",
                                     "Fitness_Value")]

# Divide the fitness data into groups for
# analysis

fitness_groups <- group_by(fitness_gather,Subject,Activity_Name,
                           Fitness_Variable,Statistic)

# Compute the means of the performance 
# measurements by group

fitness_summary <- summarize(fitness_groups,
                             Mean_Fitness=mean(Fitness_Value))

# Convert tidy dataset of fitness data into
# a data frame

fitness_data <- data.frame(fitness_gather)

# Convert tidy dataset of analyzed data into
# a data frame

fitness_summary <- data.frame(fitness_summary)

# Remove R objects no longer needed

rm(new_fitness,fitness_gather,fitness_groups)

# Write out tidy dataset of fitness data to
# working R directory

write.table(fitness_data,file = "./fitness_data.txt",col.names = TRUE)

# Write out tidy dataset of analyzed data to
# working R directory

write.table(fitness_summary,file = "./fitness_summary.txt",col.names = TRUE)
