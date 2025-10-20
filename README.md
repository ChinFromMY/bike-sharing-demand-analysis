# Bike Sharing Demand Analysis

This project explores how environmental and seasonal factors affect daily bike rental demand using the **UCI Bike Sharing Dataset**.  
It applies multiple linear regression, diagnostic analysis, and model improvement techniques to predict and interpret bike rental patterns.

## Project Overview
**Objective:** Build a statistical model to predict daily bike rentals based on weather and seasonal conditions.  
**Dataset:** [UCI Bike Sharing Dataset](https://archive.ics.uci.edu/dataset/275/bike+sharing+dataset)  
**Tools Used:** R / lm() 

## Key Steps

1. **Exploratory Data Analysis**
   - Scatterplot matrix and correlation analysis
   - Detection of multicollinearity (e.g., temp vs. atemp correlation = 0.99)

2. **Model Building**
   - Built multiple regression model with 5 categorical and 3 continuous predictors
   - Interpreted regression coefficients and statistical significance

3. **Model Diagnostics**
   - Checked assumptions: linearity, normality, and homoscedasticity
   - Visualized residuals using diagnostic plots

4. **Model Improvement**
   - Added interaction term (`season * atemp`)
   - Applied square root transformation on response variable to improve fit
   - Compared models using Adjusted R² and AIC
  

## Results

| Model Version | Adjusted R² | Notes |
|----------------|-------------|-------|
| Baseline Model | 0.82 | Basic multiple regression |
| With Interaction | 0.86 | Added `season * atemp` |
| Transformed Model | 0.86 (best) | Improved fit and interpretability |

**Key Insights:**
- Bike rentals increase in warmer, clearer weather.
- High humidity and windspeed reduce rentals.
- Very high apparent temperatures in summer lead to fewer rentals due to discomfort.
