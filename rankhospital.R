## Ranking hospitals by outcome in a state
## Follow instruction on best.R to prepare data to continue using this function

rankhospital <- function(state, outcome, num = "best") {
## Contain state and outcome value input from function into x, y, and z
x <- state
y <- outcome
z <- num
  
## Read outcome data
data <- new_outcome
  
## Check that state and outcome are valid
res <- data %>% select(Provider.Number, Hospital.Name, Address.1, City, State,
    County.Name, Phone.Number,
    contains(y)) %>% filter(
    State %in% x
    ) %>% drop_na()

## Target column for rank
target <- res[,8]

## Calculate rank using dense_rank() from dplyr
rankVal <- res %>% mutate(
     rank = dense_rank(target)
)

## Create variable to catch num input, contains : "worst", "best", or integer
rankSelector <- if(num == "best"){
  sel <- min(res[,9])
} else if(num == "worst"){
  sel <- max(res[,9])
} else {
  sel <- num
}

## Return hospital name in that state with the given rank
## 30-day death rate
}
