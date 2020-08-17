Patients <- data.frame("ID" = 1:100, "Age" = c(sample(10:80, 100, replace=TRUE)), "Disease" = c(sample(c("Diabetes", "Heart Disease"), 100, replace=TRUE)))
Patients

tapply(Patients$ID, Patients$Disease, mean)
