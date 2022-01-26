#####################################################################
## Syntax for Chapter 2 of "Psychometrics: An Introduction" (Furr) ##
##                                                                 ##   
## Demonstrates how to access an R data set                        ##
## Data are from the Moral Relativism and Moral Tolerance scales   ##
##   Collier-Spruel et al. (2019), along with some demographics    ##
## Shows how to view data                                          ##
## Get a sense of the types of variables (items)                   ##
## Dealing with "factors" that represent nominal variables         ##
#####################################################################

#1. Opens the data set
load(file="C:/../.././MRMTch2.Rdata")

#2. Snapshot of the data (top few rows of data set)
names(MRMTch2)
head(MRMTch2)  

#3. See each variable's type, value labels, etc. 
str(MRMTch2)  

#4. See the value labels for the nominal variable 'Gender'
attr(MRMTch2$Gender,"value.labels")  
attr(MRMTch2$MRS_1,"value.labels")  

#5. Frequency count for the Gender variable
table(MRMTch2$Gender)

#6. "Mean" of 'Gender,' even though it's not meaningful in this context
mean(MRMTch2$Gender)  

#7. To change the Sex variable from numeric to "factor" 
MRMTch2$Gender <- factor(MRMTch2$Gender,
                              levels = c(1,2),
                              labels = c("Male", "Female"))
str(MRMTch2$Gender)
table(MRMTch2$Gender)
mean(MRMTch2$Gender)

#8. Saving the revised data set under a new name
MRMTch3 <- MRMTch2
save(MRMTch3, file = "MRMTch3.Rdata")