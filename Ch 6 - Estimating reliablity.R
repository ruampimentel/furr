#####################################################################
## Syntax for Chapter 6 of "Psychometrics: An Introduction" (Furr) ##
##                                                                 ##
## Alpha estimate of reliability of chapter's exmple data          ##
## Confidence interval around that alpha estimate                  ##
## Split-half rel. estimates of reliability of MTS data            ##
## Alpha estimate of reliability of MTS exmple data                ##
## CI around that alpha estimate                                   ##
#####################################################################

#1 Enter Chapter's example data
i1 <- c(4, 5, 5, 2)
i2 <- c(4, 2, 4, 3)
i3 <- c(5, 4, 2, 1)
i4 <- c(4, 2, 2, 2)
Ch6ex <- cbind(i1, i2, i3, i4)
Ch6ex

#2 Alpha reliability estimate of Chapter's example data
#install.packages("psych")
library(psych)
psych::alpha(Ch6ex)

psych::splitHalf(Ch6ex)

library(summarytools)
#3 Confidence Inverval around alpha 
#install.packages("psychometric")
library(psychometric)
psychometric::alpha.CI(0.621677, k=4, N=4, level = 0.95)

#4 Load the MTS data and reverse-code the negatively-keyed items
load(file="MRMTch3.Rdata")
MRMTch3[c("MTS_3", "MTS_5", "MTS_7")]  <- 6 - MRMTch3[c("MTS_3", "MTS_5", "MTS_7")]

#5 Split-half rel estimates for MTS
splitHalf(MRMTch3[c("MTS_1","MTS_2","MTS_3","MTS_4","MTS_5",
                    "MTS_6","MTS_7","MTS_8","MTS_9","MTS_10")])

#6 Alpha estimate for MTS 
psych::alpha(MRMTch3[c("MTS_1","MTS_2","MTS_3","MTS_4","MTS_5",
                       "MTS_6","MTS_7","MTS_8","MTS_9","MTS_10")])

#7 One method of evalauting tau-equivalence
#install.packages("coefficientalpha")
library(coefficientalpha)
tau.test(MRMTch3[c("MTS_1","MTS_2","MTS_3","MTS_4","MTS_5",
                   "MTS_6","MTS_7","MTS_8","MTS_9","MTS_10")], 
        varphi = 0.1)

#8 Estimating omega via the coefficientalpha package
omega(MRMTch3[c("MTS_1","MTS_2","MTS_3","MTS_4","MTS_5",
                   "MTS_6","MTS_7","MTS_8","MTS_9","MTS_10")], 
         varphi = 0.1)

citation(package = "psych")
citation(package = "psychometric")
citation(package = "coefficientalpha")


# Ruam's syntax ----
library(dplyr)
library(correlation)
library(ggplot2)

library(summarytools)
Ch6ex %>% 
  psych::alpha()

Ch6ex %>% 
  as_tibble() %>% 
  select(i1, i2) %>% 
  psych::alpha()

Ch6ex %>% 
  psych::splitHalf()

Ch6ex_cor <- Ch6ex %>% 
  as_tibble() %>% 
  correlation() %>% 
  arrange(-abs(r))

Ch6ex_cor %>% 
  summarise(r_mean = mean(r))

Ch6ex %>% 
  select()
  psych::splitHalf()




MRMTch3 %>% glimpse

## Average correlation between all items ----
### MTS ----
MRMTch3 %>% 
  select(MTS_1:MTS_10) %>% 
  correlation() %>% 
  summarise(r_mean = mean(r))

MRMTch3 %>% 
  select(MTS_1:MTS_10) %>% 
  correlation() %>% 
  ggplot(aes(x = paste(Parameter1, "with", Parameter2),
             y = r)) +
  geom_bar(stat = "identity") +
  ylim(0,1) +
  geom_errorbar(aes(x = paste(Parameter1, "with", Parameter2),
                    ymax = 0.2989879, ymin = 0.2989879),
                size=.8, linetype = "longdash", inherit.aes = F, width = 1) +
  coord_flip() +
  theme_bw()



### MRS ----
MRMTch3 %>% 
  mutate(MRS_10r = (6-MRS_10),
         MRS_6r = (6-MRS_6),
         MRS_9r = (6-MRS_9)) %>% 
  select(MRS_1:MRS_5, MRS_6r,
         MRS_7:MRS_8, MRS_9r, MRS_10r) %>% 
  correlation() %>%
  summarise(r_mean = mean(r))
  
MRMTch3 %>% 
  mutate(MRS_10r = (6-MRS_10),
         MRS_6r = (6-MRS_6),
         MRS_9r = (6-MRS_9)) %>% 
  select(MRS_1:MRS_5, MRS_6r,
         MRS_7:MRS_8, MRS_9r, MRS_10r) %>% 
  correlation() %>% 
  ggplot(aes(x = paste(Parameter1, "with", Parameter2),
             y = r)) +
  geom_bar(stat = "identity") +
  ylim(-1,1) +
  geom_errorbar(aes(x = paste(Parameter1, "with", Parameter2),
                    ymax = 0.1671565, ymin = 0.1671565),
                size=.3, linetype = "longdash", inherit.aes = F, width = 1) +
  coord_flip() +
  theme_bw()


### SWL -----
MRMTch3 %>% 
  select(SWL_1:SWL_5) %>% 
  correlation() %>% 
  summarise(r_mean = mean(r))

MRMTch3 %>% 
  select(SWL_1:SWL_5) %>% 
  correlation() %>% 
  ggplot(aes(x = paste(Parameter1, "with", Parameter2),
             y = r)) +
  geom_bar(stat = "identity") +
  ylim(0,1) +
  geom_errorbar(aes(x = paste(Parameter1, "with", Parameter2),
                    ymax = 0.5433069, ymin = 0.5433069),
                size=.8, linetype = "longdash", inherit.aes = F, width = 1) +
  coord_flip() +
  theme_bw()
  