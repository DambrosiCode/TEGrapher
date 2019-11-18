cmh.pvals <- function(data, num.of.pop, cov, Ne, gen, repl, poolsize, IntGen = T){
  if (!requireNamespace("ACER", quietly = TRUE))
    install.packages("ACER")
  libary(ACER)

  data.afMat <- as.matrix(data[9:(num.of.pop+8)])

  data.covMat <- matrix(cov, nrow = nrow(data.afMat), ncol = ncol(data.afMat))

  p <- adapted.cmh.test(freq = data.afMat, coverage = data.covMat,
                        Ne = Ne,
                        gen = gen, repl = repl,
                        poolSize = poolsize,
                        IntGen = IntGen)
  return(p)
}

#cmh.pvals(data = te, num.of.pop = 6, cov = 15, Ne = c(120, 250, 150),
 #         gen = c(0,8), repl = c(1,2,3), poolsize = c(100, 100, 39, 100, 100, 100))
