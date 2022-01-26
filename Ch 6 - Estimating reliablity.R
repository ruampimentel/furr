#####################################################################
## Syntax for Chapter 6 of "Psychometrics: An Introduction" (Furr) ##
##                                                                 ##
## Alpha estimate of reliability of chapter's exmple data          ##
## Confidence interval around that alpha estimate                  ##
## Split-half rel. estimates of reliability of MTS data            ##
## Alpha estimate of reliability of MTS exmple data                ##
## CI around that alpha estimate                                   ##
#####################################################################

#1 Enter Chapter's example data
i1 <- c(4, 5, 5, 2)
i2 <- c(4, 2, 4, 3)
i3 <- c(5, 4, 2, 1)
i4 <- c(4, 2, 2, 2)
Ch6ex <- cbind(i1, i2, i3, i4)
Ch6ex

#2 Alpha reliability estimate of Chapter's example data
#install.packages("psych")
library(psych)
alpha(Ch6ex)

#3 Confidence Inverval around alpha 
#install.packages("psychometric")
library(psychometric)
alpha.CI(0.621677, k=4, N=4, level = 0.95)

#4 Load the MTS data and reverse-code the negatively-keyed items
load(file="C:/.../MRMTch3.Rdata")
MRMTch3[c("MTS_3", "MTS_5", "MTS_7")]  <- 6 - MRMTch3[c("MTS_3", "MTS_5", "MTS_7")]

#5 Split-half rel estimates for MTS
splitHalf(MRMTch3[c("MTS_1","MTS_2","MTS_3","MTS_4","MTS_5",
                    "MTS_6","MTS_7","MTS_8","MTS_9","MTS_10")])

#6 Alpha estimate for MTS 
psych::alpha(MRMTch3[c("MTS_1","MTS_2","MTS_3","MTS_4","MTS_5",
                       "MTS_6","MTS_7","MTS_8","MTS_9","MTS_10")])

#7 One method of evalauting tau-equivalence
#install.packages("coefficientalpha")
library(coefficientalpha)
tau.test(MRMTch3[c("MTS_1","MTS_2","MTS_3","MTS_4","MTS_5",
                   "MTS_6","MTS_7","MTS_8","MTS_9","MTS_10")], 
        varphi = 0.1)

#8 Estimating omega via the coefficientalpha package
omega(MRMTch3[c("MTS_1","MTS_2","MTS_3","MTS_4","MTS_5",
                   "MTS_6","MTS_7","MTS_8","MTS_9","MTS_10")], 
         varphi = 0.1)


citation(package = "psych")
citation(package = "psychometric")
citation(package = "coefficientalpha")
