best <- function (state, outcome) {
        
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
                outcomedata <- statedata[,11]
        }
        else if(outcome == "heart failure") {
                outcomedata <- statedata[,17]
        }
        else {
                outcomedata <- statedata[,23]
        }
        
        ## Return hospital name in that state with lowest 30-day death rate
        lowest <- which(outcomedata == min(outcomedata, na.rm = TRUE))
        hospital <- statedata[lowest,2]
        return(hospital)
}