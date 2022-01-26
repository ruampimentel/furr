#####################################################################
## Syntax for Chapter 4 of "Psychometrics: An Introduction" (Furr) ##
##                                                                 ##   
## Conducts EFA on all three corr matrices in the chapter          ##
## Conducts EFA on the MRS and MTS items                           ##
#####################################################################

#1 Install and activate the psych package
#install.packages("psych")
library(psych)

#2. Main example from Chapter 4 (see Table 4.1 and Figure 4.6)
ex1matrix <- matrix(c(1.00,  .66,  .54,	 .00,  .00,  .00,		
                       .66, 1.00,  .59,  .00,  .00,  .00,				
                       .54,  .59, 1.00,  .00,  .00,  .00, 		
                       .00,  .00,  .00, 1.00,  .46,  .57,		
                       .00,  .00,  .00,  .46,	1.00,  .72,	
                       .00,  .00,  .00,  .57,	 .72,	1.00),
                   nrow = 6)
colnames(ex1matrix) <- c("Talkative", "Assertive", "Outgoing",
                        "Creative", "Imaginative", "Intellectual")
eigen(ex1matrix, only.values = TRUE)
VSS.scree(ex1matrix)
ex1out <- fa(ex1matrix, fm="pa", nfactors = 2, rotate = "promax")
print(ex1out, sort=TRUE)

#3. Example 2 from Chapter 4 (see Table 4.2a and Figure 4.7)
ex2matrix <- matrix(c(1.00,  .65,  .45,	 .15,  .22,  .23,		
                       .65, 1.00,  .55,  .22,  .20,  .25,			
                       .45,  .55, 1.00,  .20,  .12,  .22, 		
                       .15,  .22,  .20, 1.00,  .50,  .60,		
                       .22,  .20,  .12,  .50,	1.00,  .65,	
                       .23,  .25,  .22,  .60,	 .65,	1.00),
                   nrow = 6)
colnames(ex2matrix) <- c("Item1","Item2","Item3","Item4","Item5","Item6")
eigen(ex2matrix, only.values = TRUE)
VSS.scree(ex2matrix)
ex2out <- fa(ex2matrix, fm="pa", nfactors = 2, rotate = "promax")
print.psych(ex2out, sort=TRUE)

#4. Example 3 from Chapter 4 (see Table 4.2b and Figure 4.8)
ex3matrix <- matrix(c(1.00,  .26,  .25,  .05, -.02,  .13,		
                       .26, 1.00,  .15, -.03,  .00,  .05,
                       .25,  .15, 1.00,  .02,  .02,  .22, 		
                       .05, -.03,  .02, 1.00,  .35,  .03,		
                      -.02,  .00,  .02,  .35, 1.00, .125,	
                       .13,  .05,  .22,  .03, .125, 1.00),
                    nrow = 6)
colnames(ex3matrix) <- c("Item1","Item2","Item3","Item4","Item5","Item6")
eigen(ex3matrix, only.values = TRUE)
VSS.scree(ex3matrix)
ex3out <- fa(ex3matrix, fm="pa", nfactors = 2, rotate = "promax", max.iter=1000)
print.psych(ex3out, sort=TRUE)


#5. Load the data, as revised via Chapter 2's syntax
load(file="C:/.../MRMTch3.Rdata")
VSS.scree(MRMTch3[c("MRS_1","MRS_2","MRS_3","MRS_4","MRS_5",
                    "MRS_6","MRS_7","MRS_8","MRS_9","MRS_10",
                    "MTS_1","MTS_2","MTS_3","MTS_4","MTS_5",
                    "MTS_6","MTS_7","MTS_8","MTS_9","MTS_10")])

MRMTout <- fa(MRMTch3[c("MRS_1","MRS_2","MRS_3","MRS_4","MRS_5",
                       "MRS_6","MRS_7","MRS_8","MRS_9","MRS_10",
                       "MTS_1","MTS_2","MTS_3","MTS_4","MTS_5",
                       "MTS_6","MTS_7","MTS_8","MTS_9","MTS_10")], 
             fm="pa", nfactors = 2, rotate = "promax")
print.psych(MRMTout, sort=TRUE)

citation(package = "psych")
