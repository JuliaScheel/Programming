## Assignment 3 Part 2
# v = variables
# colnames(outcome) # get  indices of  different columns

best <- function(state, outcome) {
  # Read  outcome table 
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  v <- as.data.frame(cbind(data[, 2],   # hospital
                              data[, 7],   # state
                              data[, 11],  # heart attack
                              data[, 17],  # heart failure
                              data[, 23]), # pneumonia
                        stringsAsFactors = FALSE)
  colnames(v) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia") 
  
  # validation of state and outcome 
  if(!state %in% v [, "state"]){
    stop('invalid state')
  } else if(!outcome %in% c("heart attack", "heart failure", "pneumonia")){
    stop('invalid outcome')
  } else {
    findstate <- which(v[, "state"] == state)
    extractstate <- v[findstate, ]    
    def <- as.numeric(extractstate[, eval(outcome)])
    min_val <- min(def, na.rm = TRUE)
    result  <- extractstate[, "hospital"][which(def == min_val)]
    output  <- result[order(result)]
  }
  return(output)
}

  