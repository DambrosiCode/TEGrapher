column_namer <- function(data, pops){
  colnames(data) <- c("Pop", "Group", "Loc", ".", "Name", "Family", "F/R", "-",
                      pops)
  
  return(data)
}