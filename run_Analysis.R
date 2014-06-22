# load reshape2
library(reshape2)
#check for files
if (!file.exists('UCI HAR Dataset/test/X_test.txt'))
   stop('cannot find UCI HAR Dataset/test/X_test.txt')
if (!file.exists('UCI HAR Dataset/test/Y_test.txt'))
  stop('cannot find UCI HAR Dataset/test/Y_test.txt')
if (!file.exists('UCI HAR Dataset/test/subject_test.txt'))
  stop('cannot find UCI HAR Dataset/test/subject_test.txt')
if (!file.exists('UCI HAR Dataset/train/X_train.txt'))
  stop('cannot find UCI HAR Dataset/train/X_train.txt')
if (!file.exists('UCI HAR Dataset/train/Y_train.txt'))
  stop('cannot find UCI HAR Dataset/train/Y_train.txt')
if (!file.exists('UCI HAR Dataset/train/subject_train.txt'))
  stop('cannot find UCI HAR Dataset/train/subject_train.txt')

# load the test data sets into memory
test_x <- as.data.frame(read.table('UCI HAR Dataset/test/X_test.txt'))
test_subject <- as.data.frame(read.table('UCI HAR Dataset/test/subject_test.txt'))
test_y <- as.data.frame(read.table('UCI HAR Dataset/test/Y_test.txt'))

# load the training data sets into memory
training_x <- as.data.frame(read.table('UCI HAR Dataset/train/X_train.txt'))
training_subject <- as.data.frame(read.table('UCI HAR Dataset/train/subject_train.txt'))
training_y <- as.data.frame(read.table('UCI HAR Dataset/train/Y_train.txt'))

#create consolidated test data set
test_set <- cbind(test_x,test_subject)
test_set <- cbind(test_set, test_y)

#create consolidated training data set
training_set <- cbind(training_x, training_subject)
training_set <- cbind(training_set, training_y)

#create a full consolidated data set
fullset <- rbind(training_set, test_set)

# read column names from features.txt!
col_names <- as.data.frame(read.table('UCI HAR Dataset/features.txt', stringsAsFactors=FALSE))[,2]
col_names <- c(col_names,'subject')
col_names <- c(col_names, 'activity')


# extract the mean and standard deviation columns only
columns_to_extract <- c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,
                        201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,294,295,296,345,346,347,348, 349, 350,
                        424,425,426,427,428,429,503,504,516,517,529,530,542,543,552,559,560,561,562,563)



sub_set <- fullset[,columns_to_extract]
colnames(sub_set) <- col_names[columns_to_extract]

# update activities
sub_set$activity[sub_set$activity == 1] <- "WALKING"
sub_set$activity[sub_set$activity == 2] <- "WALKING_UPSTAIRS"
sub_set$activity[sub_set$activity == 3] <- "WALKING_DOWNSTAIRS"
sub_set$activity[sub_set$activity == 4] <- "SITTING"
sub_set$activity[sub_set$activity == 5] <- "STANDING"
sub_set$activity[sub_set$activity == 6] <- "LAYING"

sub_set$activity <- as.factor(sub_set$activity)

agg <- aggregate(.~subject+activity, FUN=mean, data=sub_set)

write.table(agg,"Means_of_mean_and_stdev_type_features.txt",row.names=FALSE)

