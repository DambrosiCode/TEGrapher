chr.getter <- function(data, chr){
  chr <- data[which(data$Group == chr),]
  return(chr)
}
