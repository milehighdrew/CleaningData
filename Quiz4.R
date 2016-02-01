#1
Idaho <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")
splitNames = strsplit(names(Idaho),"wgtp")
splitNames[[123]]
# ""   "15"

#2
gdp <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",na.strings = "..")
gdp$Gross.domestic.product.2012 <- as.character(gdp$Gross.domestic.product.2012)
fileterGDP <-gdp[(gdp$Gross.domestic.product.2012 != ""),]
gdp190tb <- fileterGDP[grepl("^[0-9]",fileterGDP$Gross.domestic.product.2012),]
gdpIncome <- gsub(",","",gdp190tb$X.3)
gdpIncome <- as.numeric(gdpIncome)
mean(gdpIncome)
# 377652.4

#3
#grep("^United"),3

#4
education <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")
mergedData <- merge(gdp190tb,education, by.x = "X", by.y = "CountryCode",all = FALSE)
#13

#5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

yr2012 <- grep("2012",sampleTimes)
#250,47