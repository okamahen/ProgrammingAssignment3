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
  
  ## Target column 8 (ratio) for rank
  target <- res[,8]
  
  ## Create variable to catch num input, contains : "worst", "best", or integer

  
  ## Calculate rank using dense_rank() and add new column using mutate()
  rankVal <- res %>% mutate(
    nrank = dense_rank(target)
  ) %>% arrange(nrank)
  
  ## Create variable to contain result from filter() process
  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  view(rankVal)
  
  
  ## Read outcome data
## Check that state and outcome are valid
## For each state, find the hospital of the given rank
## Return a data frame with the hospital names and the
## (abbreviated) state name
}
