######################################################################
## Syntax for Chapter 14 of "Psychometrics: An Introduction" (Furr) ##
##                                                                  ##
## Use the 1PL & 2PL models to examine the LSAT data                ##
## Use the GRM to examine SWL data                                  ##
## Includes item parameter estimation and trait-level estimation    ##
## Includes some evaluation of model fit and unidimensionality      ## 
## Includes plots (ICC, IIC, TIC)                                   ## 
######################################################################

#################################################################
#1 Activate the ltm package. Install if necessary

#install.packages("ltm")
library(ltm)

###################################################
#2 Example with dichotomous items (using the 1PL/Rasch model)

#2a Load the data frame (5 items from the LSAT)
ddat <- LSAT

#2b Some useful descriptives
descript(ddat)

#2c Estimate item parameters via the Rasch model (1PL)
rout<- rasch(ddat)
summary(rout)

#2d Some insight into model fit:
GoF.rasch(rout)
item.fit(rout,simulate.p.value=T)
#note that this ran into some problems on some runs. If prob occurs, try again or increase G = 20)

#2e Evaluate unidimensionality
unidimTest(rout)

#2f Estimate trait scores
trait.scores.rasch <- factor.scores.rasch(rout,resp.patterns = ddat)
head(trait.scores.rasch$score.dat)
tail(trait.scores.rasch$score.dat)

#2g ICC, IIC, TIC plots 
#Plot of Item Characteristic Curves 
plot(rout, type="ICC", lty=1:5, col="black")
#Plot of Item information curves
plot(rout, type="IIC",lty=1:5, col="black")
#Plot of Test Information Curve
plot(rout, type = "IIC", items = 0, lwd=2)

###############################################################
#3 Example with dichotomous items (using the 2PL model)

#3a Get item parameters via the 2PL
out.2pl <- ltm(ddat ~ z1)
summary(out.2pl)

#3b Evaluate whether the 2PL fits the LSAT data better than the 1PL
anova(rout, out.2pl)

#3c ICC, IIC, TIC plots 
#Plot of Item Characteristic Curves 
plot(out.2pl, type="ICC", lty=1:5, col="black")
#Plot of Item information curves
plot(out.2pl, type="IIC",lty=1:5, col="black")
#Plot of Test Information Curve
plot(out.2pl, type = "IIC", items = 0, lwd=2)


##################################################################3 
#4 For polytymous items, using Graded Response Model

#4a Load the Satisfaction With Life Scale SWL responses
load(file="C:/.../MRMTch3.Rdata")

#4b IRT - Use GRM to get item parameters
out.grm <- grm(MRMTch3[,c("SWL_1","SWL_2","SWL_3","SWL_4","SWL_5")] )
out.grm

#4c ICC, IIC, TIC plots 
#PLot of item characteristic curves for item 1
plot(out.grm, type="ICC", items=1, col="black")
#Plot of Item information curve for item 1
plot(out.grm, type="IIC", items=1, col="black")
#Plot of Test Information Curve
plot(out.grm, type = "IIC", items = 0, lwd=2)

# To get irt-based trait scores for each response pattern
swl.tscore <- factor.scores.grm(out.grm)

citation("ltm")