######################################################################
## Syntax for Chapter 11 of "Psychometrics: An Introduction" (Furr) ##
##                                                                  ##
## Testing the difference between two groups' alpha values          ##
## Rank order comparisons                                           ##
## Methods for comparing EFA factor loadings across groups          ##  
## Using regression to detect predictive bias                       ##   
######################################################################

#1 Testing group differences in alpha estimates of the Moral Tolerance Scale items
load(file="C:/.../MRMTch3.Rdata")
MRMTch3[c("MTS_3", "MTS_5", "MTS_7")]  <- 6 - MRMTch3[c("MTS_3", "MTS_5", "MTS_7")]
females <- MRMTch3[which(MRMTch3$Gender=="Female"),]
males   <- MRMTch3[which(MRMTch3$Gender=="Male"),]

library(psych)
falpha <- alpha(females[c("MTS_1","MTS_2","MTS_3","MTS_4","MTS_5",
                          "MTS_6","MTS_7","MTS_8","MTS_9","MTS_10")])
malpha <- alpha(males[c("MTS_1","MTS_2","MTS_3","MTS_4","MTS_5",
                        "MTS_6","MTS_7","MTS_8","MTS_9","MTS_10")])
falpha$total$raw_alpha
malpha$total$raw_alpha

#install.packages("cocron")
library(cocron)
cocron.two.coefficients(alpha=c(.8067922,.800821), n=c(167,124), dep=FALSE)

#2 Rank order comparisons of the items means, of MTS items
falpha$item.stats$mean
malpha$item.stats$mean
frank <- c(1,8,7,4,10,5,9,3,2,6)
mrank <- c(1,7,6,4,9,8,10,3,2,5)
cor(frank, mrank, method="spearman")

#3 Congruence Coefficient, an index of factorial similarity
#  This example uses the data in Table 3 of Hartley & Furr 2017
#install.packages("multiway")
library(multiway)
NBPD <- c(.644, .728, .795, .497, .696, .496, .764, .700, .799)
BPD  <- c(.741, .731, .810, .737, .866, .594, .903, .557, .511)
congru(NBPD, BPD)

#4 Hartley & Furr (2017) approach to factorial similarity.
#  This example uses the data in Table 3 of Hartley & Furr 2017
factsim <- function(f1, f2) {
  n <- length(f1)
  GSf1  <- mean(f1)
  GSf2  <- mean(f2)
  DSf1  <- sd(f1)*sqrt((n-1)/n)
  DSf2  <- sd(f2)*sqrt((n-1)/n)
  Csim  <- cor(f1,f2)
  GSsim <- abs(GSf1 - GSf2)
  DSsim <- abs(DSf1 - DSf2)
  JGS   <- GSf1*GSf2
  JDS   <- DSf1*DSf2
  CC    <- (Csim*JDS + JGS)/
           sqrt((DSf1^2+GSf1^2)*(DSf2^2+GSf2^2))
  fsimout<- list("General Satuation, f1"=GSf1, 
                 "General Satuation, f2"=GSf2,
                 "Differential Satuation, f1"=DSf1,
                 "Differential Satuation, f2"=DSf2,
                 "Joint General Saturation"= JGS,
                 "Joint Differntial Saturation"=JDS,
                 "General Saturation Similarity"=GSsim,
                 "Diffrential Saturation Similarity"=DSsim,
                 "Configural Similarity"=Csim,
                 "Congruence Coefficient"=CC)
  return(fsimout)
}

factsim(NBPD, BPD)

#5 Detecting predictive bias via regression
# The "openintro" package includes good example data re SAT and college GPA
#install.packages("openintro")
library(openintro)
data(satgpa)
head(satgpa)

cor(satgpa$sat_sum, satgpa$fy_gpa)
lm(fy_gpa ~ sat_sum, data=satgpa)   
summary(lm(fy_gpa ~ sat_sum + sex + sat_sum*sex, data=satgpa))

lm(fy_gpa ~ sat_sum, data=satgpa[ which(satgpa$sex=='1'), ]) 
lm(fy_gpa ~ sat_sum, data=satgpa[ which(satgpa$sex=='2'), ])

plot(x=satgpa$sat_sum,y=satgpa$fy_gpa, type='n', xlab="SAT", ylab="FYGPA") ## create an empty frame
abline(a=-.217, b=.024722)  ## for g1
abline(a=-.108340, b = .026320, lty=2 )  ## for g2
legend('topleft', c('Group 1', 'Group 2'), lty=c(1,2))

citation("psych")
citation("cocron")
citation("multiway")
citation("openintro")
