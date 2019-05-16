##########################################################################
dev.off(dev.list()["RStudioGD"]) # clean the Graph Area
rm(list=ls())                    # clean the Workspace (dataset)
cat("\014")                      # clean the console area
graphics.off()                   # close graphics windows (For R Script)
#########################################################################
#library(tcltk)
#X <- read.csv(tk_choose.files(caption = "Choose X"))
Data <- read.csv(file.choose())
library(tmvtnorm)
# Random number generation
set.seed(123456789)

#Data Input
Gender= Data[,2]
RDVAR = Data[,3]  # Reported distance
mu1   = Data[,4]
mu2   = Data[,5]

mu_male  =  c(6.45,0.51)
mu_femal =  c(6.25,0.32)
Draws = 1000  # Number of draws from the bivariate normal distribution
VCMatrix= matrix(c(0.51, 0.56, 0.56, 1.00), 2, 2)
#X = matrix(0,length(RDVAR),Draws)

# MUD1 = matrix(0,length(RDVAR),1)
# MUD2 = matrix(0,length(RDVAR),1)
D1upper = matrix(0,length(RDVAR),1)
D1lower = matrix(0,length(RDVAR),1)
D2upper = matrix(0,length(RDVAR),1)
D2lower = matrix(0,length(RDVAR),1)
MUD1    = matrix(0,length(RDVAR),1)
MUD2    = matrix(0,length(RDVAR),1)
# Using a 3D array to store in FF
FF<-array(0,dim=c(length(RDVAR),Draws,2))
  #print (Gender[q])
  for (q in 1:length(RDVAR)){
    #print(cbind(Gender[q],MUD1[q],MUD2[q]))
    
  if((RDVAR[q] %% 100 == 0) & (RDVAR[q] %% 500 != 0)){
    #-----------------------------MOD of 100-------------------------------#
    
    D1upper[q] = RDVAR[q]+50 
    D1lower[q] = RDVAR[q]-50
    D2upper[q] = 0
    D2lower[q] = -Inf
    MUD1[q] = Data[q,4]
    MUD2[q] = Data[q,5]
    #print (c(q,"MOD of 100",MUD1[q],MUD2[q]))
    #X[q,1:1000] 
    tmp <- rtmvnorm(n=Draws, mean=c(MUD1[q],MUD2[q]),
                   sigma=VCMatrix, lower=c(log(D1lower[q]), D2lower[q]), upper=c(log(D1upper[q]),D2upper[q]),
                   algorithm="gibbs")
    for(i in 1:Draws){
      for(j in 1:2){
        #print(c(q,i,j))
        FF[q,i,j] = tmp[i,j]
      }
    }
    #----------------------------------------------------------------------#
  } else if((RDVAR[q] %% 500 == 0) & (RDVAR[q] %% 1000 != 0)){
    
    D1upper[q] = RDVAR[q]+250 
    D1lower[q] = RDVAR[q]-250
    D2upper[q] = 1.63
    D2lower[q] = -Inf
    MUD1[q] = Data[q,4]
    MUD2[q] = Data[q,5]
    #print (c(q,"MOD of 500",MUD1[q],MUD2[q]))
    tmp2 <- rtmvnorm(n=Draws, mean=c(MUD1[q],MUD2[q]),
                    sigma=VCMatrix, lower=c(log(D1lower[q]),D2lower[q]), upper=c(log(D1upper[q]),D2upper[q]),
                    algorithm="gibbs")
    for(i in 1:Draws){
      for(j in 1:2){
        #print(c(q,i,j))
        FF[q,i,j] = tmp2[i,j]
      }
    }
  }
    else if (RDVAR[q] %%1000 ==0){
      D1upper[q] = RDVAR[q]+500 
      D1lower[q] = RDVAR[q]-500
      D2upper[q] = Inf
      D2lower[q] = -Inf
      MUD1[q] = Data[q,4]
      MUD2[q] = Data[q,5]
      #print (c(q,"MOD of 1000",MUD1[q],MUD2[q]))
      tmp3 <- rtmvnorm(n=Draws, mean=c(MUD1[q],MUD2[q]),
                      sigma=VCMatrix, lower=c(log(D1lower[q]), D2lower[q]), upper=c(log(D1upper[q]),D2upper[q]),
                      algorithm="gibbs")
      for(i in 1:Draws){
        for(j in 1:2){
          #print(c(q,i,j))
          FF[q,i,j] = tmp3[i,j]
        }
      }
    }
    #print(c(q,Gender[q],RDVAR[q],MUD1[q],MUD2[q],D1upper[q],D1lower[q],D2upper[q],D2lower[q]))
    #write.csv(FF[q,,], paste(c("/Users/Ghasak/Desktop/All_Individual_Dataset/",q,".csv"), collapse = ''),append = T)
}



# Draw case 1 2 and 3

k1 <- FF[1,,]
k2 <- FF[500,,]
k3 <- FF[972,,]
hist(exp(k1[,1]))
hist(exp(k2[,1]))
hist(exp(k3[,1]))






