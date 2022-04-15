# Deliverable 1: Linear Regression to Predict MPG
#------------------------------------------------

# 3. Use the library() function to load the dplyr package.
library(tidyverse)

# 4.Import and read in the MechaCar_mpg.csv file as a dataframe.
mechacar <- read.csv("../Datasources/MechaCar_mpg.csv")
head(mechacar)

# 5. Perform linear regression using the lm() function.
pre_mpg <- lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, mechacar)

# 6. Using the summary() function, determine the p-value and the r-squared value for the linear regression model.
summary(pre_mpg)

# Visualize the linear regression results
require(reshape2)
mecha = melt(mechacar, id.vars='mpg')
ggplot(mecha) +
  geom_jitter(aes(value,mpg, colour=variable),) + geom_smooth(aes(value,mpg, colour=variable), method=lm, se=FALSE, formula = y ~ x) +
  facet_wrap(~variable, scales="free_x") +
  labs(title="MPG Performance vs Different Design Specifications", x="Design Specifications", y="MPG of MechaCar", color = "Features")

# Only vehicle_length and ground_clearance are significantly associated to changes in mpg
model <- lm(mpg ~ vehicle_length + ground_clearance, mechacar)
summary(model)

# Save all linear regression results into a txt file
sink("Linear_regression.txt")
summary(pre_mpg)
summary(model)
sink()

# The model equation:
equation <- model$coefficients["vehicle_length"]*mechacar$vehicle_length + model$coefficients["ground_clearance"]*mechacar$ground_clearance + model$coefficients["(Intercept)"]

# The figure of the regression
plt_d1 <- ggplot(mechacar, aes(x= vehicle_length, y= mpg, color=ground_clearance))
plt_d1 + geom_point() + 
  geom_smooth(method=lm,se=FALSE,fullrange=TRUE)+
  labs(title="Predict MPG", x="Vehicle Length", y="MPG of MechaCar", color = "Ground Clearance") +
  annotate("text", x=18.5, y=30, label="R-squared: 0.674", color="#32a852", size=5)
  

# Deliverable 2: Create Visualizations for the Trip Analysis
# ----------------------------------------------------------

# 2. Import and read in the Suspension_Coil.csv file as a table
susp_coil <- read.csv("../Datasources/Suspension_Coil.csv")
head(susp_coil)

# 3. Creates a total_summary dataframe
total_summary <- susp_coil %>% summarize(Mean= mean(PSI), Median= median(PSI), Variance= var(PSI), SD= sd(PSI)) %>% mutate_if(is.numeric, round,2)

# Export the result
library(kableExtra)
total_summary$Variance <- cell_spec(total_summary$Variance, bold=TRUE)
kbl(total_summary, escape = F) %>% kable_paper("striped", full_width = F) %>% kable_minimal()

# 4. Creates a lot_summary dataframe using the group_by() and the summarize() functions 
lot_summary <- susp_coil %>% group_by(Manufacturing_Lot) %>% summarize(Mean= mean(PSI), Median= median(PSI), Variance= var(PSI), SD= sd(PSI),.groups = "keep")%>% mutate_if(is.numeric, round,2)

# Export the result
lot_summary$Variance <- cell_spec(lot_summary$Variance, color = ifelse(lot_summary$Variance > 100, "red", "default"), bold = TRUE)
kbl(lot_summary, escape = F) %>% kable_paper("striped", full_width = T) %>% column_spec(1, bold = T) %>% footnote(general = "Variance > 100 is shown in RED") %>% kable_minimal()


# Deliverable 3: T-Tests on Suspension Coils
# ------------------------------------------

# 1. Write an RScript using the t.test() function to determine if the PSI across all manufacturing lots is statistically different from the population mean of 1,500 pounds per square inch.
t.test(susp_coil$PSI, mu=1500)
all_result <- t.test(susp_coil$PSI, mu=1500)

# 2. Write three more RScripts using the t.test() function and its subset() argument to determine if the PSI for each manufacturing lot is statistically different from the population mean of 1,500 pounds per square inch.
# Manufacturing lot 1 and population
lot1 <- susp_coil %>% subset(Manufacturing_Lot == "Lot1", select=c(Manufacturing_Lot ,PSI))
t.test(lot1$PSI, mu=1500)
lot1_result <- t.test(lot1$PSI, mu=1500)

# Manufacturing lot 2 and population
lot2 <- susp_coil %>% subset(Manufacturing_Lot == "Lot2", select=c(Manufacturing_Lot ,PSI))
t.test(lot2$PSI, mu=1500)
lot2_result <- t.test(lot2$PSI, mu=1500)

# Manufacturing lot 3 and population
lot3 <- susp_coil %>% subset(Manufacturing_Lot == "Lot3", select=c(Manufacturing_Lot ,PSI))
t.test(lot3$PSI, mu=1500)
lot3_result <- t.test(lot3$PSI, mu=1500)

# Display all T-test results in one table
library(broom)
table <- map_df(list(all_result,lot1_result, lot2_result, lot3_result), tidy) %>% mutate_if(is.numeric, round,3)
# Set index name
table$Lot <- c("All Three", "Lot1", "Lot2", "Lot3")
table <- table %>% column_to_rownames(., var = "Lot")
# Select and rename columns
table_sel <- table[c("p.value","estimate", "conf.low", "conf.high", "parameter")]
table_sel <- plyr::rename(table_sel,c("p.value" = "P.Value", 'estimate' = 'Estimate Mean', "conf.low" = "Conf.low", "conf.high" = "Conf.high", "parameter"= "Parameter"))
# Export the result to a table
table_sel$P.Value <- cell_spec(table_sel$P.Value, color = ifelse(table_sel$P.Value > 0.05, "red", "default"), bold = TRUE)
kbl(table_sel, escape = F) %>% kable_paper("striped", full_width = T) %>% footnote(general = "P-value > alpha(0.05) is shown in RED") %>% kable_minimal()

# Save all T-tests results into a txt file
sink("T_test_Results.txt")
t.test(susp_coil$PSI, mu=1500)
t.test(lot1$PSI, mu=1500)
t.test(lot2$PSI, mu=1500)
t.test(lot3$PSI, mu=1500)
sink()
