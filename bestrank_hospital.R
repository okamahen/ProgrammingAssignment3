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
  ## Read outcome data
  data <- new_outcome
  ## Check that state and outcome are valid
  data %>% filter(
    state %in% state %>% view()
  )
  ## Return hospital name in that state with lowest 30-day death
  ## rate
}


rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
}

