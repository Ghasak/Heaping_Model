
# ##########################################################################
# dev.off(dev.list()["RStudioGD"]) # clean the Graph Area
# rm(list=ls())                    # clean the Workspace (dataset)
# cat("\014")                      # clean the console area
# graphics.off()                   # close graphics windows (For R Script)
# #########################################################################
print(paste0("This is ", date()))
library(tmvtnorm)
# Test for the for statement      
for (i in 1:10){
  #print(i)
  if (i <= 5){
    print(c("yes i is equalt to",i))
  }
  else {
    print(c("No i is equal to",i))
  }
  
}


# Test for while loop 
# i=1
Y=1
i=1
while (Y<=10){
  if ( Y <= 5){
    
    while (i <= 3){
      #print(c("yes Y is equalt to",Y,"printed for",i,"times"))
      print(paste0("yes Y is equal to ",Y," of ",i,"times"))
      i = i+1
    }
    
  }
  else {
    print(paste0("No Y is equal to ",Y))
    
  }
  #print(Y)
  Y=Y+1
}





# Test for the for statement      
for (i in 1:10){
  #print(i)
  if (i <= 5){
    for (j in 1:3){
      print(paste0("yes i is equalt to ",i," and j is ",j)) 
      s = 1
      while (s<2){
        print("here is the value of another while")
        s = s+1
      }
      
      
    }
    
  }
  else {
    print(c("No i is equal to",i))
  }

} 


