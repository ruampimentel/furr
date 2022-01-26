######################################################################
## Syntax for Chapter 12 of "Psychometrics: An Introduction" (Furr) ##
##                                                                  ##
## Conducting a CFA for one group of participants                   ##
## Using CFA to evaluate CTT models                                 ##
## Estimating reliability (omega) via CFA                           ##  
## Measurement Invariance                                           ## 
######################################################################

#1 Install and activate two key packages
install.packages(c("lavaan","semTools"))
library(lavaan)
library(semTools)

# 2 General application of CFA:
# Evaluating a measurement model in a single sample of respondents
# Here, we conduct a CFA of the Satisfaction With Life Scale SWL
load(file="C:/.../MRMTch3.Rdata")

swlmod <- 'swl =~ SWL_1 + SWL_2 + SWL_3 + SWL_4 + SWL_5' 
swlfit <- cfa(swlmod, data = MRMTch3, std.lv=TRUE) 
summary(swlfit, fit.measures = TRUE, standardized=TRUE)
modindices(swlfit, sort.=TRUE)

# A modified model
swlmodrev <- 'swl =~ SWL_1 + SWL_2 + SWL_3 + SWL_4 + SWL_5 
              SWL_1 ~~ SWL_2'
swlrevfit <- cfa(swlmodrev, data = MRMTch3, std.lv=TRUE) 
summary(swlrevfit, fit.measures = TRUE, standardized=TRUE)
modindices(swlrevfit, sort.=TRUE)

#3 Evaluating CTT models via CFA
#  Here we test CTT models for the IAS, as decribed in the chapter

load(file="C:/.../ias.Rdata")

# Congeneric model
con <- 'ia =~ ias01 + ias02 + ias03 + ias04 + ias05
            + ias06 + ias07 + ias08 + ias09 + ias10
            + ias11 + ias12 + ias13 + ias14 + ias15'
confit <- cfa(con, data = ias, std.lv=TRUE,std.ov=TRUE) #

# Essentially tau-equvialent model
ete <- 'ia =~ fl*ias01 + fl*ias02 + fl*ias03 + fl*ias04 + fl*ias05
            + fl*ias06 + fl*ias07 + fl*ias08 + fl*ias09 + fl*ias10
            + fl*ias11 + fl*ias12 + fl*ias13 + fl*ias14 + fl*ias15'
etefit <- cfa(ete, data = ias, std.lv=TRUE,std.ov=TRUE) #

# Parallel model
par <- 'ia =~ fl*ias01 + fl*ias02 + fl*ias03 + fl*ias04 + fl*ias05 
            + fl*ias06 + fl*ias07 + fl*ias08 + fl*ias09 + fl*ias10
            + fl*ias11 + fl*ias12 + fl*ias13 + fl*ias14 + fl*ias15
        ias01 ~~ u*ias01; ias02 ~~ u*ias02; ias03 ~~ u*ias03
        ias04 ~~ u*ias04; ias05 ~~ u*ias05; ias06 ~~ u*ias06
        ias07 ~~ u*ias07; ias08 ~~ u*ias08; ias09 ~~ u*ias09
        ias10 ~~ u*ias10; ias11 ~~ u*ias11; ias12 ~~ u*ias12;
        ias13 ~~ u*ias13; ias14 ~~ u*ias14; ias15 ~~ u*ias15'
parfit <- cfa(par, data = ias, std.lv=TRUE,std.ov=TRUE) 

cf <- compareFit(parfit, etefit, confit)
summary(cf)

#4 Using CFA to estimate reliability (e.g., via omega)
#  Calculating omega for the IAS, as shown in the chapter

modindices(confit, sort.=TRUE)
cerr <- 'ia =~ ias01 + ias02 + ias03 + ias04 + ias05 + 
               ias06 + ias07 + ias08 + ias09 + ias10 + 
               ias11 + ias12 + ias13 + ias14 + ias15
         ias03 ~~ ias14; ias04 ~~ ias14; ias04 ~~ ias08 
         ias05 ~~ ias12; ias06 ~~ ias11; ias08 ~~ ias14 '
cerrfit <- cfa(cerr, data = ias, std.lv=TRUE)
summary(cerrfit, fit.measures = TRUE, standardized=TRUE)
reliability(cerrfit)


#5 Using CFA to evaluate measurement invariance
#  Examining the MI of the SWLS across Genders

measmodel <- 'swl =~ SWL_1 + SWL_2 + SWL_3 + SWL_4 + SWL_5' 

confit    <- cfa(measmodel, data = MRMTch3, std.lv=TRUE,
                 group="Gender") 

weakfit   <- cfa(measmodel, data = MRMTch3, std.lv=TRUE,
                         group = "Gender", 
                         group.equal = c("loadings"))

strongfit <- measEq.syntax(configural.model = confit, 
                           return.fit = TRUE,
                           group = "Gender", 
                           group.equal = c("loadings",
                                           "intercepts"))

strictfit <- measEq.syntax(configural.model = confit, 
                           return.fit = TRUE,
                           group = "Gender", 
                           group.equal = c("loadings",
                                           "intercepts",
                                           "residuals"))

cfit2 <- compareFit(confit, weakfit, strongfit,strictfit, nested=TRUE)
summary(cfit2)

citation("lavaan")
citation("semTools")
