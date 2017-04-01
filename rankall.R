rankall <- function(outcome, num = "best") {
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", 
                         colClasses = "character")
        data[,11] <- suppressWarnings(as.numeric(data[,11]))
        data[,17] <- suppressWarnings(as.numeric(data[,17]))
        data[,23] <- suppressWarnings(as.numeric(data[,23]))
        
        ## Check that state and outcome are valid
        valid_outcomes <- c("heart attack", "heart failure", "pneumonia")
        if (!outcome %in% valid_outcomes) {
                stop("invalid outcome")
        }
        
        ## For each state, find the hospital of the given rank
        f <- function(state) {
                statedata <- data[data[,7]==state, ]
                if(outcome == "heart attack") {
                        ranked <- statedata[order(statedata[,11],statedata[,2],
                                                  na.last = NA),]
                        
                }
                else if(outcome == "heart failure") {
                        ranked <- statedata[order(statedata[,17],statedata[,2],
                                                  na.last = NA),]
                }
                else {
                        ranked <- statedata[order(statedata[,23],statedata[,2],
                                                  na.last = NA),]
                }
                if(num == "best") {
                        index <- 1
                }
                else if(num == "worst") {
                        index <- nrow(ranked)
                }
                else if(is.numeric(num)) {
                        if(num > nrow(ranked)) {
                                return(NA)
                        }
                        else index <- num
                }
                else stop("invalid rank")
                hospital <- ranked[index,2]
                hospital
        }
        state <- sort(unique(data[,7]))
        fdata <- sapply(state,f)
        
        ## Return a data frame with the hospital names and the
        ## (abbreviated) state name
        df <- data.frame(fdata,state)
        colnames(df) <- c("hospital","state")
        return(df)
}