##  Ranking hospitals in all states
## Follow instruction on best.R to prepare data to continue using this function

rankall <- function(outcome, num = "best") {
  ## Contain state and outcome value input from function into x, y, and z
  y <- outcome
  
  ## Read outcome data
  data <- new_outcome
  
  ## Check that outcome is valid, state no longer needed to xcheck
  res <- data %>% select(Provider.Number, Hospital.Name, Address.1, City, State,
                         County.Name, Phone.Number,
                         contains(y)) %>% drop_na()
  
  ## rename() cannot work, use base function name() to rename column 8
  ## dd_ratio = 30-days disease death ratio
  names(res)[8] <- "dd_ratio"
  
  ## Creating rank with ave() function, source https://stat.ethz.ch/pipermail/r-help/2005-June/073031.html
  res$dd_rank <- ave(res$dd_ratio, res$State, FUN = dense_rank)
  
  ## Grouping with state and dd_rank column
  res <- res %>% group_by(State, dd_rank) %>% arrange(dd_rank, .by_group = TRUE)
  
  ## Create variable to catch num input, contains : "worst", "best", or integer
  rankSelector <- if(num == "best"){
    min(res$dd_rank, na.rm = TRUE)
  } else if(num == "worst"){
    max(res$dd_rank, na.rm = TRUE)
  } else {
    num
  }
  
  ## Create variable to contain result from filter() process
  fin <- res %>% filter(
    dd_rank == rankSelector
  )
  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  view(fin)
  
  ## Return value to check on head or tails
  return(fin)
  
  # Message configuration info to user
  message(sprintf("Current outcome : %s", y))
  message(sprintf("Current Rank : %s", rankSelector))
  
}
