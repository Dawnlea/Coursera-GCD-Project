# ------------------------------------- Check data exists -------------------------------------------
dataDir<-"UCI HAR Dataset"
if (!file.exists(dataDir)){
  stop ("Aborting - UCI HAR Dataset subdirectory does not exist")
} else {

# ------------------------------------- Read data section -------------------------------------------
features = read.table("UCI HAR Dataset/features.txt", col.names=c("featureid", "featurelabel"), stringsAsFactors = FALSE)
activitylabels = read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("activityid", "activitylabel"), stringsAsFactors = FALSE)
subjecttrain=read.table("UCI HAR Dataset/train/subject_train.txt", col.names=c("subjectid"), stringsAsFactors = FALSE)
xtrain = read.table("UCI HAR Dataset/train/X_train.txt", stringsAsFactors = FALSE)
ytrain = read.table("UCI HAR Dataset/train/y_train.txt", col.names=c("activityid"), stringsAsFactors = FALSE)
subjecttest = read.table("UCI HAR Dataset/test/subject_test.txt", col.names=c("subjectid"), stringsAsFactors = FALSE)
ytest = read.table("UCI HAR Dataset/test/y_test.txt", col.names=c("activityid"), stringsAsFactors = FALSE)
xtest = read.table("UCI HAR Dataset/test/X_test.txt", stringsAsFactors = FALSE)
# ---------------------------------------------------------------------------------------------------

# ------------------- retrieve only those features pertaining to std and mean -----------------------
stdmean<-features[grepl("std", features$featurelabel) | grepl("mean", features$featurelabel) ,]
# ---------------------------------------------------------------------------------------------------

# ----------------create unique id for test and training data by using row number -------------------
subjecttrain$ID <- as.numeric(rownames(subjecttrain))
xtrain$ID <- as.numeric(rownames(xtrain))
ytrain$ID <- as.numeric(rownames(ytrain))
subjecttest$ID <- as.numeric(rownames(subjecttest))
xtest$ID <- as.numeric(rownames(xtest))
ytest$ID <- as.numeric(rownames(ytest))
# ---------------------------------------------------------------------------------------------------

# --------- join the test and training data retaining only those variables for std and mean ---------
traindata <- merge(subjecttrain, ytrain, all=TRUE)
traindata <- merge(traindata, xtrain, all=TRUE)
traindata <- traindata[, c(c(1,2,3), stdmean$featureid + 3)]
testdata <- merge(subjecttest, ytest, all=TRUE) 
testdata <- merge(testdata, xtest, all=TRUE)
testdata <- testdata[, c(c(1,2,3), stdmean$featureid + 3)]
result1<-rbind(traindata, testdata)
# ---------------------------------------------------------------------------------------------------

# ------------------------------ substitute descriptive activity names ------------------------------
result1<-merge(result1, activitylabels)
# ---------------------------------------------------------------------------------------------------

# ------------------------------ apply descriptive activity labels to columns -----------------------
stdmean$featurelabel<-gsub("\\(\\)|-","", stdmean$featurelabel)
cols<-c("activityid","id", "subjectid")
for (x in 1:nrow(stdmean)) {
    cols[x+3]<-as.character(stdmean$featurelabel[x])
}
colnames(result1)<-cols
colnames(result1)[ncol(result1)]<-"activityname"
# ---------------------------------------------------------------------------------------------------

# ----------------------- create a second, independent tidy data set with the average --------------- 
# -----------------------  of each variable for each activity and each subject ----------------------
# Drop inappropriate headers and resequence
drops <- c("id","activityname")
result2<-result1[,!(names(result1) %in% drops)] 
result2<-aggregate(result2, by=list(subject=result2$subjectid, activity=result2$activityid), FUN=mean, na.rm=TRUE)
# -- Add back in the meaningful activity labels
result2<-merge(result2, activitylabels)
# -- Remove unecessary columns and reposition activity labels
drops <- c("subject","activity") 
result2<-result2[,!(names(result2) %in% drops)]
col_idx <- grep("activitylabel", names(result2))
result2<- result2[, c(col_idx, (1:ncol(result2))[-col_idx])]
# ---------------------------------------------------------------------------------------------------

# ----------------------- create a second, independent tidy data set with the average --------------- 
write.table(result2, "tidydata.txt", row.name=FALSE)
}


