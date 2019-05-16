# ##########################################################################
# dev.off(dev.list()["RStudioGD"]) # clean the Graph Area
# rm(list=ls())                    # clean the Workspace (dataset)
# cat("\014")                      # clean the console area
# graphics.off()                   # close graphics windows (For R Script)
# #########################################################################

# Geneerate a multivariate normal distributed random numbers and examing the results


Var_Cov <- matrix(c(25, 9.9, 9.9, 4.0), 2, 2)
M <- c(4,2)  # The mean of the marginal distriburtions

draw = 1000
r_uni = runif(draw,0,1) # generate a random uniform number 

r_norm =matrix(qnorm(r_uni,0,1),draw,2) # Draw two dimensions independent with 0 mean and 1 standard deviation

r_multi_norm = (r_norm) %*% chol(Var_Cov)+ matrix(rep(M,draw), byrow=TRUE,ncol=2)
hist(r_multi_norm[,1])
hist(r_multi_norm[,2])
print(paste0("mean of marginal 1 =",mean(r_multi_norm[,1])))
print(paste0("mean of marginal 2 =",mean(r_multi_norm[,2])))


#=========================================================================#
# Generate a bivariate random normal distribution with R
#=========================================================================#
N <- 1000 # Number of random samples
set.seed(123)
# Target parameters for univariate normal distributions
rho <- 0.99
mu1 <- 4; s1 <- 5
mu2 <- 2; s2 <- 2

# Parameters for bivariate normal distribution
mu <- c(mu1,mu2) # Mean 
Var_Cov2 <- matrix(c(s1^2, s1*s2*rho, s1*s2*rho, s2^2),2) # Covariance matrix

M2 <- t(chol(Var_Cov2))
# M %*% t(M)
Z <- matrix(rnorm(2*N),2,N) # 2 rows, N/2 columns
bvn2 <- t(M2 %*% Z) + matrix(rep(mu,N), byrow=TRUE,ncol=2)
colnames(bvn2) <- c("bvn2_X1","bvn2_X2")

print(paste0("mean of marginal 1 =",mean(bvn2[,1])))
print(paste0("mean of marginal 2 =",mean(bvn2[,2])))


# Function to draw ellipse for bivariate normal data
library(mixtools)  #for ellipse
ellipse_bvn <- function(bvn, alpha){
  Xbar <- apply(bvn,2,mean)
  S <- cov(bvn)
  ellipse(Xbar, S, alpha = alpha, col="red")
}


#=========================================================================#
# Generate a trivariate random normal distribution with R
#=========================================================================#
N <- 1000 # Number of random samples
set.seed(123)
# Target parameters for univariate normal distributions
rho1 <- 0.00; rho2 <- 0.00; rho3 <- 0.00
mu1 <- 0; s1 <- 1
mu2 <- 0; s2 <- 1
mu3 <- 0; s3 <- 1
d <- 3
# Parameters for bivariate normal distribution
mu3 <- c(mu1,mu2,mu3) # Mean 

Var_Cov3 <- matrix(c(s1^2,s1*s2*rho1, s1*s3*rho2,
            s1*s2*rho1, s2^2, s2*s3*rho3,
            s1*s3*rho2, s2*s3*rho3, s3^2),3,3)


M3 <- t(chol(Var_Cov3))
# M %*% t(M)
Z <- matrix(rnorm(d*N),d,N) # 2 rows, N/2 columns
bvn3 <- t(M3 %*% Z) + matrix(rep(mu3,N), byrow=TRUE,ncol=d)
colnames(bvn2) <- c("bvn2_X1","bvn2_X2")

print(paste0("mean of marginal 1 =",mean(bvn3[,1])))
print(paste0("mean of marginal 2 =",mean(bvn3[,2])))
print(paste0("mean of marginal 3 =",mean(bvn3[,3])))

