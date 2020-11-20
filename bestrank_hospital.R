## Data check and validation, set numeric to column 11
## outcome[, 11] <- as.numeric(outcome[, 11])
## You may get a warning about NAs being introduced; that is okay
## Check distribution to find median value for this partn
## hist(outcome[, 11])

## Data Preparation : read csv data and input data environment with name "hdata" and "outcome"
new_outcome <- outcome %>% select(Provider.Number, Hospital.Name, Address.1, City, State, County.Name, Phone.Number, starts_with("Hospital.30.Day.Death"))
new_outcome <- new_outcome %>%
rename(
  Heart_Attack = Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,
  Heart_Failure = Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,
  Pneumonia = Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia
)

best <- function(state, outcome) {
  ## Contain state and outcome value input from function into x and y
  x <- state
  y <- outcome
  
  ## Read outcome data
  data <- new_outcome
  
  ## 
  res <- data %>% select(Provider.Number, Hospital.Name, Address.1, City, State,
                  County.Name, Phone.Number,
                  contains(y)) %>% filter(
    State %in% x
  ) %>% drop_na()

  ## Find minimum value for selected outcome
  min_val = min(res[,8], na.rm = TRUE)
  
  ## Filter data based on minimum value
  fin <- filter(res, res[,8] == min_val)
  
  ## Return hospital name in choosen state with lowest 30-day death
  ## rate
  view(fin)
  
}


rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
}
