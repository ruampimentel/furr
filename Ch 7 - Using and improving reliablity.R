#####################################################################
## Syntax for Chapter 7 of "Psychometrics: An Introduction" (Furr) ##
##                                                                 ##
## Obtaining estimate true scores, std err of measurement,         ##
##   and confidence interval around scores                         ##
## Correction for attenuation                                      ##
## Item information useful for developing/refining tests to have   ##
##   good reliability                                              ##
#####################################################################

#1 Obtaining estimate true scores, std err of meas, & std err of estimate    
library("psychometric")
Est.true(obs=38, mx=30, rxx=.90)
SE.Meas(s=6, rxx=.9)
SE.Est(s=6, rxx=.9)

#2 Confidence Intervals around scores
#Note that this approach uses the SE of the estimate (rather than SeM) for the CI
CI.tscore(obs=38, mx=30, s=6, rxx=.90, level = 0.95)
#This approach uses the SE of meas, around the obs score
CI.obs(obs=38, s=6, rxx=.90, level = 0.95)

#3 Correction for attenuation
library(psych)
corrs <- matrix(c( 1.00,  .26,
                    .26, 1.00), nrow = 2)
correct.cor(x=corrs, y=c(.86, .40))

#4 Enter example data from Table 7.3
Maria	    <- c(1,1,1,1,1)
Demetrius <- c(1,1,1,1,1)
Rohit	    <- c(1,1,0,0,1)
James	    <- c(1,0,1,1,1)
Antonio	  <- c(0,0,1,0,1)
Esteban	  <- c(0,1,0,1,1)
Zoe	      <- c(0,1,1,0,1)
Emory	    <- c(1,0,0,0,0)
Fitz      <- c(1,0,0,0,0)
Claudette	<- c(0,0,0,0,1)
data <- rbind.data.frame(Maria, Demetrius, Rohit, James, Antonio, 
                         Esteban, Zoe, Emory, Fitz, Claudette)
colnames(data) <- c("i1","12","13","i4","i5")
data

#5 Reliability-related information for the example items (Table 7.3)
#  Compare to SPSS output in Table 74
cor(data)
alpha(data)

#6 Item discrimination information (for binary items, e.g. Table 7.3)
discrim(data)

#7 Load the MTS data and reverse-code the negatively-keyed items
load(file="C:/.../MRMTch3.Rdata")
MRMTch3[c("MTS_3", "MTS_5", "MTS_7")]  <- 6 - MRMTch3[c("MTS_3", "MTS_5", "MTS_7")]

# Note that alpha provides a ci by default. This is based on   
alpha(MRMTch3[c("MTS_1","MTS_2","MTS_3","MTS_4","MTS_5",
                "MTS_6","MTS_7","MTS_8","MTS_9","MTS_10")])

citation(package = "psych")
citation(package = "psychometric")
