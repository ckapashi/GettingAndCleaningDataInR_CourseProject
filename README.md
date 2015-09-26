READ ME
_______

Notes on how the script works including the details steps that have been followed to source and cleanse the data.

######################################################################################################################################################################

# Section 1 - Preparing the train data

- Start of preparation of "TRAIN" dataset with subject, activity_number, activity_type and 66 measurements on mean and std
- Read X_train data. This contains 7352 rows and 561 columns with no header. Default header names of V1 to V561 are allocated by R.
  Each row represents a subject (to be added later) and their 561 measurements
- Add header to x_train. This come from features.txt. Read this file in. 
  It contains 561 rows and 2 columns titled V1 and V2.
  V2 contains the 561 measurements which become header for x_train
- Convert features$V2 column from factor to character
- Rename the header from V1 to V561 in x_train with header names contained in features$V2
- Extract only those measurements (columns)  from x_train that relate to mean() and std(). 66 columns in total.
  x_train now contains 66 columns and 7352 rows
- Tidy the header names within x_train to remove () and - characters
- Next step is to add the activity number which comes from y_train.txt.
  y_train contains 7352 rows with 1 column called V1 and each row reprsents the activity_number which ranges from 1 to 6.
- Rename V1 to activity_number
- Read in the activity_labels.txt file. This contains 6 rows and 2 columns titled V1 and V2. 
  Each row represents the activity and its corresponding descriptive text.
- Rename the column names V1 and V2 to activity_number and activity_type respectively
- Merge y_train and activity_labels i.e add the activity_type to y_train
- Add the activity_number and activity_type contained in y_train to x_train. x_train now has 68 columns. 
  66 for the measurements and the other two for activity_number and activity_type
- Add the subject to x_train. This comes from subject_train.txt. Read this in.
  It contains 7352 rows and 1 column. Each row represents a subject which ranges from 1 to 30.
- Rename column V1 from subject_train to subject as it is more readable and easier to understand/interpret
- Add the subject to the x_train.
  x_train now has 7352 rows and 69 columns. 
  66 are for mean and std measurements and the other three are subject, activity_number, activity_type
- End of preparation of "TRAIN" dataset called x_train

######################################################################################################################################################################

# Section 2 - Preparing the test data

- Start of preparation of "TEST" dataset with subject, activity_number, activity_type and 66 measurements on mean and std
- Read X_test data. This contains 2947 rows and 561 columns with no header. Default header names of V1 to V561 are allocated by R.
  Each row represents a subject (to be added later) and their 561 measurements
- Add header to x_test. Use the previously prepared "features" data frame
- Rename the header from V1 to V561 in x_test with header names contained in features$V2
- Extract only those measurements (columns) that related to mean() and std(). 66 columns in total.
  x_test now contains 2947 rows 66 columns 
- Tidy the values to remove () and - characters
- Next step is to add the activity number which comes from y_test.txt. Read it in.
  y_test contains 2974 rows with 1 column and each row reprsents the activity_number which ranges from 1 to 6.
- Rename V1 in y_test to activity_number
- Merge y_test and previoulsy prepared activity_labels i.e add the activity_type to y_test
- Add the activity_number and activity_type to x_train. 
  x_train now has 68 cols. 66 for the measurements and activity_number and activity_type
- Add the subject to x_test. This comes from subject_train.txt. Read it in.
  It contains 2947 rows and 1 column. Each row represents a subject which ranges from 1 to 30.
- Rename column V1 in subject_test to subject as it is more readable and easier to understand/interpret
- Add the subject to the x_test data set. x_test now has 2974 rows and 69 columns. 
  66 are for mean and std measurement and the other three are subject, activity_number and activity_type
- End of preparation of "TEST" dataset called x_test

######################################################################################################################################################################
# Section 3 - Preparation of the tiday data set and calculating the mean

- Prepare a "tidydataset" called by horizontally combining the prepared train dataset with 7352 rows with 69 cols called x_train
  and test dataset with 2947 rows with 69 cols called x_test.
  "tidydataset" will have 10,299 rows with 69 cols
- Calculate the mean per subject per activity for the tidydataset into a new dataset called final_tidydataset 
- Finally, write the final_tidydataset which contains the summarised means for 66 measurements to final_tidydataset.txt file

######################################################################################################################################################################