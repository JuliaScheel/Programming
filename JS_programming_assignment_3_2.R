## R Programmming Assignment 3.2
rankhospital <- function(state, outcome, rank = "best"){
  ## Read outcome table (just as in assignment 3.1)
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  v   <- as.data.frame(cbind(data[, 2],  
                              data[, 7],  
                              data[, 11],  
                              data[, 17],  
                              data[, 23]),
                        stringsAsFactors = FALSE)
  colnames(v) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
  
  ## Validation of state and outcome 
  if (!state %in% v[, "state"]) {
    stop('invalid state')
  } else if (!outcome %in% c("heart attack", "heart failure", "pneumonia")){
    stop('invalid outcome')
  } else if (is.numeric(rank)) {
    findstate <- which(v[, "state"] == state)
    extractstate <- v[findstate, ]                     # extracting dataframe for the called state
    extractstate[, eval(outcome)] <- as.numeric(ts[, eval(outcome)])
    extractstate <- extractstate[order(extractstate[, eval(outcome)], extractstate[, "hospital"]), ]
    output <- extractstate[, "hospital"][rank]
  } else if (!is.numeric(rank)){
    if (rank == "best") {
      output <- best(state, outcome)
    } else if (rank == "worst") {
      findstate <- which(v[, "state"] == state)
      extractstate <- v[findstate, ]    
      extractstate[, eval(outcome)] <- as.numeric(extractstate[, eval(outcome)])
      extractstate <- extractstate[order(extractstate[, eval(outcome)], extractstate[, "hospital"], decreasing = TRUE), ]
      output <- extractstate[, "hospital"][1]
    } else {
      stop('invalid rank')
    }
  }
  return(output)
}
