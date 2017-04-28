if (!file.exists("GetDataQuiz3")) {
        dir.create("GetDataQuiz3")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(fileUrl,destfile="./GetDataQuiz3/idaho_housing.csv")

dateDownloaded <- date()

idaho_housing <- read.csv("./GetDataQuiz3/idaho_housing.csv")

agricultureLogical <- (idaho_housing$ACR == 3 & idaho_housing$AGS == 6)

##which(agricultureLogical)

library(jpeg)

fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"

download.file(fileUrl2,destfile="./GetDataQuiz3/jeff.jpg", mode = "wb")

dateDownloaded2 <- date()

image <- readJPEG("./GetDataQuiz3/jeff.jpg", native = TRUE)

##quantile(image, probs = c(0.3,0.8))

fileUrl31 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"

download.file(fileUrl31,destfile="./GetDataQuiz3/GDP.csv")

dateDownloaded31 <- date()

fileUrl32 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

download.file(fileUrl32,destfile="./GetDataQuiz3/EDU.csv")

dateDownloaded32 <- date()

gdp <- read.csv("./GetDataQuiz3/GDP.csv"
                , skip = 4, nrows = 215
                )

edu <- read.csv("./GetDataQuiz3/EDU.csv")

dtgdp <- data.table(gdp)

setnames(dtgdp, c("X","X.1","X.3","X.4"), c("CountryCode","GDPrank","Long.Name","GDP"))

dtedu <- data.table(edu)

dt <- merge(dtgdp, dtedu, all = TRUE, by = c("CountryCode"))

##sum(!is.na(unique(dt$GDPrank)))

##arrange(dt, desc(GDPrank))[13,4]

##dt[, mean(GDPrank, na.rm = TRUE), by = Income.Group]

breaks <- quantile(dt$GDPrank, probs = seq(0, 1, 0.2), na.rm = TRUE)

dt$quantileGDP <- cut(dt$GDPrank, breaks = breaks)

##dt[Income.Group == "Lower middle income"& GDPrank <= 38][,4]