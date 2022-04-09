# Deliverable 1: Linear Regression to Predict MPG
#--------------------------------------------------------

# 3. Use the library() function to load the dplyr package.
library(dplyr)

# 4.Import and read in the MechaCar_mpg.csv file as a dataframe.
mechacar <- read.csv("Datasources/MechaCar_mpg.csv")
head(mechacar)

# 5. Perform linear regression using the lm() function.
pre_mpg <- lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, mechacar)

# 6. Using the summary() function, determine the p-value and the r-squared value for the linear regression model.
summary(pre_mpg)

# Only vehicle_length and ground_clearance are significantly associated to changes in mpg
model <- lm(mpg ~ vehicle_length + ground_clearance, mechacar)
summary(model)

# The model equation:
equation <- model$coefficients["vehicle_length"]*mechacar$vehicle_length + model$coefficients["ground_clearance"]*mechacar$ground_clearance + model$coefficients["(Intercept)"]

# The figure of the regression
plt_d1 <- ggplot(mechacar)
plt_d1 + geom_point(aes(x= vehicle_length, y= mpg, color="Vehicle Length")) + 
  geom_smooth(method=lm,se=FALSE,fullrange=TRUE, aes(x= vehicle_length, y= mpg, color="Vehicle Length"))+
  geom_point(aes(x= ground_clearance, y= mpg, color="Ground Clearance")) + 
  geom_smooth(method=lm,se=FALSE,fullrange=TRUE, aes(x= ground_clearance, y= mpg, color="Ground Clearance"))+ 
  labs(title="Predict MPG", x="Design Specifications", y="MPG of MechaCar", color = "Legend Title")
  

# Deliverable 2: Create Visualizations for the Trip Analysis
# ------------------------------------------------------------------------------------------------------

# 2. Import and read in the Suspension_Coil.csv file as a table
susp_coil <- read.csv("Datasources/Suspension_Coil.csv")
head(susp_coil)

# 3. Creates a total_summary dataframe
total_summary <- susp_coil %>% summarize(Mean= mean(PSI), Median= median(PSI), Variance= var(PSI), SD= sd(PSI))

# 4. Creates a lot_summary dataframe using the group_by() and the summarize() functions 
lot_summary <- susp_coil %>% group_by(Manufacturing_Lot) %>% summarize(Mean= mean(PSI), Median= median(PSI), Variance= var(PSI), SD= sd(PSI),.groups = "keep")






