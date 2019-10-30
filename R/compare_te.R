#' Generates graph with moving average of TE insertion frequency and count
#' @param data Data sheet
#' @param pop Population from which to build graph
#' @param chrom Chromosome from population
#' @param gene (Optional) Gene or genes to mark on graph with vertical line
#' @param mean.window Size of window averaging frequency
#' @param total.window Size of window averaging TE count
#' @mean.fit (Default 0.2) Fit of Loewess curve for frequency
#' @total.fit (Default 0.2) Fit of Loewess curve for count
#' @export
#' @example
#' compare(data = te, pop = CH2012, chr = "chrIV", gene = 12e6, mean.window = 30000, total.window = 30000, mean.fit = 0.2, total.fit = 0.2)

compare <- function(data, pop, chrom, gene, mean.window, total.window, mean.fit = .2, total.fit = .2){
  require(ggplot2)

  #get chromosome
  chr <- data[which(data$Chr == chrom),]

  #get frequency and totals vectors
  if (is.na(gene)) {
    rs.freq <- mean.te(mean.window, chr, pop)
    rs.totals <- add.te(total.window, chr)
  } else{
    rs.freq <- mean.te(mean.window, chr, pop, gene)
    rs.totals <- add.te(total.window, chr, gene)
  }
  #get data for graph
  sum.max <- rs.totals[which.max(rs.totals[,2]),2]

  y2 <- rs.totals[,2] / sum.max
  x2 <- rs.totals[,1]

  y1 <- rs.freq[,2]
  x1 <- rs.freq[,1]

  #make sure data frames are equal
  for (i in (length(rs.freq[,1])-1):length(rs.totals[,1])+1) {
    x2[i] <- NA
    y2[i] <- NA
  }
  df <- data.frame(x1, y1, x2, y2)

  #plot
  c <- ggplot(df, aes(x1, y = value, color = Legend)) +
    geom_point(aes(y = y2, x = x2, col = "Total"), size = 1) +
    geom_point(aes(y = y1, x = x1, col = "Freq"), size = 1) +
    geom_smooth(span = total.fit, aes(y = y2, x = x2, col = "Total Fit"), size = 1, se = F) +
    geom_smooth(span = mean.fit, aes(y = y1, x = x1, col = "Freq Fit"), size = 1, se = F) +
    scale_color_manual(values = c('purple', 'blue', 'orange', 'red')) +
    geom_vline(aes(xintercept = gene[1]+span)) +
    xlab("Physical Position") + ylab("Freq") + ggtitle(paste(chrom, "of Pop", pop)) +
    scale_y_continuous(sec.axis = sec_axis(~.*sum.max, name = "Count"))

  #debug

  #plot
  return(c)
}
