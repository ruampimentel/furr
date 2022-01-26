#####################################################################
## Syntax for Chapter 3 of "Psychometrics: An Introduction" (Furr) ##
##                                                                 ##   
## Computes Mean                                                   ##
## Computes Variance and Standard Deviation                        ##
## Plots distribution's curve and computes Skew                    ##
## Produces Scatterplot                                            ##
## Computes Covariance and Correlation (incl matrices)             ##
## Computes standard scores and converted standard scores          ##                                 ##
#####################################################################

#1. Load the data, as revised via Chapter 2's syntax
load(file="C:/../MRMTch3.Rdata")

#2. Computing the mean, var, and sd easily for one variable at a time
mean(MRMTch3$MRS)
var(MRMTch3$MRS)
sd(MRMTch3$MRS)
install.packages("sjstats")
library(sjstats)
var_pop(MRMTch3$MRS)
sd_pop(MRMTch3$MRS)

#3 Compute several descriptives one or more variables at a time
#install.packages("psych")
library(psych)
describe(MRMTch3[,c("MRS", "MTS", "SWL")])

#4 Plot the shape/curve of a distribution
hist(MRMTch3$MRS, main ="Histogram of Moral Relativism Scale Scores",
     breaks=seq(1,5,by=.20), xlab="MRS Score", col="gray95")

#5 Association between two variables - scatterplot
plot(jitter(MRMTch3$MRS, 10), jitter(MRMTch3$MTS, 10), pch=20)

#6 Association between two variables - covariance and correlation
cov(MRMTch3$MRS, MRMTch3$MTS)
cor(MRMTch3$MRS, MRMTch3$MTS)


#7 Correlation matrix for multiple variables
cov(MRMTch3[,c("MRS", "MTS", "SWL")])
cor(MRMTch3[,c("MRS", "MTS", "SWL")])


#8 Computing standard scores from raw scores
MRSz <- scale(MRMTch3$MRS, center=TRUE, scale=TRUE)
MRSt <- rescale(MRMTch3$MRS, mean = 50, sd = 10)
head(cbind(MRMTch3$MRS,MRSz, MRSt))
describe(cbind(MRMTch3$MRS, MRSz, MRSt))

citation(package = "sjstats")
citation(package = "psych")
