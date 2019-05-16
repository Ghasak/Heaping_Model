

for (year in c(2010,2011,2012,2013,2014,2015)){
  
  print(paste("The year is", year))
  
}

print(paste("the year is", 2000)) 

# Here is my first comments 

x <- 5
if(x > 0){
  print("Positive number")
}

# wow here I came with this final issue with my R studio
# I would like to add this for the final issue of the programming

y <- cbind(10,20,30,40,50,60)
for(i in 1:length(y)){
  if(y[i] > 40){
    print("Ok its larger than 40")
  }else{
    print("Its not ok")
  }
}


client <- 'private'
net.price <- 10
if(client=='private'){
  tot.price <- net.price * 1.12      # 12% VAT
  print(cbind("Total price",tot.price))
} else {
  if(client=='public'){
    tot.price <- net.price * 1.06    # 6% VAT
  } else {
    tot.price <- net.price * 1    # 0% VAT
  }
}

x <- cbind(10,20,30,40,50,60)
for(i in 1:length(x)){
    print(cbind("the value of x",x[i]))
  }





