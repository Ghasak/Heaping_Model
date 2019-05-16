# ##########################################################################
# dev.off(dev.list()["RStudioGD"]) # clean the Graph Area
# rm(list=ls())                    # clean the Workspace (dataset)
# cat("\014")                      # clean the console area
# graphics.off()                   # close graphics windows (For R Script)
# #########################################################################

# Geneerate a multivariate normal distributed random numbers and examing the results
# I will try to test the random parameter theory here with a short example:

observations = 100;
X ={};
mu1 = 0.4
std1 = 0.11
X = mu1+std1*rnorm(observations,0,1);
X=as.matrix(X,observations,1)
B0 = 2
B1 = 2

# Generate a random values for the erro term to get tested observation (count (Yo))
# since we are having 10 observation we will have 10 random values
mud =0.000000001
stdd =0.78
Rn1 =as.matrix(rnorm(observations,mud,stdd),observations,1)


lambda1=exp(B0+B1*X+Rn1)
YO = round(lambda1) 

Draws=1000
RX = as.matrix(0+1*rnorm(Draws,1),Draws,1)

#================================================================================
#                    Maximum Likelihood of Univariate Poisson
#================================================================================
library (maxLik)

LLF <<- function (param){
  #lambda2   = matrix(0,length(X),1);
  lambda2 = exp(param[1]+param[2]*X)
  lnup = dpois(YO,lambda = lambda2,log = TRUE)
  # browser()
  
  return(sum(lnup))
  
}
start = c(0,0)

ML1 <- maxLik(LLF, start = start,method = "bfgs")
print(summary(ML1))
library( sandwich )
# H1 = ML1$hessian
# Gradx <- numericGradient( LLF,c(2.78313,3.53139) )
# G1 =(t(Gradx)%*%(Gradx))
# G2 = (solve(H1)%*%G1%*%solve(H1))
# V = solve(G2)
# SE2 = sqrt(diag(V))

#================================================================================
#           Maximum Simulated Likelihood of Univariate Poisson Lognorm
#================================================================================


    LLF2 <<- function (param){
     lambda3   = matrix(0,length(RX),1);
      PULN      = matrix(0,length(q),1);
      YO        =as.matrix(YO,length(X),1)
        
        for (q in 1:length(X)) {
          # cat("\014") 
          # print(c("Indivdiual ",q))
            Sumx= matrix(0,length(RX),1)
              for (r in 1:length(RX)) {
                  #mu     = exp(param[3]);
                  sigma = exp(param[3]);
                  lambda3[r]=exp(param[1]+param[2]*X[q]+(sigma*RX[r]))   #mu+ 
                  Sumx[r] =exp((YO[q])*(log(lambda3[r]))-(lambda3[r])-lfactorial(YO[q]))
              }
            PULN[q]=sum(Sumx)/length(RX)
        }
        #browser()
        return(log(PULN))
    }
start2= c(1,1,log(stdd))  #log(mud),
ML2 <- maxLik(LLF2, start = start2,method = "bfgs"
              ,control=list(printLevel=2)
              )

print(summary(ML2))  #,robust=TRUE

# Calculate the Hessian Sandwich Estimator
library(sandwich)
library(lmtest)
G <- ML2$gradient
H <- ML2$hessian
sqrt(-solve(hessian(ML2)))
SE1 <- diag(sqrt(-solve(H)))
coeftest(ML2, vcov=sandwich)
vcov(ML2) # Caculate the variance-covariance matrix 
coef(ML2)
logLik(ML2)


# Extract the gradients evaluated at each observation
library( sandwich )
Gradx <- estfun( ML2 )

# How to caculate the numerical gradient
Grad <-numericGradient(LLF2,coef(ML2)) #coef(ML2) c(2.561980,3.33142 ,-1.319369)
GX <- cbind(mean(Grad[,1]),mean(Grad[,2]),mean(Grad[,3]))
GX <-as.matrix(GX,3,1)
all.equal( c( estfun( ML2 ) ), GX )

JacobianX =(t(Gradx)%*%(Gradx))
HessianX = ML2$hessian
G2 = (solve(HessianX)%*%(JacobianX)%*%solve(HessianX))
V = (G2) # variance-covariance matrix is actually the estimator above
SE2 = sqrt(diag(V))


# Comparison among the two different estimators
cbind(SE1,SE2)
cbind(coef(ML2)/SE1,coef(ML2)/SE2)

# 
# ## Estimate the parameter of exponential distribution
# t <- rexp(100, 2)
# loglik <- function(theta) log(theta) - theta*t
# gradlik <- function(theta) 1/theta - t
# hesslik <- function(theta) -100/theta^2
# ## Estimate with numeric gradient and hessian
# a <- maxLik(loglik, start=1, control=list(printLevel=2))
# summary( a )
# ## Estimate with analytic gradient and hessian
# a <- maxLik(loglik, gradlik, hesslik, start=1)
# summary( a )
# # Go backword to caculate the
# 
# # How to caculate the numerical gradient
# Grad <-numericGradient(LLF2,c(2.561980,3.33142 ,-1.319369))
# GX <- cbind(mean(Grad[,1]),mean(Grad[,2]),mean(Grad[,3]))
# HessNumeric <-numericHessian(LLF2,grad=NULL,c(2.561980,3.33142 ,-1.319369))
# 
# # 	G=inv(_max_HessCov)*(_max_XprodCov)*inv(_max_HessCov)
# # V=inv(G)
# # SE=sqrt(diag(V))
# G1 =G%*%t(G)
# G2 = (solve(H)*G1*solve(H))
# V = solve(G2)
# SE = sqrt(diag(V))
# 


# log-likelihood for normal density
# a[1] - mean
# a[2] - standard deviation
# ll <- function(a) sum(-log(a[2]) - (x - a[1])^2/(2*a[2]^2))
# x <- rnorm(100) # sample from standard normal
# ml <- maxLik(ll, start=c(1,1))
# # ignore eventual warnings "NaNs produced in: log(x)"
# summary(ml) # result should be close to c(0,1)
# hessian(ml) # How the Hessian looks like
# sqrt(-solve(hessian(ml))) # Note: standard deviations are on the diagonal
# #
# # Now run the same example while fixing a[2] = 1
# mlf <- maxLik(ll, start=c(1,1), activePar=c(TRUE, FALSE))
# summary(mlf) # first parameter close to 0, the second exactly 1.0
# hessian(mlf)
# # Note that now NA-s are in place of passive
# # parameters.
# # now invert only the free parameter part of the Hessian
# sqrt(-solve(hessian(mlf)[activePar(mlf), activePar(mlf)]))
# # gives the standard deviation for the mean


# # A simple example with Gaussian bell surface
# f0 <- function(t0) exp(-t0[1]^2 - t0[2]^2)
# numericGradient(f0, c(1,2))
# numericHessian(f0, t0=c(1,2))
# 
# # An example with the analytic gradient
# gradf0 <- function(t0) -2*t0*f0(t0)
# numericHessian(f0, gradf0, t0=c(1,2))
# # The results should be similar as in the previous case
# 
# # The central numeric derivatives are often quite precise
# compareDerivatives(f0, gradf0, t0=1:2)
# # The difference is around 1e-10
#================================================================================
#           check the function is working or not
#================================================================================
# param= c(1,1,log(mud),log(stdd))
# lambda3   = matrix(0,length(RX),1);
# PULN      = matrix(0,length(q),1);
# YO        =as.matrix(YO,length(X),1)
# 
# for (q in 1:length(X)) {
#   Sumx= matrix(0,length(RX),1)
#   for (r in 1:length(RX)) {
#     mu     = exp(param[3]);
#     sigma = exp(param[4]);
#     lambda3[r]=exp(param[1]+param[2]*X[q]+(mu+sigma*RX[r]))
#     Sumx[r] =exp((YO[q])*(log(lambda3[r]))-(lambda3[r])-lfactorial(YO[q]))
#   }
#   PULN[q]=sum(Sumx)/length(RX)
# }
# 
# # Probability in Univaraite Poisson
# UP = dpois(YO,lambda = lambda1,log = F)
# cbind(UP,PULN)


# 
# L1 =matrix(1,5,1)
# L2 = 2*L1
# L3 =matrix(1,5,1)
# L4 =3*L3
# 


#============================================================
# Maximum Likelihood Function without log in the Poisson fun.
#============================================================

LLF4 <<- function (param){
  lambda4   =  matrix(0,length(RX),1);
  PULN4     =  matrix(0,length(q),1);
  YO        =  as.matrix(YO,length(X),1)
  
  for (q in 1:length(X)) {
    # cat("\014") 
    # print(c("Indivdiual ",q))
    Sumx= matrix(0,length(RX),1)
    for (r in 1:length(RX)) {
      #mu     = exp(param[3]);
      sigma = exp(param[3]);
      lambda4[r]=(param[1]+param[2]*X[q]+(sigma*RX[r]))   #mu+ 
      Sumx[r] =((YO[q])*(log(lambda4[r]))-(lambda4[r])-lfactorial(YO[q]))
    }
    PULN4[q]=sum(Sumx)-length(RX)
  }
  #browser()
  return((PULN4))
}
start4= c(2,2,log(stdd))  #log(mud),
ML4 <- maxLik(LLF4, start = start4,method = "bfgs",control=list(printLevel=2))

print(summary(ML4))  #,robust=TRUE


