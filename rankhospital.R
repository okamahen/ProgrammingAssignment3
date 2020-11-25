## Ranking hospitals by outcome in a state
## Follow instruction on best.R to prepare data to continue using this function

rankhospital <- function(state, outcome, num = "best") {
## Contain state and outcome value input from function into x, y, and z
x <- state
y <- outcome

## Read outcome data
data <- new_outcome
  
## Check that state and outcome are valid
res <- data %>% select(Provider.Number, Hospital.Name, Address.1, City, State,
    County.Name, Phone.Number,
    contains(y)) %>% filter(
    State %in% x
    ) %>% drop_na()

## Target column 8 (ratio) for rank
names(res)[8] <- "dd_ratio"
## target <- res[,8]

## Creating rank with ave() function, source https://stat.ethz.ch/pipermail/r-help/2005-June/073031.html
res$dd_rank <- ave(res$dd_ratio, res$State, FUN = dense_rank)

res <- res %>% mutate(
  true_rank = rank(dd_rank, ties.method = "last")
) %>% arrange(Hospital.Name)

## Calculate rank using dense_rank() and add new column using mutate()
#rankVal <- res %>% mutate(
#     rank = dense_rank(target)
#)

## Create variable to catch num input, contains : "worst", "best", or integer
rankSelector <- if(num == "best"){
  min(res$dd_rank)
} else if(num == "worst"){
  max(res$dd_rank)
} else {
  num
}

## Create variable to contain result from filter() process
fin <- res %>% filter(
  true_rank == rankSelector
)

## Return hospital name in that state with the given rank
## 30-day death rate
view(fin)

}
