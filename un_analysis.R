un_analysis <-function()
{
        ##download the zip file
        download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "zipdatafile",method = "curl")
        ##unzip downloaded file
        unzip(zipfile = "zipdatafile",exdir="unzipdatadirectory")
        
        ##Reading features file to get the location of mean and std dev values
        featuresfile<-read.table("./unzipdatadirectory/UCI HAR Dataset/features.txt")
        positions<-grep("mean|std",featuresfile[,2])
        
        ##Merging files in Test folder
        x_test<-read.table("./unzipdatadirectory/UCI HAR Dataset/test/x_test.txt",col.names = featuresfile[,2])
        x_test<-x_test[,positions]
        y_test<-read.table("./unzipdatadirectory/UCI HAR Dataset/test/y_test.txt",col.names = "ActivityID")
        subject_test<-read.table("./unzipdatadirectory/UCI HAR Dataset/test/subject_test.txt",col.names = "Subject")
        testdata<-cbind(y_test,subject_test,x_test)
        
        ##Merging files in Train folder
        x_train<-read.table("./unzipdatadirectory/UCI HAR Dataset/train/x_train.txt",col.names = featuresfile[,2])
        x_train<-x_train[,positions]
        y_train<-read.table("./unzipdatadirectory/UCI HAR Dataset/train/y_train.txt",col.names = "ActivityID")
        subject_train<-read.table("./unzipdatadirectory/UCI HAR Dataset/train/subject_train.txt",col.names = "Subject")
        traindata<-cbind(y_train,subject_train,x_train)
        
        ##Merging Test and Training data
        mergeddata<-rbind(testdata,traindata)
        
        ##Adding Descriptive Activity Names
        activity_labels<-read.table("./unzipdatadirectory/UCI HAR Dataset/activity_labels.txt",col.names = c("ActivityID","ActivityLabel"))
        mergeddata<-merge(mergeddata,activity_labels,by.x="ActivityID",by.y="ActivityID")
        
        ## Creating a second, independent tidy data set with the average of each variable for each activity and each subject. 
        anotherdata<-melt(mergeddata,id.vars=c("Subject","ActivityID","ActivityLabel"))
        finalresult<-dcast(anotherdata,Subject+ActivityID+ActivityLabel~variable,mean)
        write.table(x = finalresult,file = "tidydata.txt",row.names=FALSE)
}