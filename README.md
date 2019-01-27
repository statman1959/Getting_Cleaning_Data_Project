# Document: README.md
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

# More information is available in the files run_analysis.R and CodeBook.md
# on the Github repo set up for this course project

II.	Steps in run_analysis.R to create tidy datasets

The program run_analysis.R creates tidy datasets in the order of the following steps:

1. Read in activity_labels.txt for activity codes

2. Set column names for crosswalk of activity codes to activity names

3. Read in subject_train.txt for subjects in training dataset

4. Set column name for subject_train

5. Read in subject_test.txt for subjects in test dataset

6. Set column name for subject_train

7. Read in y_train.txt for physical activity codes of subjects in training dataset

8. Set column name for y_train

9. Create index so y_train can resorted back into original sequence after merging with activity names

10. Bind index to y_train

11. Merge crosswalk to y_train to replace numerical codes for physical activities with meaningful names

12. Re-sort y_train to original sequence after merge with activity names

13. Add variable to y_train to indicate data is from training dataset

14. Remove index and physical activity codes from y_train as they are no longer needed

15. Read in y_test.txt for physical activity codes of subjects in test dataset

16. Set column name for y_test

17. Create index so y_test can resorted back into original sequence after merging with activity names

18. Bind index to y_test

19. Remove index variable after binding to y_train and y_test

20. Merge crosswalk to y_train to replace numerical codes for physical activities with meaningful names

21. Re-sort y_train to original sequence after merge with crosswalk

22. Add variable to y_test to indicate data is from test dataset

23. Remove index and physical activity codes from y_test as they are no longer needed

24. Remove crosswalk of physical activity names as it is no longer needed

25. Combine physical activity data from training and test sources into one R object

26. Remove individual datasets of training and test after combining them

27. Combine subject codes from training and test sources into one R object

28. Remove individual datasets of training and test subjects after combining them

29. Combine subject codes and physical activity data into one R object

30. Remove individual datasets of subject codes and physical activity after combining them

31. Read in features.txt for names of performance measurements in training and test datasets

32. Remove first column of features as it is not needed

33. Extract names of performance measurements containing "mean".  These are part of the measurements to be analyzed

34. Extract names of performance measurements containing "std".  These are the other part of the measurements to be analyzed

35. Read in X_train.txt, dataset of training performance measurements

36. Set column names of training data set of performance measurements

37. Extract performance measurements from training dataset for analysis

38. Read in X_test.txt, dataset of test performance measurements

39. Set column names of test dataset of performance measurements

40. Extract performance measures from test dataset for analysis

41. Remove R objects containing vectors of performance measurement names as they are no longer needed

42. Bind train and test datasets of performance measurements into one R object

43. Remove individual training and test datasets of performance measurements after binding them

44. Bind performance measurements data with subject and activity data into one R object

45. Remove individual datasets of performance and subject and activity data as they are no longer needed

46. Install and activate tidyr package for operations helpful to creating tidy dataset

47. Install and activate dplyr package to perform required analysis of performance measurements

48. Copy fitness_data into data table for tidyr operations

49. Gather all performance measurements into a single column where values in rows indicate particular performance measurement

50. Take the single column of performance measurements and create new variable to indicate whether measurements are mean or standard deviation

51. Move new variable to second from the right in the performance measurements dataset

52. Divide the fitness data into groups for analysis by combinations of subject, activity name, name of performance measurement, and whether measurement is mean or std

53. Summarize fitness data by computing the means of the performance measurements by group

54. Convert tidy dataset of fitness data into a data frame

55. Convert tidy dataset of summarized data into a data frame

56. Remove data table and intermediate objects for gathering and group fitness data as they are no longer needed

57. Write out tidy dataset of fitness data as text file to working R directory

58. Write out tidy dataset of summarized data as text file to working R directory

59. Quit run_analyis.R