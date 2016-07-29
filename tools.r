#################### TS tools ##########################

na.lomf <<- function(object, na.rm = F) {
     numCols <- ""
     for (c in 1:ncol(object)){
          numCols[c] <- is.numeric(object[,c])
     }
     
     na.lomf.0 <- function(object) {
          idx <- which(!is.na(object))
          if (is.na(object[1])) idx <- c(1, idx)
          rep.int(object[idx], diff(c(idx, length(object) + 1)))
     }    
     dimLen <- length(dim(object))
     object <- if (dimLen == 0) na.lomf.0(object) else apply(object, dimLen, na.lomf.0)
     if (na.rm) na.trim(object, sides = "left", is.na = "all") else object
     
     object <- as.data.frame(object)
     for (c in 1:ncol(object)){
          if (numCols[c]){
               object[,c] <- as.numeric(object[,c])    
          }
     }
     return(object)
}


DTWgetalignment <- function(observations,maxLines){
     require(dtw)
     obs <- observations
     names(obs)[1] <- "A"
     names(obs)[2] <- "B"
     
     TSa <<- as.numeric(obs$A)[1:maxLines]
     TSb <<- as.numeric(obs$B)[1:maxLines]
     
     alignment <<- dtw(TSa,TSb,step=asymmetricP1,keep=TRUE,match.col="gray90")
}

DTWplot <<- function(observations){
     return(dtwPlotTwoWay(alignment, xlab="Time", ylab="Value"))
}




distanceMeasurements <<- function(){
     tmp <- paste("Euclidian: ", dist(rbind(TSa,TSb))," ",
               "Manhattan: ",dist(rbind(TSa,TSb), method="manhattan")," ",
               "Maximum: ",dist(rbind(TSa,TSb), method="maximum")," ",
               "DTW total: ",alignment$distance," ",
               "DTW normalized: ",alignment$normalizedDistance, sep="")
     return(tmp)
}

getSummary <<- function(){
     summaryTSa <<- summary(TSa)
     summaryTSb <<- summary(TSb)
     return(paste("Median: TSa=",summaryTSa[3]," TSb=", summaryTSb[3]))
}

pasteMin <<- function(){
     return(paste("Min: TSa=",summaryTSa[1]," TSb=", summaryTSb[1]))
}

pasteMax <<- function(){
     return(paste("Min: TSa=",summaryTSa[5]," TSb=", summaryTSb[5]))
}


generateTrendTSa <<- function(){
     plot(TSa)
     return(lines(lowess(TSa),col="red"))
}
generateTrendTSb <<- function(){
     plot(TSb)
     return(lines(lowess(TSb),col="red"))
}