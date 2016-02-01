readfile <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",na.strings = "NA")

filter_propertyValue <- subset(readfile,VAL == 24)


library(xlsx)
colIndex <- 7:15
rowIndex <- 18:23
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx?acessType=DOWNLOAD"
download.file(fileUrl,destfile = "data.xlsx",method="curl")
dat <- read.xls("data.xlsx",sheetIndex=1,
                 colIndex=colIndex,rowIndex=rowIndex)

sum(dat$Zip*dat$Ext,na.rm=T)

xmlUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"

doc <- xmlTreeParse(xmlUrl,useInternal=TRUE)

rootNode <- xmlRoot(doc)
xmlName(rootNode)

zipCodes <- xpathSApply(rootNode,"//row[zipcode='21231']/zipcode",xmlValue)



tableFile <- fread("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",sep = ",")

tableFile[,mean(pwgtp15),by=SEX]

sapply(split(tableFile$pwgtp15,tableFile$SEX),mean)

rowMeans(tableFile)[tableFile$SEX==1];rowMeans(tableFile)[tableFile$SEX==2]

mean(tableFile[tableFile$SEX==1,]$pwgtp15);mean(tableFile[tableFile$SEX==2,]$pwgtp15)

system.time(mean(tableFile[tableFile$SEX==1,]$pwgtp15);mean(tableFile[tableFile$SEX==2,]$pwgtp15))
