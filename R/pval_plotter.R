p.val.plotter <- function(p.vals, snp.data  = NaN, te.data = te, chr = 'chrIV', chr.size = NaN, sig = nrow(te.data), graphs = 2){
  require(ggplot2)

  te.data$te.p.vals <- p.vals

  te.data$log.te.p.vals <- -log(p.vals)

  te.chr <- chr.getter(data = te.data, chr = chr)

  #te.chr <- te.data[which(te.data$Group == chr),]

  sig.te <- te.chr[which(te.chr$te.p.vals <= sig/nrow(te.data)),]

  sig.te$inc.dec <- rowMeans(sig.te[,c(9,11,13)]) - rowMeans(sig.te[,c(10,12,14)])

  if (is.na(chr.size)) {
    min <- 0
    max <- te.chr$Loc[which.max(te.chr$Loc)]

    chr.size = c(min,max)
  }

  chr.peaks <- ggplot(data = sig.te, aes(x = Loc, y = log.te.p.vals)) +
    geom_point(aes(color = inc.dec, shape=sig.te$Family)) +
    xlim(xlim = chr.size) +
    scale_color_gradient2(low="blue", mid = 'white',
                          high="red") +
    ylab('-log(P)') +
    xlab('Physical Location') +
    ggtitle(paste('Chromosome', substring(chr, 4,6))) +
    labs(shape="Family", colour="Change\nPercent") +
    guides(colour = guide_colourbar(order = 2),
           shape = guide_legend(order = 1))

  if (!is.na(snp.data)) {
    snp.chr = chr.getter(snp.data, chr = chr)

    chr.peaks <- chr.peaks +
      geom_point(data = as.data.frame(snp.chr),
                 aes(x = phy_sig_pos, y = sig_pval)) +
      ggtitle(paste('Chromosome', substring(chr, 4,6), ' + SNP freq')) +
      guides(colour = guide_colourbar(order = 2),
             shape = guide_legend(order = 1))
  }

  inc.dec <- ggplot(data = sig.te, aes(x = inc.dec)) +
    geom_histogram(aes(fill = ..x..), binwidth = .1) +
    geom_vline(xintercept = 0) +
    ggtitle('Increase v/ Decrease', paste('Skewness: ', round(moments::skewness(sig.te$inc.dec), 3))) +
    xlab('Percent Change') + ylab('Count') +
    scale_fill_gradient2(low="blue", mid = 'white',
                         high="red") +
    theme_dark()

  if (graphs == 2) {
    return(ggpubr::ggarrange(chr.peaks, inc.dec))
  } else if (graphs == 1)
  {
    return(chr.peaks)
  } else if (graphs == 0) {
    return(chr.peaks)
  } else {
    print("Wrong graph parameter: \n
          Choose 0 for skew \n1 Choose 1 for plotted Pvals \nChoose 2 for both")
  }
}
