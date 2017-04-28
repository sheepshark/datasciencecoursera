if (!file.exists("GetDataQuiz1")) {
        dir.create("GetDataQuiz1")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(fileUrl,destfile="./GetDataQuiz1/idaho_housing.csv")

dateDownloaded <- date()

idaho_housing <- read.csv("./GetDataQuiz1/idaho_housing.csv")

##length(idaho_housing$VAL[!is.na(idaho_housing$VAL) & idaho_housing$VAL==24])

fileUrl3 <- "http://www.gsa.gov/dg/pbs/DATA.gov_NGAP.xlsx"

##library(openxlsx)

##download.file(fileUrl3, destfile="./GetDataQuiz1/DATA.gov_NGAP.xlsx")

dateDownloaded3 <- date()

##dat <- read.xlsx("./GetDataQuiz1/DATA.gov_NGAP.xlsx", sheet = 1, rows = c(18:23), cols = c(7:15))
##AAARRRGGGGH!!! This won't work. I have to manually download the file from the source directly to the directory.

##sum(dat$Zip*dat$Ext,na.rm=T)

fileUrl4 <- "http://d396qusza40orc.cloudfront.net/getdata/data/restaurants.xml"

doc <- xmlTreeParse(fileUrl4,useInternalNodes = TRUE)

dateDownloaded4 <- date()

rootNode <- xmlRoot(doc)

##xmlName(rootNode)

##names(rootNode)

##rootNode[[1]][[1]]

zipcode <- xpathSApply(rootNode,"//zipcode",xmlValue)

##length(zipcode[zipcode==21231])

fileUrl5 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"

download.file(fileUrl5, destfile = "./GetDataQuiz1/communitysurvey2006.csv")

dateDownloaded5 <- date()

library(data.table)

DT <- fread("./GetDataQuiz1/communitysurvey2006.csv", sep=",")

##system.time(rowMeans(DT)[DT$SEX==1]+ rowMeans(DT)[DT$SEX==2])
##Error in rowMeans(DT) : 'x' must be numeric

##system.time(DT[,mean(pwgtp15),by=SEX])
##The answer. I wish I knew why. User time is 0.00 rather than 0

##system.time(mean(DT[DT$SEX==1,]$pwgtp15)+ mean(DT[DT$SEX==2,]$pwgtp15))
##Only produces one result. Also, user time is 0.02

##system.time(tapply(DT$pwgtp15,DT$SEX,mean))
##I don't get it. User time is 0

##system.time(mean(DT$pwgtp15,by=DT$SEX))
##Only produces one result, a mean of all results

##system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
##I don't get it. User time is 0