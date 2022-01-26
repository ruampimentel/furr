######################################################################
## Syntax for Chapter 13 of "Psychometrics: An Introduction" (Furr) ##
##                                                                  ##
## Conducting a GTheory analysis a 1-facet and 2-facet designs      ##
## Includes both G-study and D-study phases                         ##
## Includes both relative and absolute generalizabiltiy coeffs      ## 
## Includes plots from D-study analyses                             ## 
######################################################################

###########################################################
#1 Activate the "VCA" package (install if necessary)

#install.packages("VCA")
library(VCA)

###########################################################
#2 G Theory analysis of a one-facet design

load("C:\..\GTheory Table 13.1.Rdata")
# Note "long" data structure
dat13.1

# G-study phase - estimating variance components
g13.1 <- anovaVCA(score ~ target + item, dat13.1)
g13.1
g13.1$Matrices$VCall

## D-study phase ##

# Below is syntax to estimate gen coeff for different 
# designs (i.e., with different numbers of items)

# These lines extract the var components from the G study output
tvar <-  g13.1$Matrices$VCall[["target"]]
ivar <-  g13.1$Matrices$VCall[["item"]]
res  <-  g13.1$Matrices$VCall[["error"]]

# This computes rel gen coeffs for designs with 1 to 7 items
nitems <- 1:7
rgcoeff <- tvar/(tvar + res/nitems)
rgcoeff   # This shows the estimated rel gen coefficients

# This plots the estimates of the rel gen coeffs
plot(rgcoeff, type="o", xlab="# of Items", ylab="Rel Gen Coeff.",
     ylim=c(0.4, 1))

# Computes/plots *absolute* gen coeffs for designs with 1 to 7 items

agcoeff <- tvar/(tvar + ivar/nitems + res/nitems)
agcoeff

plot(agcoeff, type="o", xlab="Number of Items", 
     ylab="Abs. Gen. Coeff.", ylim=c(0.4, 1))

#########################################################
#3 G Theory analysis of a two-facet design

load("C:\...\GTheory Table 13.5.Rdata")
head(dat13.5)

# G-Study phase
g13.5 <- anovaVCA(score ~ target + item + observer +
                target*item + target*observer + item*observer,
                dat13.5)
g13.5

## D-study phase ##

# Below is syntax to estimate gen coeff for different 
# designs (i.e., with different numbers of items and observers)

# These lines extract the var components from the G study output
tvar  <- g13.5$Matrices$VCall[["target"]]
ivar  <- g13.5$Matrices$VCall[["item"]]
ovar  <- g13.5$Matrices$VCall[["observer"]]
tivar <- g13.5$Matrices$VCall[["target:item"]]
tovar <- g13.5$Matrices$VCall[["target:observer"]]
iovar <- g13.5$Matrices$VCall[["item:observer"]]
res  <-  g13.5$Matrices$VCall[["error"]]

# This computes rel gen coeffs for designs with 1 to 7 items 
# and 1,3, or 5 observers

nitems   <- 1:7
nobs     <- 1
#rerr <- tivar/nitems + tovar/nobs + res/nitems
rgcoeff1obs  <- tvar/
               (tvar + tivar/nitems + tovar/nobs + res/(nitems*nobs))
nobs     <- 3
rgcoeff3obs  <- tvar/
                (tvar + tivar/nitems + tovar/nobs + res/(nitems*nobs))
nobs     <- 5
rgcoeff5obs  <- tvar/
                (tvar + tivar/nitems + tovar/nobs + res/(nitems*nobs))

rgcoeff1obs
rgcoeff3obs
rgcoeff5obs

# This plots the estimates of the rel gen coeffs
plot(rgcoeff1obs, type="o",  ylab="Rel. Gen. Coeff.",
     ylim=c(0.4, 1), xlab="Number of Items")
lines(rgcoeff3obs, type="o", lty=2)
lines(rgcoeff5obs, type="o", lty=3)
legend("bottomright",  horiz = TRUE, lty = c(1, 2, 3),
       legend = c("1 observer", "3 Observers", "5 Observers"))

# This computes abs gen coeffs for designs with 1 to 7 items 
# and 1,3, or 5 observers

nobs     <- 1
agcoeff1obs  <- tvar/
              (tvar + ivar/nitems + ovar/nobs + tivar/nitems + tovar/nobs + iovar/(nitems*nobs) + res/(nitems*nobs))
nobs     <- 3
agcoeff3obs  <- tvar/
  (tvar + ivar/nitems + ovar/nobs + tivar/nitems + tovar/nobs + iovar/(nitems*nobs) + res/(nitems*nobs))
nobs     <- 5
agcoeff5obs  <- tvar/
             (tvar + ivar/nitems + ovar/nobs + tivar/nitems + tovar/nobs + iovar/(nitems*nobs) + res/(nitems*nobs))
      
agcoeff1obs
agcoeff3obs
agcoeff5obs

# Plost those estimates
#plot(agcoeff1obs, type="o",  ylab="Abs. Gen. Coeff.",
#     ylim=c(0.4, 1),xlab="Number of Items")
#lines(agcoeff3obs, type="o", lty=2)
#lines(agcoeff5obs, type="o", lty=3)
#legend("bottomright", horiz = TRUE, lty = c(1, 2, 3),
#       legend = c("1 observer", "3 Observers", "5 Observers"))

citation("VCA")