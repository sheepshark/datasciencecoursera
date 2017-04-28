library(httr)

oauth_endpoints("github")

myapp <- oauth_app("github", key = "985a3e5553f75eb8ef1d", 
                   secret = "ca09d780046b6dca7a550a5d67e0149a4442f124")

github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

gtoken <- config(token = github_token)

req <- with_config(gtoken, GET("https://api.github.com/users/jtleek/repos"))

stop_for_status(req)

content(req)

if (!file.exists("GetDataQuiz2")) {
        dir.create("GetDataQuiz2")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"

download.file(fileUrl,destfile="./GetDataQuiz2/acs2006.csv")

dateDownloaded <- date()

acs <- read.csv("./GetDataQuiz2/acs2006.csv")

##library(XML)

fileUrl4 <- "http://biostat.jhsph.edu/~jleek/contact.html"

##doc <- htmlTreeParse(fileUrl4,useInternalNodes = TRUE)

##dateDownloaded4 <- date()

con <- url("http://biostat.jhsph.edu/~jleek/contact.html")

htmlcode <- readLines(con)

close(con)

nchar(htmlcode[c(10,20,30,100)])

##<meta name="Distribution" content="Global" />
##        <script type="text/javascript">
##        })();
##<ul class="sidemenu">

html2 <- GET(fileUrl4)

content2 <- content(html2, as = "text")

parsedHTML <- htmlParse(content2, asText = TRUE)

xpathSApply(parsedHTML, "//title", xmlValue)

fileUrl5 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"

download.file(fileUrl5,destfile="./GetDataQuiz2/wksst8110.for")

wksst8110 <- read.fwf("./GetDataQuiz2/wksst8110.for", 
                      widths = c(15,4,9,4,9,4,9,4,4), 
                      col.names = c("Week","Nino1+2SST","Nino1+2SSTA",
                                    "Nino3SST","Nino3SSTA","Nino34SST",
                                    "Nino34SSTA","Nino4SST","Nino4SSTA"),
                      skip = 4)

##sum(wksst8110[,4])