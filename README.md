# MechaCar Statistical Analysis

## Overview

### Purpose
This project aims to help Jeremy, a data analysis team member from AutosRUs. The company recently came up with a new prototype, the MechaCar, suffering from production troubles. Therefore, the data analysis team was asked to review the production data and try to help manufacturing team improve the process of MecheCar. 

We would analyze the insight data from 3 perspective, and provide summary statistics for related variables, visualizations for different datasets, and our interpretation of statistical test results. In addition, we will propose extra study design, hypothesis, and analysis workflow in order to make AutosRUs manufacturing process even better.


## Resources
- Data Source: 
[MechaCar MPG dataset](https://github.com/Jarviniazh/Module-15-Challenge-MechaCar-Statistical-Analysis/blob/main/Datasources/MechaCar_mpg.csv), [Suspension Coil dataset](https://github.com/Jarviniazh/Module-15-Challenge-MechaCar-Statistical-Analysis/blob/main/Datasources/Suspension_Coil.csv)
- Software: RStudio 2022.02.1+461

## Linear Regression to Predict MPG
First, we used linear model to predicts the mpg of MechaCar prototypes with multiple design specifications in order to identify ideal vehicle performance.
<p align="center">
 <img src="https://github.com/Jarviniazh/Module-15-Challenge-MechaCar-Statistical-Analysis/blob/main/Resources/Linear_summary1.png?raw=true" alt="Linear_summary_with_5_vars"/>
</p> 

It can be seen that P-value of the F-statistic is 5.35e-11 < 0.05, which is highly significant, and we can reject the null hypothesis (the slope of the linear model is zero). This means that, at least, one of the predictor variables is significantly related to the outcome variable. To see which specification variables are significant, we move to the coefficients table.

Comparing the P-value of each design specifications, only the vehicle length and ground clearance have a low p-value (< 0.05) indicates that we can reject the null hypothesis (the coefficient is equal to zero). 
<p align="center">
 <img src="https://github.com/Jarviniazh/Module-15-Challenge-MechaCar-Statistical-Analysis/blob/main/Resources/All_features_with_mpg.png?raw=true" alt="All_features_with_mpg"/>
</p>

The plots above show the linear relationship between each 5 design specifications. With the visualization, it is more obvious that the vehicle length and ground clearance are significantly associated to changes in MechaCar Prototype mpg while changes in other specifications are not significantly associated with mpg. 

As the other 3 variable is not significant, it is possible to remove them from the model and analyze again.  Here the results report and the final plot:  
<p align="center">
 <img src="https://github.com/Jarviniazh/Module-15-Challenge-MechaCar-Statistical-Analysis/blob/main/Resources/Linear_summary2.png?raw=true" alt="Linear_summary_with_2_vars"/>
</p> 
<p align="center">
 <img src="https://github.com/Jarviniazh/Module-15-Challenge-MechaCar-Statistical-Analysis/blob/main/Resources/Linear_Regression_with2.png?raw=true" alt="Linear_Regression_with2"/>
</p> 

There is no doubt the P-values of two variables are still less than 0.05. With R2 = 0.674, meaning that “67.4% of the variance in the measure of mpg can be predicted by prototype's vehicle length and ground clearance." The linear model can effectively predict mpg of MechaCar prototypes. 

[View all 2 Linear Regression Results in txt](https://github.com/Jarviniazh/Module-15-Challenge-MechaCar-Statistical-Analysis/blob/main/Resources/Linear_regression.txt)

## Summary Statistics on Suspension Coils
Second, using statistical information to determine if the manufacturing process is consistent across production lots. The design specifications for the MechaCar suspension coils dictate that the variance of the suspension coils must not exceed 100 pounds per square inch. 
<p align="center">
 <img src="https://github.com/Jarviniazh/Module-15-Challenge-MechaCar-Statistical-Analysis/blob/main/Resources/Total_summary.png?raw=true" alt="Total_summary"/>
</p> 

The total variance in the summary dataframe above shows a variance of 62.29, which is acceptable based on the requirements. To double check the all manufacturing lots meet the design specification, we then investigate each lot individually. 

<p align="center">
 <img src="https://github.com/Jarviniazh/Module-15-Challenge-MechaCar-Statistical-Analysis/blob/main/Resources/Lot_summary.png?raw=true" alt="Lot_summary"/>
</p> 

Although the overall manufacturing lots have a qualified suspension coils variance, the Lot3 with variance of 170.29 that is way higher than the standard.  The other 2 lots both have an excellent performance, with which variance of the weight capacities of multiple suspension coils lower than 10. 

## T-Tests on Suspension Coils
To determine if all manufacturing lots and each lot individually are statistically different from the population mean of 1,500 pounds per square inch, we applied the T-Test. Then grouped all statistical test results into one table for interpretation friendly. 

- **H0 (Null Hypothesis)**: The sample mean of PSI from all manufacturing lots/each lot is same with the the population mean of 1,500 pounds per square inch
- **H1 (Alternative Hypothesis)**: The sample mean of PSI from all manufacturing lots/each lot is different from the the population mean of 1,500 pounds per square inch
<p align="center">
 <img src="https://github.com/Jarviniazh/Module-15-Challenge-MechaCar-Statistical-Analysis/blob/main/Resources/T_test_summary.png?raw=true" alt="T_test_summary"/>
</p> 

It can be seen that only Manufacturing Lot3 has a low P-Value (0.042) less than alpha (0.05), and we can reject the null hypothesis. In other words, mean of the weight capacities of multiple suspension coils from Lot3 is statistically different from the population mean of 1500. 

To get all detailed T-Test results data:
<br> [All manufacturing lots T-Test results screenshot](https://github.com/Jarviniazh/Module-15-Challenge-MechaCar-Statistical-Analysis/blob/main/Resources/all_lots_ttest.png) 
<br> [Manufacturing Lot1 T-Test results screenshot](https://github.com/Jarviniazh/Module-15-Challenge-MechaCar-Statistical-Analysis/blob/main/Resources/lot1_ttest.png)
<br> [Manufacturing Lot2 T-Test results screenshot](https://github.com/Jarviniazh/Module-15-Challenge-MechaCar-Statistical-Analysis/blob/main/Resources/lot2_ttest.png)
<br> [Manufacturing Lot3 T-Test results screenshot](https://github.com/Jarviniazh/Module-15-Challenge-MechaCar-Statistical-Analysis/blob/main/Resources/lot3_ttest.png)
<br> [View all 4 T-Test Results in txt](https://github.com/Jarviniazh/Module-15-Challenge-MechaCar-Statistical-Analysis/blob/main/Resources/T_test_Results.txt)<br>

## Study Design: MechaCar vs Competition
To understand the potential advantages of MechaCar with its competitors, we plan to design a study of metrics that maximize consumer utility can be performed. Set the total number of vehicle sold as the dependent measurment. 

#### Metrics
- Price
- Safety Ratings
- Fuel Efficiency (miles per gallon(mpg))
- Transmission Types
- Maintenance Cost

#### Hypothesis
- **H0 (Null Hypothesis)**: There is no significant customer perference difference between the MechaCar and its competitors.
- **H1 (Alternative Hypothesis)**: The customer perference of MechaCar differs from its competitors.

#### Statistical test
First we will conduct a multiple linear regression to figure out the significant variables that impact sales of all selected vehicles.

Then the performace of MechaCar in these important categories will be compared to the performace of competitors through the analysis of variance (ANOVA) test. If the Pr(>F) is less than significance level we can reject null hypothesis and say at least one metrics of MechaCar affect the customer purchase decision making. 

#### Data Sources
- MechaCar: Sale price data and sold quantities from sales team, product data from product team.
- Competitors: Sale price and product data from online and sold quantities from official annual report.
