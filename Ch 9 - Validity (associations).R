#####################################################################
## Syntax for Chapter 9 of "Psychometrics: An Introduction" (Furr) ##
##                                                                 ##
## Conducting the Quantifying Construct Validity procedure         ##
## Correction for range restriction                                ##
## Binomial Effect Size Display (BESD)                             ##  
## Taylor-Russell calculations                                     ##   
## Sensitivity/Specificity analysis                                ##
## Test of Statistical Significance for a correltion               ##
#####################################################################

#1 Conducting the Quantifying Construct Validity procedure (with plot)
#install.packages("qcv")
library(qcv)
nrow(motdat)
medr(motdat[,c("dep","mach","dis","res","se","ext",
               "agr","comp","psc","sm","anx","nfb")])
actr(motdat)
actrIM  = c(.46, .13, -.24, -.03, .12, .03, .39, .06, .51, .08, .24, .66)
predrIM = c(.58, .24, -.04, .06, -.04, .18, .36, .08, .64, .56, .36, .56)
qcv(n=90, medr=.075, actr  = actrIM, predr = predrIM)
labelsIM <- c("Dep","Mach","Dis","Res","SE","Ext","Agr","Comp","PSC","SM","Anx","NTB")
plotqcv(actr=actrIM, predr=predrIM, labels=labelsIM)

#2 Correcting a correlation for range restriction
#install.packages("psychometric")
library(psychometric)
cRRr(rr = .474, sdy = 129.55, sdyu=181.63)


#3 BESD
besd<- function(r) {
 A <- 100*(r/2)+50; B <- 100-A ;   D <- A;  C <- B
 besdout <- matrix(c(A, B, C, D), nrow=2,
                    dimnames = list(c("PredLow", "PredHigh"),
                                    c("OutLow", "OutHigh")))
 besdout
}
besd(r=.48)


#4 Sensitivity/Specificity analysis
#install.packages("caret")
library(caret)
sstable <- matrix(c(80, 120, 
                    20, 780), byrow=TRUE, nrow=2,
                  dimnames = list(c("Pres", "Abs"),
                                  c("Pres", "Abs")))
sstable <- as.table(sstable)
sstable
sensitivity(sstable, positive="Pres")
specificity(sstable, positive="Pres")
posPredValue(sstable, positive="Pres")
negPredValue(sstable, positive="Pres")


#5 Taylor-Russell calculations
#install.packages("iopsych")
library(iopsych)
trModel(rxy=.30, sr=.10, br=.60)


#6 Test of statistcial significance for a correlation 
cor.test(motdat$imscale, motdat$dep)


citation("qcv")
citation("psychometric")
citation("caret")
citation("iopsych")
