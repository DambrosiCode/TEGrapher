require(ACER)

te <- read.delim("../TE-cmh-analysis/TE Sigs/CH10-17_SC12-17_RS09-LB17.ss35.teinsertions")

colnames(te) <- c("Pop", "Group", "Loc", ".", "Name", "Family", "F/R", "-", 
                  "CH.11", "CH.17", "SC.12", "SC.17", "RS.09", "LB.17",
                  "Phys.Cov.CH.11", "Phys.Cov.CH.17", "Phys.Cov.SC.12", 
                  "Phys.Cov.SC.17", "Phys.Cov.RS.09", "Phys.CovLB.17")


cmh.pvals <- function(data, num.of.pop, cov, Ne, gen, repl, poolsize, IntGen = T){
  data.afMat <- as.matrix(data[9:(num.of.pop+8)])
  
  data.covMat <- matrix(cov, nrow = nrow(data.afMat), ncol = ncol(data.afMat))
  
  p <- adapted.cmh.test(freq = data.afMat, coverage = data.covMat, 
                        Ne = Ne,
                        gen = gen, repl = repl, 
                        poolSize = poolsize, 
                        IntGen = IntGen)
  return(p)
}

cmh.pvals(data = te, num.of.pop = 6, cov = 15, Ne = c(120, 250, 150),
          gen = c(0,8), repl = c(1,2,3), poolsize = c(100, 100, 39, 100, 100, 100))
