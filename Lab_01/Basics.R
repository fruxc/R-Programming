d<-1:9
m<-matrix(d,nrow=3,ncol=3,byrow = TRUE)
m
m[c(1,2),c(1,2)]
m<-cbind(m,10:12,13:15,16:18)
m<-rbind(m,19:24,25:30,31:36)
m
dim(m)

x1<-list(3.3, "R Studio", m)
x1
df1<-data.frame("ID"=2, "Age"=22, "Name"="ABC")
df1<-cbind(df1, State=c("MP"))
df1
str(df1)
df1$Name