ID <- 1:10
Name <- c("Hammad", "Maulika", "Nishita", "Riya", "Diksha", "Preeti", "Purvesh", "Siddhesh", "Frank", "Avinash")  
Marks <- c(98, 99, 98, 96, 92, 93, 99, 95, 96, 98)  
Dept <- c("MCA", "COMP", "MCA", "MCA", "EXTC", "MCA", "EXTC", "COMP", "IT", "MCA")
Students<-data.frame(ID, Name, Marks, Dept)
Add <- data.frame(11, "Mantasha", 86, "IT")
names(Add) <- c("ID", "Name", "Marks", "Dept")
Students<-rbind(Students, Add)
Students
write.csv(Students,"E:\\R_Practicals\\Lab_01\\Data\\Students.csv", row.names = FALSE)
