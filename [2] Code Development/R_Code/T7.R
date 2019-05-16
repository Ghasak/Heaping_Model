rm(list=ls())
# https://www.r-bloggers.com/standard-robust-and-clustered-standard-errors-computed-in-r/
library(foreign)
#load data
children <- read.dta("/Users/ghasak/Desktop/fertil2.dta")
# lm formula and data
form <- ceb ~ age + agefbrth + usemeth
data <- children
# run regression
r1 <- lm(form, data)
# get stand errs
summary(r1)

# get X matrix/predictors
X <- model.matrix(r1)
# number of obs
n <- dim(X)[1]
# n of predictors
k <- dim(X)[2]
# calculate stan errs as in the above
# sq root of diag elements in vcov
se <- sqrt(diag(solve(crossprod(X)) * as.numeric(crossprod(resid(r1))/(n-k))))

# residual vector
u <- matrix(resid(r1))
# meat part Sigma is a diagonal with u^2 as elements
meat1 <- t(X) %*% diag(diag(crossprod(t(u)))) %*% X
# degrees of freedom adjust
dfc <- n/(n-k)    
# like before
se <- sqrt(dfc*diag(solve(crossprod(X)) %*% meat1 %*% solve(crossprod(X))))



# cluster name
cluster <- "children"
# matrix for loops
clus <- cbind(X,data[,cluster],resid(r1))
colnames(clus)[(dim(clus)[2]-1):dim(clus)[2]] <- c(cluster,"resid")
# number of clusters
m <- dim(table(clus[,cluster]))
# dof adjustment
dfc <- (m/(m-1))*((n-1)/(n-k))
# uj matrix
uclust <- matrix(NA, nrow = m, ncol = k)
gs <- names(table(data[,cluster]))
for(i in 1:m){
  uclust[i,] <- t(matrix(clus[clus[,cluster]==gs[i],k+2])) %*% clus[clus[,cluster]==gs[i],1:k] 
}
# square root of diagonal on bread meat bread like before
se <- sqrt(diag(solve(crossprod(X)) %*% (t(uclust) %*% uclust) %*% solve(crossprod(X)))*dfc)

           
 ols <- function(form, data, robust=FALSE, cluster=NULL,digits=3){
   r1 <- lm(form, data)
   if(length(cluster)!=0){
     data <- na.omit(data[,c(colnames(r1$model),cluster)])
     r1 <- lm(form, data)
   }
   X <- model.matrix(r1)
   n <- dim(X)[1]
   k <- dim(X)[2]
   if(robust==FALSE & length(cluster)==0){
     se <- sqrt(diag(solve(crossprod(X)) * as.numeric(crossprod(resid(r1))/(n-k))))
     res <- cbind(coef(r1),se)
   }
   if(robust==TRUE){
     u <- matrix(resid(r1))
     meat1 <- t(X) %*% diag(diag(crossprod(t(u)))) %*% X
     dfc <- n/(n-k)    
     se <- sqrt(dfc*diag(solve(crossprod(X)) %*% meat1 %*% solve(crossprod(X))))
     res <- cbind(coef(r1),se)
   }
   if(length(cluster)!=0){
     clus <- cbind(X,data[,cluster],resid(r1))
     colnames(clus)[(dim(clus)[2]-1):dim(clus)[2]] <- c(cluster,"resid")
     m <- dim(table(clus[,cluster]))
     dfc <- (m/(m-1))*((n-1)/(n-k))
     uclust  <- apply(resid(r1)*X,2, function(x) tapply(x, clus[,cluster], sum))
     se <- sqrt(diag(solve(crossprod(X)) %*% (t(uclust) %*% uclust) %*% solve(crossprod(X)))*dfc)   
     res <- cbind(coef(r1),se)
   }
   res <- cbind(res,res[,1]/res[,2],(1-pnorm(res[,1]/res[,2]))*2)
   res1 <- matrix(as.numeric(sprintf(paste("%.",paste(digits,"f",sep=""),sep=""),res)),nrow=dim(res)[1])
   rownames(res1) <- rownames(res)
   colnames(res1) <- c("Estimate","Std. Error","t value","Pr(>|t|)")
   return(res1)
 }
 
 # # with data as before
 # > ols(ceb ~ age + agefbrth + usemeth,children)
 # Estimate Std. Error t value Pr(>|t|)
 # (Intercept)    1.358      0.174   7.815    0.000
 # age            0.224      0.003  64.888    0.000
 # agefbrth      -0.261      0.009 -29.637    2.000
 # usemeth        0.187      0.055   3.380    0.001
 # > ols(ceb ~ age + agefbrth + usemeth,children,robust=T)
 # Estimate Std. Error t value Pr(>|t|)
 # (Intercept)    1.358      0.168   8.105    0.000
 # age            0.224      0.005  47.993    0.000
 # agefbrth      -0.261      0.010 -27.261    2.000
 # usemeth        0.187      0.061   3.090    0.002
 # > ols(ceb ~ age + agefbrth + usemeth,children,cluster="children")
 # Estimate Std. Error t value Pr(>|t|)
 # (Intercept)    1.358      0.425   3.197    0.001
 # age            0.224      0.032   7.101    0.000
 # agefbrth      -0.261      0.035  -7.357    2.000
 # usemeth        0.187      0.094   1.986    0.047
 # 
 # 
 # Share
 # Tw
           