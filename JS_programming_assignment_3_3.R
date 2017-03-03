## R Programmming Assignment 3.3
rankall <- function(outcome, num = "best"){
  ## Read outcome table (just as in assignment 3.1 and 3.2)
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  v   <- as.data.frame(cbind(data[, 2],  
                             data[, 7],  
                             data[, 11],  
                             data[, 17],  
                             data[, 23]),
                       stringsAsFactors = FALSE)
  colnames(v) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
  v[, eval(outcome)] <- as.numeric(v[, eval(outcome)])
  
  ## Check that state and outcome are valid
  
  if (!outcome %in% c("heart attack", "heart failure", "pneumonia")){
    stop('invalid outcome')
  } else if (is.numeric(num)) {
    bstate <- with(v, split(v, state))
    ordered  <- list()
    for (i in seq_along(bstate)){
      bstate[[i]] <- bstate[[i]][order(bstate[[i]][, eval(outcome)], 
                                       bstate[[i]][, "hospital"]), ]
      ordered[[i]]  <- c(bstate[[i]][num, "hospital"], bstate[[i]][, "state"][1])
    }
    result <- do.call(rbind, ordered)
    output <- as.data.frame(result, row.names = result[, 2], stringsAsFactors = FALSE)
    names(output) <- c("hospital", "state")
  } else if (!is.numeric(num)) {
    if (num == "best") {
      bstate <- with(v, split(v, state))
      ordered  <- list()
      for (i in seq_along(bstate)){
        bstate[[i]] <- bstate[[i]][order(bstate[[i]][, eval(outcome)], 
                                         bstate[[i]][, "hospital"]), ]
        ordered[[i]]  <- c(bstate[[i]][1, c("hospital", "state")])
      }
      result <- do.call(rbind, ordered)
      output <- as.data.frame(result, stringsAsFactors = FALSE)
      rownames(output) <- output[, 2]
    } else if (num == "worst") {
      bstate <- with(v, split(v, state))
      ordered  <- list()
      for (i in seq_along(bstate)){
        bstate[[i]] <- bstate[[i]][order(bstate[[i]][, eval(outcome)], 
                                         bstate[[i]][, "hospital"], 
                                             decreasing = TRUE), ]
        ordered[[i]]  <- c(bstate[[i]][1, c("hospital", "state")])
      }
      result <- do.call(rbind, ordered)
      output <- as.data.frame(result, stringsAsFactors = FALSE)
      rownames(output) <- output[, 2]
    } else {
      stop('invalid num')
    }
  }
  return(output)
}