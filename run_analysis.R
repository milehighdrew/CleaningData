# open test set files
xtest <- read.table("UCI HAR Dataset/test/X_test.txt",sep = "")
ytest <- read.table("UCI HAR Dataset/test/y_test.txt",sep = "")
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt",sep = "")
colnames(ytest) <- c("activityid")
colnames(subjectTest) <- c("subjectid")
testInfo <- cbind(subjectTest,ytest)
completeXTest <- cbind(testInfo,xtest)

# open training set
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt",sep = "")
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt",sep = "")
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt",sep = "")
colnames(ytrain) <- c("activityid")
colnames(subjectTrain) <- c("subjectid")
trainInfo <- cbind(subjectTrain,ytrain)
completeXTrain <- cbind(trainInfo,xtrain)

# merge test and train
mergedData <- rbind(completeXTrain,completeXTest)
# load features and activity labels
featuresLabels <- read.table("UCI HAR Dataset/features.txt",sep = "")
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt",sep="")
colnames(activityLabels) <- c("activityid","activitydescription")
# add V to row data so I can filter on flabels
featuresLabels <- mutate(featuresLabels,flabels= paste("V",V1,sep=""))

# filter out std and mean from featuresLabels
stdFeaturesLabels <- featuresLabels[grepl("std|mean",featuresLabels$V2),]

# remove (), - from names
stdFeaturesLabels$V2 <- gsub(")","",stdFeaturesLabels$V2)
stdFeaturesLabels$V2 <- gsub("\\(","",stdFeaturesLabels$V2)
stdFeaturesLabels$V2 <- gsub("-","",stdFeaturesLabels$V2)

#filter out the std and mean columns from mergeData

filterData <-  mergedData[c(stdFeaturesLabels$flabels)] 

# change col names to more meaniful names
colnames(filterData) <- c(stdFeaturesLabels$V2)

#filter out the subjectId and activity description

activityData <- cbind.data.frame(mergedData$subjectid,mergedData$activityid)
colnames(activityData) <- c("subjectid","activityid")

#load the dplyr libary
library(dplyr)
#add in activity description
activityData = inner_join(activityData,activityLabels,by='activityid')
#remove activityId
activityData2 <- cbind.data.frame(activityData$subjectid,activityData$activitydescription)
colnames(activityData2) <- c("subjectid","activitydescription")

# create final data fram
finalData <- cbind.data.frame(activityData2,filterData)

# create summary
finalDataSummary <- group_by(finalData,subjectid,activitydescription)

meanSummary <- summarise_each(finalDataSummary,funs(mean))

# write summary file to disc
write.table(meanSummary,file="meanSummary.txt",row.names = FALSE)




