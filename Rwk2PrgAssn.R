pollutantmean <- function(directory, pollutant, id = 1:332) {
        spec_files <- list.files(directory,full.names = TRUE)
        df <- data.frame()
        for (i in id) {
                df <- rbind(df,read.csv(spec_files[i]))
        }
        return(mean(df[,pollutant],na.rm = TRUE))
}

complete <- function(directory, id = 1:332) {
        spec_files <- list.files(directory,full.names = TRUE)
        f <- function(i) {
                df <- read.csv(spec_files[i])
                sum(complete.cases(df))
        }
        nobs <- sapply(id, f)
        return(data.frame(id, nobs))
}

corr <- function(directory, threshold = 0) {
        df <- complete(directory)
        ids <- df[df["nobs"] > threshold, ]$id
        spec_files <- list.files(directory,full.names = TRUE)
        corrr <- numeric()
        for (i in ids) {
                cordf <- read.csv(spec_files[i])
                dff <- cordf[complete.cases(cordf), ]
                corrr <- c(corrr, cor(dff$sulfate, dff$nitrate))
        }
        return(corrr)
}