# Document: CodeBook.md
# Author:   Joseph Conklin
# Date:     January 2019

# Description:  This document fulfills one of the requirements
# of the Getting and Cleaning Data course project.  The project
# requires the creation of a tidy data set from an online source.
# The source is an archive of exercise performance measurements 
# recorded on subject's cell phones during various forms of 
# physical activity.

# The archive is located at https://d396qusza40orc.cloudfront.net/
# getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

I.	Input files to program run_analyze.R

# The program run_analyze.R uses the following datasets from the archive: 

# activity_labels.txt   a dataset providing a crosswalk between the physical
#                       activity name and their corresponding numerical codes

# features.txt          a dataset containing the names of the performance
#                       measurements

# subject_train.txt     a dataset listing the subjects in the training dataset
#                       by numerical code

# subject_test.txt      a dataset listing the subjects in the test dataset
#                       by numerical code

# X_test.txt            a test dataset containing performance measurements

# X_train.txt           a training dataset containing performance measurements

# y_test.txt            a dataset containing the physical activity codes for 
#                       X_test.txt

# y_train.txt           a dataset containing the physical activity codes for 
#                       X_train.txt

# subject_train.txt     a dataset listing the subjects in the training dataset
#                       by numerical code

# subject_test.txt      a dataset listing the subjects in the test dataset
#                       by numerical code

# More information is available in the files run_analysis.R and README.md
# on the Github repo set up for this course project

II.	R objects created by the program run_analysis.R

The program run_analysis.R creates the following R objects:

case			a vector of consecutive integers to re-sort y_train
			and y_test into the original order of the observations
			deleted during program execution after its function is served

crosswalk		to create a cross walk from the physical activity codes
                        to the physical activity names from reading activity_labels.txt
			deleted during program execution after its function is served

			The physical activity names are WALKING, WALKING_UPSTAIRS,
			WALKING_DOWNSTAIRS, SITTING, STANDING
 and LAYING


features		from reading features.txt to provide column names 
			in eventual tidy datasets  deleted during program
			execution after columns with names containing "mean"
			"std" are extracted from training and test datasets

fitness_data		result of appending fitness_train and fitness_test  Turned
			into tidy data set and written to R working directory as
			fitness_data.txt at end of program execution  Written at
			end of program exeuction to R working directory as 
			fitness_data.txt

fitness_gather		new_fitness after separate columns for performance variables
			are consolidated into a single column with with tidyr function gather  
			Deleted at end of program execution after output files are written to 
			R working directory

fitness_groups		fitness_gather after creating groups based on subject, activity_name,
			the consolidated variable for the performance measures, and an added
			variable that indicates whether a current observation is for the mean
			or standard deviation of performance measure.

			Necessary for using dplyr function summarize to create group means
			for file fitness_summary  Deleted at end of program execution after output 
			files are written to R working directory

fitness_summary		result of computing group means based on groups in fitness_groups.  Written 
			at end of program exeuction to R working directory as fitness_data.txt  	

fitness_test		from reading in X_test.txt to obtain performance
			measurements from test dataset  deleted during
			program execution after being appended to fitness_train

fitness_train		from reading in X_train.txt to obtain performance
			measurements from training dataset  deleted during
			program execution after being appended to fitness_test

mu			to hold extract from features of column names having
			"mean"  deleted during program execution after these
			columns are extracted from fitness_train and fitness_test

new_fitness		data table version of fitness_data so tidyr package functions
			can be used to create tidy dataset.  Deleted at end of program
			execution after output files are written to R working directory

sigma			to hold extract from features of column names having
			"std"  deleted during program execution after these
			columns are extracted from fitness_train and fitness_test
subject			result of appending subject_train and subject_test
			deleted during program execution after being appended
			to y

subject_activity	result of appending subject_train and subject_test
			deleted during program execution after being appended
			to y
subject_test		from reading in subject_test.txt   deleted 
			during program execution after being appended
			to subject_train

subject_train		from reading in subject_train.txt  deleted 
			during program execution after being appended
			to subject_test

y			result of appending y_test to y_train  deleted
			during program execution after being appended to
			subject_activity

y_test			from reading in y_test.txt  merged with 
			crosswalk to bring physical activity names
			into R object  deleted during program
			execution after being appended to y_train 

y_train			from reading in y_train.txt  merged
			with crosswalk to bring physical activity
			names into R object  deleted during program
			execution after being appended to y_test 

III.	Output files created by the program run_analysis.R

There are two output files created by the program run_analysis.R

A.  fitness_data.txt	tidy dataset of subject, activity names, and exercise
			performance measurements  consists of 813,621 observations
			and six variables

Variables in Order from Left to Right in Output File

Subject			Subjects in study coded as integers 1 to 30

Activity_Name		Physical activities performed by subjects
			Factor variable  Values are WALKING, WALKING_UPSTAIRS,
			WALKING_DOWNSTAIRS, SITTING, STANDING
 and LAYING


Source			Whether observation is from test or training dataset
			Character variable  Values are Test and Training

Fitness_Variable	Names of various performance measurements measuring mean
			or standard deviation of values in source archive.  Character
			variable  The file feature_info.txt in the source archive lists these
			performance measurements:

			'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

			tBodyAcc-XYZ
			tGravityAcc-XYZ
			tBodyAccJerk-XYZ
			tBodyGyro-XYZ
			tBodyGyroJerk-XYZ
			tBodyAccMag
			tGravityAccMag
			tBodyAccJerkMag
			tBodyGyroMag
			tBodyGyroJerkMag
			fBodyAcc-XYZ
			fBodyAccJerk-XYZ
			fBodyGyro-XYZ
			fBodyAccMag
			fBodyAccJerkMag
			fBodyGyroMag
			fBodyGyroJerkMag
			gravityMean
			tBodyAccMean
			tBodyAccJerkMean
			tBodyGyroMean
			tBodyGyroJerkMean

			For more information, see the source archive at the link given
			in Description above

Statistic		Character variable indicating whether observation is for mean or
			standard deviation of performance measurement data.  Values are
			mean and std.

Fitness_Value		Numeric result showing value of Fitness_Variable for current observation


B.  fitness_summary.txt	tidy dataset of subject, activity names, and exercise
			performance measurements showing average of Fitness_Value
			from fitness_data.txt by groups consisting of the combinations
			of Subject, Activity_Name, Fitness_Variable, and Statistic
			
			consists of 3,160 observations and five variables

Variables in Order from Left to Right in Output File

Subject			as in fitness_data.txt

Activity_Name		as in fitness_data.txt

Fitness_Variable	as in fitness_data.txt

Statistic		as in fitness_data.txt

Mean_Fitness		mean value for current combination of Subject, Activity_Name,
			Fitness_Variable, and Statistic  numeric result