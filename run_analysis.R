# Getting and Cleaning Data - Course Project

##################################################################################################################################################
library("plyr")
library("dplyr")


##################################################################################################################################################
# Start of preparation of "TRAIN" dataset with subject, activity_number, activity_type and 66 measurements on mean and std
##################################################################################################################################################

# Read X_train data. This contains 7352 rows and 561 columns with no header. Default header names of V1 to V561 are allocated by R.
# Each row represents a subject (to be added later) and their 561 measurements
x_train <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")

# Add header to x_train. This come from features.txt. Read this file in. 
# It contains 561 rows and 2 columns titled V1 and V2.
# V2 contains the 561 measurements which become header for x_train
features <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")

# Convert features$V2 column from factor to character
features$V2 <- as.character(features[ ,2])

# Rename the header from V1 to V561 in x_train with header names contained in features$V2
colnames(x_train) <- c(features$V2)

# Extract only those measurements (columns)  from x_train that relate to mean() and std(). 66 columns in total.
# x_train now contains 66 columns and 7352 rows
x_train <- x_train[ , grep("(mean\\(\\)|std())",names(x_train))]

# Tidy the header names within x_train to remove () and - characters
names(x_train) <- gsub("-", "_", names(x_train))
names(x_train) <- gsub("\\(\\)", "", names(x_train))

# Next step is to add the activity number which comes from y_train.txt.
# y_train contains 7352 rows with 1 column called V1 and each row reprsents the activity_number which ranges from 1 to 6.
y_train <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")

# Rename V1 to activity_number
colnames(y_train) <- c("activity_number")

# Read in the activity_labels.txt file. This contains 6 rows and 2 columns titled V1 and V2. 
# Each row represents the activity and its corresponding descriptive text.
activity_labels <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")

# Rename the column names V1 and V2 to activity_number and activity_type respectively
colnames(activity_labels) <- c("activity_number", "activity_type")

# Merge y_train and activity_labels i.e add the activity_type to y_train
y_train <- merge(y_train, activity_labels)

# Add the activity_number and activity_type contained in y_train to x_train. x_train now has 68 columns. 
# 66 for the measurements and the other two for activity_number and activity_type
x_train <- cbind(y_train, x_train)
#--------------------------------------------------------------------------------------------------------------------------

# Add the subject to x_train. This comes from subject_train.txt. Read this in.
# It contains 7352 rows and 1 column. Each row represents a subject which ranges from 1 to 30.
subject_train <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")

# Rename column V1 from subject_train to subject as it is more readable and easier to understand/interpret
colnames(subject_train) <- c("subject")

# Add the subject to the x_train.
# x_train now has 7352 rows and 69 columns. 
# 66 are for mean and std measurements and the other three are subject, activity_number, activity_type
x_train <- cbind(subject_train, x_train)

#write.csv(x_train, "x_train.csv")


##################################################################################################################################################
# End of preparation of "TRAIN" dataset called x_train
##################################################################################################################################################

##################################################################################################################################################
# Start of preparation of "TEST" dataset with subject, activity_number, activity_type and 66 measurements on mean and std
##################################################################################################################################################

# Read X_test data. This contains 2947 rows and 561 columns with no header. Default header names of V1 to V561 are allocated by R.
# Each row represents a subject (to be added later) and their 561 measurements
x_test <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")

# Add header to x_test. Use the previously prepared "features" data frame

# Rename the header from V1 to V561 in x_test with header names contained in features$V2
colnames(x_test) <- c(features$V2)

# Extract only those measurements (columns) that related to mean() and std(). 66 columns in total.
# x_test now contains 2947 rows 66 columns 
x_test <- x_test[ , grep("(mean\\(\\)|std())",names(x_test))]

# Tidy the values to remove () and - characters
names(x_test) <- gsub("-", "_", names(x_test))
names(x_test) <- gsub("\\(\\)", "", names(x_test))


# Next step is to add the activity number which comes from y_test.txt. Read it in.
# y_test contains 2974 rows with 1 column and each row reprsents the activity_number which ranges from 1 to 6.
y_test <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")

# Rename V1 in y_test to activity_number
colnames(y_test) <- c("activity_number")

# Merge y_test and previoulsy prepared activity_labels i.e add the activity_type to y_test
y_test <- merge(y_test, activity_labels)

# Add the activity_number and activity_type to x_train. 
# x_train now has 68 cols. 66 for the measurements and activity_number and activity_type
x_test <- cbind(y_test, x_test)

# Add the subject to x_test. This comes from subject_train.txt. Read it in.
# It contains 2947 rows and 1 column. Each row represents a subject which ranges from 1 to 30.
subject_test <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")

# Rename column V1 in subject_test to subject as it is more readable and easier to understand/interpret
colnames(subject_test) <- c("subject")

# Add the subject to the x_test data set. x_test now has 2974 rows and 69 columns. 
# 66 are for mean and std measurement and the other three are subject, activity_number and activity_type
x_test <- cbind(subject_test, x_test)

#write.csv(x_test, "x_test.csv")


##################################################################################################################################################
# End of preparation of "TEST" dataset called x_test
##################################################################################################################################################

# Prepare a "tidydataset" called by horizontally combining the prepared train dataset with 7352 rows with 69 cols called x_train
# and test dataset with 2947 rows with 69 cols called x_test.
# "tidydataset" will have 10,299 rows with 69 cols
tidydataset <- rbind_list(x_train, x_test)

#write.csv(tidydataset, "tidydataset.csv")

##################################################################################################################################################
# Calculate the mean per subject per activity for the tidydataset into a new dataset called final_tidydataset 
##################################################################################################################################################

final_tidydataset <- group_by(tidydataset, subject, activity_type) %>% summarise_each(c("mean"))
final_tidydataset <- arrange(final_tidydataset, subject, activity_type)

# Finally, write the final_tidydataset which contains the summarised means for 66 measurements to final_tidydataset.txt file
write.table(final_tidydataset, file="final_tidydataset.txt", row.name=FALSE)

##################################################################################################################################################