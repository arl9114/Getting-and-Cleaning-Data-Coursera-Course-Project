library(data.table)
library(plyr)
library(dplyr)

##READING DATA FILES
## 'activity_labels.txt': Links the class labels with their activity name. qq
activity_labels<-read.table("activity_labels.txt")
activity_labels$V2<-as.character(activity_labels$V2)
# assign labels
names(activity_labels)<-c("ActivityCode","ActivityName")
## 'features.txt': List of all features.
features<-read.csv("features.txt",sep=" ",header=FALSE)

##TRAINING DATA
## 'train/X_train.txt': Training set.
X_train<-read.table("train/X_train.txt")

## 'train/y_train.txt': Training labels.
Y_train<-read.table("train/Y_train.txt")

# Reading subject training data
subject_train<-fread("./train/subject_train.txt")

##TEST DATA
## 'test/X_test.txt': Test set.
X_test<-read.table("test/X_test.txt")

## 'test/y_test.txt': Test labels.
Y_test<-read.table("test/Y_test.txt")

# Reading subject test data
subject_test<-fread("./test/subject_test.txt")

## DATA MANIPULATION

## PROCESSING TEST DATA
# assign column names to identify observations
X_test_renamed<-X_test
names(X_test_renamed)<-features$V2
# filters only relevant mean & std columns based on the names using grep/regex
X_test_renamed_filtered<-X_test_renamed[,c(grep("[Mm][Ee][Aa][Nn]",features$V2,ignore.case=TRUE),grep("[Ss][Tt][Dd]",features$V2,ignore.case=TRUE))]
# combines activity table with the observations
X_Y_activity_test_renamed_filtered<-cbind(X_test_renamed_filtered,Y_test)
# renames newly joined activity column
setnames(X_Y_activity_test_renamed_filtered,"V1","ActivityCode")
# combines subject data with the observation
X_Y_subject_activity_test_renamed_filtered<-cbind(subject_test,X_Y_activity_test_renamed_filtered)
# renames newly joined Subject column
setnames(X_Y_subject_activity_test_renamed_filtered,"V1","Subject")
# gives label to test data
X_Y_subject_activity_test_renamed_filtered$Source<-"Test"

## PROCESSING TRAINING DATA
# assign column names to identify observations
X_train_renamed<-X_train
names(X_train_renamed)<-features$V2
# filters only relevant mean & std columns based on the names using grep/regex
X_train_renamed_filtered<-X_train_renamed[,c(grep("[Mm][Ee][Aa][Nn]",features$V2,ignore.case=TRUE),grep("[Ss][Tt][Dd]",features$V2,ignore.case=TRUE))]
# combines activity table with the observations
X_Y_activity_train_renamed_filtered<-cbind(X_train_renamed_filtered,Y_train)
# renames newly joined activity column
setnames(X_Y_activity_train_renamed_filtered,"V1","ActivityCode")
# combines subject data with the observation
X_Y_subject_activity_train_renamed_filtered<-cbind(subject_train,X_Y_activity_train_renamed_filtered)
# renames newly joined Subject column
setnames(X_Y_subject_activity_train_renamed_filtered,"V1","Subject")
# gives label to train data
X_Y_subject_activity_train_renamed_filtered$Source<-"Train"

## COMBINING TRAINING & TEST DATA
combinedData<-rbind(X_Y_subject_activity_train_renamed_filtered,X_Y_subject_activity_test_renamed_filtered)

# assign activityName
observation<-merge(combinedData,activity_labels,by="ActivityCode")

# groupedObservation<-group_by(observation,"Subject","Source")
Output<-ddply(observation,c("Subject","ActivityName"),numcolwise(mean))

# saves result into a txt file
write.table(Output,file="tidydata.txt",row.name=FALSE)