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
load(file="MRMTch3.Rdata")

#2. Computing the mean, var, and sd easily for one variable at a time
mean(MRMTch3$MRS)
var(MRMTch3$MRS)
sd(MRMTch3$MRS)
#install.packages("sjstats")
library(sjstats)
var_pop(MRMTch3$MRS) #same as: var(x) * ((n - 1)/n)
sd_pop(MRMTch3$MRS) #sqrt of the previous output


#3 Compute several descriptives one or more variables at a time
#install.packages("psych")
library(psych)
describe(MRMTch3[,c("MRS", "MTS", "SWL")]) 

MRMTch3 %>% 
  select(MRS, MTS, SWL) %>% 
  describe() %>% 
  as_tibble(rownames = "variables") %>% 
  select(variables, n:median, min:se) %>% 
  arrange(kurtosis) %>% 
  mutate(across(is.numeric, ~round(., 2)))
  gt::gt()

#4 Plot the shape/curve of a distribution
hist(MRMTch3$MRS, 
     main ="Histogram of Moral Relativism Scale Scores",
     breaks=seq(1,5,by=.20), 
     xlab="MRS Score", 
     col="gray95")

hist(MRMTch3$MTS, 
     main ="Histogram of Moral Tolerance Scale Scores",
     breaks=seq(1,5,by=.20), 
     xlab="MTS Score", 
     col="gray95")

#5 Association between two variables - scatterplot
## make it a bit more pleasand
plot(jitter(MRMTch3$MRS, 10), 
     jitter(MRMTch3$MTS, 10), 
     pch=20)
## no jitter
plot(MRMTch3$MRS, 
     MRMTch3$MTS, 
     pch=20)

#6 Association between two variables - covariance and correlation
cov(MRMTch3$MRS, MRMTch3$MTS)
cor(MRMTch3$MRS, MRMTch3$MTS)

MRMTch3 %>% 
  select(MRS, MTS) %>% 
  cor()


#7 Correlation matrix for multiple variables
cov(MRMTch3[,c("MRS", "MTS", "SWL")]) %>% round(2)
cor(MRMTch3[,c("MRS", "MTS", "SWL")]) %>% round(2)


#8 Computing standard scores from raw scores
MRSz <- scale(MRMTch3$MRS, center=TRUE, scale=TRUE)
MRSt <- rescale(MRMTch3$MRS, mean = 50, sd = 10)
head(cbind(MRMTch3$MRS,MRSz, MRSt))
describe(cbind(MRMTch3$MRS, MRSz, MRSt))

citation(package = "sjstats")
citation(package = "psych")
