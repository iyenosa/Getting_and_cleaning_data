# Check to see if the user has a "Data" folder
if (!file.exists("data")){
        
        # If not, it creates one
        dir.create("data")
}

# Download the file and put it in the "data" folder
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "./data/experimentdata.zip")

# Get the list of all files in the Zip file
unzip("./data/experimentdata.zip", list = T)

# 1. Merges the training and the test sets to create one data set.

  # Read in the training and test set files
  train_features <- read.table(unz("./data/experimentdata.zip","UCI HAR Dataset/train/X_train.txt"))
  train_subjects <- read.table(unz("./data/experimentdata.zip","UCI HAR Dataset/train/subject_train.txt"))
  train_activities <- read.table(unz("./data/experimentdata.zip","UCI HAR Dataset/train/y_train.txt"))

  test_features <- read.table(unz("./data/experimentdata.zip","UCI HAR Dataset/test/X_test.txt"))
  test_subjects <- read.table(unz("./data/experimentdata.zip","UCI HAR Dataset/test/subject_test.txt"))
  test_activities <- read.table(unz("./data/experimentdata.zip","UCI HAR Dataset/test/y_test.txt"))

  # Bind the data tables by rows
  data_features <- rbind(train_features, test_features)
  data_subjects<- rbind(train_subjects, test_subjects)
  data_activities<- rbind(train_activities, test_activities)

  # Now combine all the different columns to make one table
  all_data <- cbind(data_subjects, data_activities, data_features)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

  # Read the list of features and set names to variables
  features <- readLines(unz("./data/experimentdata.zip","UCI HAR Dataset/features.txt"))
  names(all_data)[3:563] <- features
  names(all_data)[1]<- c("subject")
  names(all_data)[2]<- c("activity")

  # Filter only the features that we are interested in
  requiredFeatures <- features[grep("mean[^a-zA-Z]|std[^a-zA-Z]",features)]
  all_data <- all_data[, c("subject", "activity", requiredFeatures)]

# 3. Uses descriptive activity names to name the activities in the data set

  # Read in the activity labels
  activity <- readLines(unz("./data/experimentdata.zip",
                          "UCI HAR Dataset/activity_labels.txt"))

  # Remove the numbers that appear before the names
  activity <- gsub("^.* ","",activity)

  # Factorize the "activity" variable using the descriptive names
  all_data$activity <- factor(all_data$activity, labels = activity)

# 4. Appropriately labels the data set with descriptive variable names.

  # Remove the numbers that appear before variable names
  names(all_data) <- gsub("^.* ", "", names(all_data))
  # Remove all brackets in variable names
  names(all_data) <- gsub("\\()", "", names(all_data))
  # Fix the "BodyBody" typo to just "Body"
  names(all_data) <- gsub("BodyBody", "Body", names(all_data))
  # std is replaced by Sd
  names(all_data) <- gsub("std", "Sd", names(all_data))
  # the lower class mean is replaced by with a capitalised first letter
  names(all_data) <- gsub("mean", "Mean", names(all_data))
  # All hyphens are removed from variable names
  names(all_data) <- gsub("\\-", "", names(all_data))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

  # Melt the data so we have a unique row for each combination of subject and acitivites
  # Check to see if "reshape2" package is installed
  if (!library(reshape2, logical.return=TRUE)) {
        # If it does not exist, it installs the package and loads it.
        install.packages("reshape2")
        library(reshape2)
  }
  all_data_melted <- melt(all_data, id.vars = c("subject", "activity"))

  # Cast it getting the mean value
  final_data <- dcast(all_data_melted, subject + activity ~ variable, mean)

  # Outputs tidy data set to a file
  write.table(final_data, file = "tidy.txt", row.names = FALSE)