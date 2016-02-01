#1
readfile <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",na.strings = "NA")

agricultureLogical <- (readfile$ACR == 3 & readfile$AGS == 6)
which(agricultureLogical) # 125 238 262

#2
file.url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
file.dest <- 'jeff.jpg'

download.file(file.url, file.dest, mode='wb' )

picture <- readJPEG('jeff.jpg', native=TRUE)

quantile(picture, probs = c(0.3, 0.8) )

# 30%       80% 
#  -15259150 -10575416 

# 3

gdp <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",na.strings = "..")

education <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")

gdp$Gross.domestic.product.2012 <- as.character(gdp$Gross.domestic.product.2012)


fileterGDP <-gdp[(gdp$Gross.domestic.product.2012 != ""),]

mergedData <- merge(fileterGDP,education, by.x = "X", by.y = "CountryCode",all = FALSE)

mergedData$Gross.domestic.product.2012 <- as.numeric(mergedData$Gross.domestic.product.2012)

# 189, 13 country is St Kitts

# 4

highIncome <- mergedData[(mergedData$Income.Group = "High income: OECD"),]

mergedData2 <- merge(fileterGDP,education, by.x = "X", by.y = "CountryCode",all = TRUE)
mergedData2$Gross.domestic.product.2012 <- as.numeric(mergedData2$Gross.domestic.product.2012)

gdp.g <- filter(mergedData2,Income.Group == "High income: nonOECD")
mean(gdp.f$Gross.domestic.product.2012)
mean(gdp.g$Gross.domestic.product.2012,na.rm = TRUE)
# 32.96667,91.91304

# 5

gdpGroup = cut(mergedData2$Gross.domestic.product.2012,breaks=quantile(mergedData2$Gross.domestic.product.2012,na.rm = TRUE))

table(gdpGroup,mergedData2$Income.Group)


                        
