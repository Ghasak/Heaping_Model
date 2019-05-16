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
set.seed(123)

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
# FF<-array(0,dim=c(length(RDVAR),Draws,2))
#   #print (Gender[q])
#   for (q in 1:length(RDVAR)){
#     #print(cbind(Gender[q],MUD1[q],MUD2[q]))
#     
#   if((RDVAR[q] %% 100 == 0) & (RDVAR[q] %% 500 != 0)){
#     #-----------------------------MOD of 100-------------------------------#
#     
#     D1upper[q] = RDVAR[q]+50 
#     D1lower[q] = RDVAR[q]-50
#     D2upper[q] = 0
#     D2lower[q] = -Inf
#     MUD1[q] = Data[q,4]
#     MUD2[q] = Data[q,5]
#     #print (c(q,"MOD of 100",MUD1[q],MUD2[q]))
#     #X[q,1:1000] 
#     tmp <- rtmvnorm(n=Draws, mean=c(MUD1[q],MUD2[q]),
#                    sigma=VCMatrix, lower=c(log(D1lower[q]), D2lower[q]), upper=c(log(D1upper[q]),D2upper[q]),
#                    algorithm="gibbs")
#     for(i in 1:Draws){
#       for(j in 1:2){
#         #print(c(q,i,j))
#         FF[q,i,j] = tmp[i,j]
#       }
#     }
#     #----------------------------------------------------------------------#
#   } else if((RDVAR[q] %% 500 == 0) & (RDVAR[q] %% 1000 != 0)){
#     
#     D1upper[q] = RDVAR[q]+250 
#     D1lower[q] = RDVAR[q]-250
#     D2upper[q] = 1.63
#     D2lower[q] = -Inf
#     MUD1[q] = Data[q,4]
#     MUD2[q] = Data[q,5]
#     #print (c(q,"MOD of 500",MUD1[q],MUD2[q]))
#     tmp2 <- rtmvnorm(n=Draws, mean=c(MUD1[q],MUD2[q]),
#                     sigma=VCMatrix, lower=c(log(D1lower[q]),D2lower[q]), upper=c(log(D1upper[q]),D2upper[q]),
#                     algorithm="gibbs")
#     for(i in 1:Draws){
#       for(j in 1:2){
#         #print(c(q,i,j))
#         FF[q,i,j] = tmp2[i,j]
#       }
#     }
#   }
#     else if (RDVAR[q] %%1000 ==0){
#       D1upper[q] = RDVAR[q]+500 
#       D1lower[q] = RDVAR[q]-500
#       D2upper[q] = Inf
#       D2lower[q] = -Inf
#       MUD1[q] = Data[q,4]
#       MUD2[q] = Data[q,5]
#       #print (c(q,"MOD of 1000",MUD1[q],MUD2[q]))
#       tmp3 <- rtmvnorm(n=Draws, mean=c(MUD1[q],MUD2[q]),
#                       sigma=VCMatrix, lower=c(log(D1lower[q]), D2lower[q]), upper=c(log(D1upper[q]),D2upper[q]),
#                       algorithm="gibbs")
#       for(i in 1:Draws){
#         for(j in 1:2){
#           #print(c(q,i,j))
#           FF[q,i,j] = tmp3[i,j]
#         }
#       }
#     }
#     #print(c(q,Gender[q],RDVAR[q],MUD1[q],MUD2[q],D1upper[q],D1lower[q],D2upper[q],D2lower[q]))
#     #write.csv(FF[q,,], paste(c("/Users/Ghasak/Desktop/All_Individual_Dataset/",q,".csv"), collapse = ''),append = T)
# }
# 
# 
# 
# 
# 
# 
# 
# # Draw case 1 2 and 3
# 
# k1 <- FF[1,,]
# k2 <- FF[500,,]
# k3 <- FF[972,,]
# hist(exp(k1[,1]))
# hist(exp(k2[,1]))
# hist(exp(k3[,1]))


# #===========================================================================================
# # This to check existed matrix and see if it bounded
# #===========================================================================================
# 
# # Testing the while loop
# Q500 <- FF[500,1:10,]
# DD = 10 # Number of draws
# count <- 1
# 
# YS = as.matrix(exp(Q500[,1]),nrow(Q500[,1]),1)
# ZS  = as.matrix(exp(Q500[,2]),nrow(Q500[,1]),1)
# #SS =  matrix(0,nrow(YS),2)
# 
# 
# for (q in 1:length(RDVAR)){
# while (count < DD){
#   if(ZS[q]>0){
#     if ((YS[q]<(450)) &(YS[q]>550)){
#       SS = rtmvnorm(n=1, mean=c(MUD1[500],MUD2[500]),
#                     sigma=VCMatrix, lower=c(log(D1lower[500]),D2lower[500]), upper=c(log(D1upper[500]),D2upper[500]),
#                     algorithm="gibbs")
#       SS1[q,,]=SS
#       print(count)
#       
#       
#     }
#   }
#   
#   
#   count = count+1
# }
# }
# 


# 
# #===========================================================================================
# # Lets try here to do the real draw not to check the existed one
# #===========================================================================================
# 
# # Testing the while loop
# Q500 <- FF[500,1:10,]
# DD = 10 # Number of draws
# count <- 1
# 
# YS = as.matrix(exp(Q500[,1]),nrow(Q500[,1]),1)
# ZS  = as.matrix(exp(Q500[,2]),nrow(Q500[,1]),1)
# SS =  0
# 
# 
# 
# Draws =10
# YZS = array(0,dim=c(length(RDVAR),Draws,2))
# SS1 = array(0,dim=c(length(RDVAR),Draws,2))
# #array(0,dim=c(length(Draws),Draws,2))
# 
# i = 1
# 
#         for (q in 1:length(RDVAR)){
#             if((RDVAR[q] %% 500 == 0) & (RDVAR[q] %% 1000 != 0)){
# 
#                 D1upper[q] = RDVAR[q]+250 
#                 D1lower[q] = RDVAR[q]-250
#                 D2upper[q] = 1.63
#                 D2lower[q] = -Inf
#                 MUD1[q] = Data[q,4]
#                 MUD2[q] = Data[q,5]
#                       while (count < Draws){
# 
#                         SS = rtmvnorm(n=1, mean=c(MUD1[q],MUD2[q]),
#                                       sigma=VCMatrix, lower=c(log(D1lower[q]),D2lower[q]), upper=c(log(D1upper[q]),D2upper[q]),
#                                       algorithm="gibbs")
#                         
#                               if((SS[2]>0)&&(SS[2]<D2upper[q])){
# 
#                                     if ((exp(SS[1])<(RDVAR[q]-50)) && (exp(SS[1]>RDVAR[q]+50))){
#                                     #set.seed(123)
#                                      
#                                       #print(c(q,i,j))
#                                       SS1[q,i,1] = SS[1]
#                                       SS1[q,i,2] = SS[2]
#                                       i = i +1
#                                               
#                                     
#                                     #   
#                                     # 
#                                     # SS1[q,,]=SS
#                                     print(count)
#                                     count = count+1
#                                     }
#                               }
#                             
#                       }
#             }
#         }
# 
# 
# #===========================================================================================
# # Checking how to sample of one value at a time compared to DDD times at once
# # this comparison is working only when there is a zero covariance (Independent events).
# # Fri Dec 14th 17:31 
# #===========================================================================================
# 
# DDD=1000
# GH1=matrix(0,DDD,1)
# GH2=matrix(0,DDD,1)
# #VCMatrix= matrix(c(0.51, 0.56, 0.56, 1.00), 2, 2)
# VCMatrix2= matrix(c(1, 0, 0, 1.00), 2, 2)
# # Draw 1 with loop from the same function
# for (k in 1:DDD){
# 
# GH =rtmvnorm(n=1, mean=c(MUD1[500],MUD2[500]),
#                   sigma=VCMatrix2, lower=c(-Inf,-Inf), upper=c(Inf,Inf),
#                   algorithm="gibbs")
#           # rtmvnorm(n=1, mean=c(MUD1[500],MUD2[500]),
#           #                     sigma=VCMatrix, lower=c(log(D1lower[500]),D2lower[500]), upper=c(log(D1upper[500]),D2upper[500]),
#           #                     algorithm="rejection")
# GH1[k]=GH[1]
# GH2[k]=GH[2]
# }
# 
# cbind(GH1,GH2)
# 
# JHN =0
#  # drawing DDD at once from the function as suggested by Jahn Sensei
# JHN = rtmvnorm(n=DDD, mean=c(MUD1[500],MUD2[500]),
#                     sigma=VCMatrix2, lower=c(-Inf,-Inf), upper=c(Inf,Inf),
#                     algorithm="gibbs")
#           # rtmvnorm(n=DDD, mean=c(MUD1[500],MUD2[500]),
#           #          sigma=VCMatrix, lower=c(log(D1lower[500]),D2lower[500]), upper=c(log(D1upper[500]),D2upper[500]),
#           #          algorithm="gibbs")
# print ("=======Original Values==============")
# print(cbind(MUD1[500],MUD2[500]))
# print(VCMatrix)
# print ("=======Mean=========================")
# print(cbind(mean(GH1),mean(GH2)))
# print(cbind(mean(JHN[,1]),mean(JHN[,2])))
# print ("=======Standard Devation============")
# print(cbind(sd(GH1),sd(GH2)))
# print(cbind(sd(JHN[,1]),sd(JHN[,2])))
# 




#===========================================================================================
# I will try here to run the same program for the observation of 500 only 
# to element any confusion about all individuals
# 
#===========================================================================================

drawx=10
GH1=matrix(0,drawx,1)
GH2=matrix(0,drawx,1)
Q500 = RDVAR[500]
    D1upper[500] = RDVAR[500]+50
    D1lower[500] = RDVAR[500]-50
    D2upper[500] = 0
    D2lower[500] = -Inf
    MUD1[500] = Data[500,4]
    MUD2[500] = Data[500,5]

#VCMatrix= matrix(c(0.51, 0.56, 0.56, 1.00), 2, 2)
VCMatrix2= matrix(c(0.51, 0.56, 0.56, 1.00), 2, 2)
# Draw 1 with loop from the same function
count=1
      while (count <= drawx){
            
                  GH =rtmvnorm(n=1, mean=c(MUD1[500],MUD2[500]),
                               sigma=VCMatrix, lower=c(log(D1lower[500]),D2lower[500]), upper=c(log(D1upper[500]),D2upper[500]),
                               algorithm="gibbs")
                          # rtmvnorm(n=1, mean=c(MUD1[500],MUD2[500]),
                          #                     sigma=VCMatrix, lower=c(log(D1lower[500]),D2lower[500]), upper=c(log(D1upper[500]),D2upper[500]),
                          #                     algorithm="rejection")

                  # Accept and reject values
                  
                  if ((GH[1] <(log(D1upper[500]))) && (GH[2]<0)){
                    GH1[count]=GH[1]
                    GH2[count]=GH[2]
                    print(count)
                    count = count+1
                  } else if ((GH[1] <(log(D1upper[500]))) && (GH[2]<0)){
                    
                    
                  }
                  
            
              # U = as.matrix(cbind(GH1,GH2),10,2)
      }


    
      
