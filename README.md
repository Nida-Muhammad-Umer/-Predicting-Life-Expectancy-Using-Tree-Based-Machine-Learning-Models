# Predicting Life Expectancy Using Tree-Based Machine Learning Models

## Project Overview

This project builds and compares multiple tree-based machine learning models to predict life expectancy using global country-level data (2014–2015).

The analysis evaluates:

- Regression Trees (RT)
- Pruned Trees (via cross-validation)
- Bagging
- Random Forests

The goal is to identify the most important predictors of life expectancy and compare predictive performance across ensemble methods.

---

## Objective

- Predict life expectancy using socio-economic and health indicators
- Compare model performance across:
  - Full regression tree
  - Pruned regression tree
  - Bagging
  - Random Forest
- Evaluate predictive accuracy using Mean Squared Error (MSE)
- Identify the most important predictors of life expectancy

---

## Dataset

**File:** `lifeexpetancy.csv`  
**Years Used:**
- 2014 → Training Set
- 2015 → Validation (Test) Set

### Key Variables

- Status (Developed / Developing)
- Adult Mortality
- Infant Deaths
- BMI
- GDP
- Population
- Schooling
- Alcohol
- HIV/AIDS
- Other health and economic indicators

Target variable:
- **Life Expectancy**

---

## Methodology

### Data Split

- Training Data: 2014
- Test Data: 2015
- Target variable removed from predictors in validation set

---

### Regression Tree (RT)

- Built regression tree using training data
- Plotted tree structure
- Recorded:
  - Number of terminal leaves
  - Training deviance

Identified main predictors influencing life expectancy.

---

### Model Evaluation

Computed Mean Squared Error (MSE) for:

- Training set
- Validation (test) set

Compared predictive performance to detect overfitting.

---

### Tree Pruning

- Performed cross-validation
- Selected optimal tree size
- Pruned tree to minimize cross-validation error
- Compared:
  - Full tree test MSE
  - Pruned tree test MSE

---

### Ensemble Methods

#### Bagging

- Used all predictors at each split
- Reduced variance of base tree model

#### Random Forest

- Used m = √p predictors at each split
- Calculated variable importance using `importance()`
- Compared test MSE against:
  - Full tree
  - Pruned tree
  - Bagging

---

## Key Findings

- Regression tree identifies dominant structural splits (e.g., Adult Mortality, GDP, HIV/AIDS, Schooling).
- Pruning improves generalization performance.
- Bagging reduces variance and improves test accuracy over single tree.
- Random Forest provides strongest predictive performance.
- Variable importance analysis highlights the most influential life expectancy determinants.

---

## Strategic Relevance

This project demonstrates real-world predictive modeling capability:

### Policy & Public Health
Identify dominant socio-economic drivers affecting life expectancy.

### Model Selection & Validation
Compare bias-variance tradeoff across tree-based models.

### Predictive Analytics
Demonstrates end-to-end ML workflow:
- Train/test split
- Model building
- Cross-validation
- Pruning
- Ensemble learning
- Feature importance analysis

---

## Evaluation Metric

Mean Squared Error (MSE) used for:

- Training performance
- Validation performance
- Model comparison

---

## Tools & Techniques

- R
- Regression Trees
- Cross-Validation
- Tree Pruning
- Bagging
- Random Forest
- Variable Importance
- Model Evaluation (MSE)

---

## Skills Demonstrated

- Supervised Machine Learning
- Model Comparison & Validation
- Ensemble Methods
- Feature Importance Interpretation
- Bias-Variance Tradeoff Analysis
- Predictive Modeling on Real-World Data

---

## Repository Structure

lifeexpetancy.csv  
analysis.R  
README.md  

---

## Author

Nida Muhammad Umer  
Data Analyst | Machine Learning | Predictive Modeling
