if (!file.exists("GetDataQuiz4")) {
        dir.create("GetDataQuiz4")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(fileUrl,destfile="./GetDataQuiz4/idaho_housing.csv")

dateDownloaded <- Sys.time()

idaho_housing <- data.table(read.csv("./GetDataQuiz4/idaho_housing.csv"))

ih_splitnames <- strsplit(names(idaho_housing),"wgtp")

##ih_splitnames[[123]]

fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"

download.file(fileUrl2,destfile="./GetDataQuiz4/GDP.csv")

dateDownloaded2 <- Sys.time()

fileUrl4 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

download.file(fileUrl4,destfile="./GetDataQuiz4/EDU.csv")

dateDownloaded4 <- Sys.time()

gdp <- read.csv("./GetDataQuiz4/GDP.csv"
                , skip = 4, nrows = 215
)

edu <- read.csv("./GetDataQuiz4/EDU.csv")

library(data.table)

dtgdp <- data.table(gdp)

setnames(dtgdp, c("X","X.1","X.3","X.4"), c("CountryCode","GDPrank","countryNames","GDP"))

dtedu <- data.table(edu)

dtgdpedu <- merge(dtgdp, dtedu, all = TRUE, by = c("CountryCode"))

##mean(as.numeric(gsub(",","",dtgdp$GDP)),na.rm = TRUE)

##grep("^United",dtgdp$countryNames) 
##Returns a vector of 3 indices for 3 countries that begin with "United"

spec_notes_fiscal_year <- grepl("fiscal year end", tolower(dtgdpedu$Special.Notes))

spec_notes_june <- grepl("june", tolower(dtgdpedu$Special.Notes))

##dtgdpedu[spec_notes_fiscal_year & spec_notes_june][,c(4,19)]

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
##table(year(sampleTimes), weekdays(sampleTimes))