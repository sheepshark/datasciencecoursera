rankhospital <- function(state, outcome, num = "best") {
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", 
                         colClasses = "character")
        data[,11] <- suppressWarnings(as.numeric(data[,11]))
        data[,17] <- suppressWarnings(as.numeric(data[,17]))
        data[,23] <- suppressWarnings(as.numeric(data[,23]))
        statedata <- data[data[,7]==state, ]
        
        ## Check that state and outcome are valid
        valid_outcomes <- c("heart attack", "heart failure", "pneumonia")
        if (!state %in% data$State) {
                stop("invalid state")
        }
        if (!outcome %in% valid_outcomes) {
                stop("invalid outcome")
        }
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
        
        ## Return hospital name in that state with the given rank 30-day death
        ## rate
        hospital <- ranked[index,2]
        return(hospital)
}