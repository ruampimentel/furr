#####################################################################
## Syntax for Chapter 4 of "Psychometrics: An Introduction" (Furr) ##
##                                                                 ##   
## Conducts EFA on all three corr matrices in the chapter          ##
## Conducts EFA on the MRS and MTS items                           ##
#####################################################################

#1 Install and activate the psych package
#install.packages("psych")
library(psych)
library(GPArotation)

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
load(file="MRMTch3.Rdata")
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



MRMTch3 %>% names

## By myself based on Greg's class -----
data_rp <- MRMTch3 %>% select(MRS_1:SWL_5)
data_rp %>% names
MRMTout_3 <- fa(data_rp,
                fm="pa", 
                nfactors = 3, 
                rotate = "oblimin")
MRMTout_3 %>% summary()


MRMTout_5 <- fa(data_rp, 
                fm="pa", 
                nfactors = 5, 
                rotate = "oblimin")
MRMTout_5 %>% summary()
MRMTout_5$loadings %>% print(sort = T)
MRMTout_5$Structure %>% print(sort = T)


MRMTout_5 %>% print.psych(sort = T)

# PCA Oblimin - Oblique
MRMTout_5_pca_ob <- principal(data_rp, 
                       nfactors = 5,
                       rotate = "oblimin",
                       scores = TRUE)
MRMTout_5_pca_ob %>% print.psych(sort = T)

MRMTout_5_pca_ob %>% summary()

MRMTout_5_pca_ob$loadings %>% print(sort = T)

MRMTout_5_pca_ob$Structure %>% print(sort = T)
MRMTout_5_pca_ob$r.scores %>% 
  round(2)

## PCA Varimax - Orthogonal
MRMTout_5_pca_varimax<- principal(data_rp, 
                              nfactors = 5,
                              rotate = "varimax")

MRMTout_5_pca_varimax$loadings 


MRMTout_3_pca_varimax<- principal(data_rp, 
                                  nfactors = 3,
                                  rotate = "varimax")

MRMTout_3_pca_varimax %>%  print.psych(sort = T)
MRMTout_3_pca_varimax$loadings
MRMTout_3_pca_varimax$Structure

### ---------------------------------------------------------
### -------------- 3. Psychometrics--------------------------
### Not from furr but from another website
### source: https://eiko-fried.com/creating-basic-psychometric-summaries-in-r/
### ---------------------------------------------------------
#remotes::install_github('rapporter/pander')
library("pander")
library("summarytools")
library("readr")
library("dplyr")
library("psych")
library("qgraph")
library("bootnet")
library("OpenMx")
library("EGAnet")
library("lavaan")

MRMTch3 %>% 
  names

### A. Descriptives and correlation

data <- MRMTch3 %>% 
  select(MRS_1:SWL_5) %>% 
  na.omit()

view(dfSummary(data))


cor_mat <- cor(data)
summary(vechs(cor_mat))
means_cor <- mean(vechs(cor_mat))

qgraph(cor_mat, 
       cut=0, 
       layout="spring", 
       title=paste("Correlation matrix, mean correlation = ",  
                   round(means_cor, digits=2), sep=" ")
       )

library(PerformanceAnalytics)

# Easy nice Correlation graph ----
data %>% 
  chart.Correlation(histogram=TRUE, pch=19)

library(corrplot)

corrplot(cor_mat, method="circle")
corrplot(cor_mat, method="color", tl.col="black")
corrplot(cor_mat, type="upper")
# correlogram with hclust reordering
corrplot(cor_mat, type="upper", order="hclust")

### B. Eigenvalue decomposition
ev <- plot(eigen(cor(data))$values, type="b",
           ylab="Value", xlab="Number of Eigenvalues")

### C. Number of components and factors
fac_comp <- fa.parallel(data)
fa.parallel(data)

### D. Network and communities
nw_ega <- EGA(data)
summary(nw_ega)

### E. CFA
alpha_scale <- psych::alpha(data); alpha_scale$total$std.alpha

cfa_scale <- 'factor1  =~ MTS_4 + MTS_6 + MTS_7 + MTS_8 + MTS_9 + MTS_10
              factor2  =~ MRS_6 + MRS_9 + MRS_10
              factor3  =~ MTS_1 + MTS_2 + MTS_3 + MTS_5
              factor4  =~ MRS_1 + MRS_2 + MRS_3
              factor5  =~ MRS_4 + MRS_5 
              factor6  =~ MRS_7 + MRS_8'

fit <- cfa(cfa_scale, data = data, std.lv=TRUE)
summary(fit, fit.measures = TRUE)





