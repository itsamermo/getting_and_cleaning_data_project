#run_analysis.R

require(data.table)


actv <- read.csv("UCI HAR Dataset/activity_labels.txt", header = FALSE, sep= " ",colClasses = "character")
trndata <- read.csv("UCI HAR Dataset/train/X_train.txt", header = FALSE, sep= "\x01",colClasses = "character")
tstdata <- read.csv("UCI HAR Dataset/test/X_test.txt", header = FALSE, sep= "\x01",colClasses = "character")





### clean up the spaces and split into cols
trndata <- lapply(trndata, function(x) gsub("\\s+",";",x) )
setDT(trndata)
trndata[, c(sprintf("f%03d", seq(1,562))) := tstrsplit(V1, ";", fixed=TRUE)]

tstdata <- lapply(tstdata, function(x) gsub("\\s+",";",x) )
setDT(tstdata)
tstdata[, c(sprintf("f%03d", seq(1,562))) := tstrsplit(V1, ";", fixed=TRUE)]



###tidy checks for trndata
### print class of features in trndata
#print( as.list(sapply(colnames(trndata),class)))
#print( as.list(sapply(colnames(tstdata),class)))

##to filter any true blank colms
trndata <- trndata[,!sapply(trndata, function(x) all(x == "")),with=FALSE]
trndata <- trndata[, V1:=NULL]

tstdata <- tstdata[,!sapply(tstdata, function(x) all(x == "")),with=FALSE]
tstdata <- tstdata[, V1:=NULL]



##to filter any true blank rows
trndata <- trndata[!apply(trndata, 1, function(x) all(x == "")),]
tstdata <- tstdata[!apply(tstdata, 1, function(x) all(x == "")),]

## finidng number of non blank values in all colmn of trndata
##trndata_cols_non_blnk_frq <- sapply(trndata, function(x) length(x[!x==""]))
##tstdata_cols_non_blnk_frq <- sapply(tstdata, function(x) length(x[!x==""]))


###feauture naming
fnm <- read.csv("UCI HAR Dataset/features.txt", sep=" ", header = FALSE,colClasses = "character")
colnames(trndata) <- as.character(fnm$V2)
colnames(tstdata) <- as.character(fnm$V2)
remove(fnm) ## not needed anymore

##adding activity labels
tlbl <- read.csv("UCI HAR Dataset/train/y_train.txt", header = FALSE, sep= "\x01",colClasses = "character")
trndata[,lbl:=tlbl$V1 ]
tstlbl <- read.csv("UCI HAR Dataset/test/y_test.txt", header = FALSE, sep= "\x01",colClasses = "character")
tstdata[,lbl:=tstlbl$V1 ]

##adding subject labels
trnsub <- read.csv("UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep= "\x01",colClasses = "character")
trndata[,sub:=trnsub$V1 ]
tstsub <- read.csv("UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep= "\x01",colClasses = "character")
tstdata[,sub:=tstsub$V1 ]

remove(tlbl)
remove(tstlbl)
remove(trnsub)
remove(tstsub)

###MErge train and test  data sets vertically#####
my_data <- rbind(trndata,tstdata)

remove(trndata)
remove(tstdata)

###prserve (actv and sub)labels , we will attach it back
lbls <- my_data[,lbl]
subs <- my_data[,sub]
### Extracts only the measurements on the mean and standard deviation for each measurement.
my_data <- my_data[,grep("mean|std",colnames(my_data)),with= FALSE]

## converting all means and std colums to class numeric
my_data <-my_data[ ,lapply(my_data, function(x) as.numeric(x))]


###adding all labels back into DT
my_data[,lbl:=lbls ]
my_data[,sub:=subs ]

remove(lbls)
remove(subs)

###merge horizontally to get training activity class desc
my_data<-merge(my_data,actv, by.x="lbl",by.y = "V1")

remove(actv)

# set a descriptive lable name
colnames(my_data)[colnames(my_data)=="V2"] <- "lbl_desc"


###generating new tidy data set
###DT[, lapply(.SD, mean), by = ID]
tdydt <- my_data[,lapply(.SD, mean),by =.(lbl,lbl_desc,sub)]



###descriptive variable names
colnames(tdydt)[1:3] <- c("activity","actv_desc","subject")
##set colmn order and set variable names
setcolorder(my_data, c(c('lbl','lbl_desc','sub'),colnames(my_data)[c(-1,-81,-82)]))
colnames(my_data)[1:3] <- c("activity","actv_desc","subject")


# Write CSV in R
write.table(tdydt, file = "avg_tidy_data.txt",row.names=FALSE)
# Write CSV in R
write.table(my_data, file = "tidy_data.txt",row.names=FALSE)

