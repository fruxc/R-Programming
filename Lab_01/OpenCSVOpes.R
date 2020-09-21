Students <- read.csv("E:\\R_Practicals\\Lab_01\\Data\\Students.csv", header = T, sep = ",")
max(Students['Marks'])
Students[which.max(Students$Marks),]
Students[Students$Dept == "MCA",]
Students[Students$Dept == "MCA" & Students$Marks > 80,]