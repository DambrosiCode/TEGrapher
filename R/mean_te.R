mean.te <- function(window.size, group, pop, area = c(0, group$Loc[which.max(group$Loc)])){
  k <- 1
  group.size <- area[2]
  step <- window.size + area[1]
  step.0 <- area[1]
  total <- matrix(ncol = 2, nrow = group.size/window.size)
  for (i in 1:((group.size/window.size)-(step.0/window.size))) {
    c <- mean(group[[pop]][which(group$Loc > step.0 & group$Loc <= step)])
    if (c > 0 & !is.na(c)) {
      total[k,1] <- (step.0+step)/2
      total[k,2] <- c
      k <- k+1
    }
    step.0 <- step.0 + window.size
    step <- step + window.size
  }
  return(na.omit(total))
}
