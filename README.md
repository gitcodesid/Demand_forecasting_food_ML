
=======
# Food Demand Forecasting using Advanced Analytics & Machine Learning

## 📌 Project Overview
This project builds an automated machine learning pipeline to forecast weekly meal demand for a multi-city food delivery service across various fulfillment centers. By predicting demand patterns, the solution minimizes inventory waste and optimizes supply chain fulfillment metrics. The dataset used in this project can be found on Kaggle: [Food Demand Forecasting Dataset](https://www.kaggle.com/datasets/kannanaikkal/food-demand-forecasting/data).

## 🛠️ Tech Stack & Architecture
* **Language:** Python 3.x
* **Libraries:** Pandas, NumPy, Scikit-Learn (Linear Regression, Decision Tree, Random Forest)
* **Storage:** Git LFS (Large File Storage) for high-volume tabular datasets

## 📊 Data Pipeline & Feature Engineering
To simulate a scalable production environment, data integration happens at the database layer before it enters the Python model pipeline. 
The complete, optimized query is stored here: [View SQL Extraction Script](sql/extract_and_engineer.sql)
\### Key SQL Implementations:
\* \*\*Relational Joins:\*\* Executed a `LEFT JOIN` framework to combine transaction tables with high-volume metadata catalogs (`fulfilment\_center\_info` and `meal\_info`).
\* \*\*Database Feature Engineering:\*\* Utilized programmatic conditional statements (`CASE WHEN`) to calculate absolute pricing discounts, relative discount percentages, and promotional binary flags instantly at scale.
\* \*\*Query Performance Tuning:\*\* Leveraged Common Table Expressions (CTEs) to isolate intermediate data frames, reducing data indexing memory bottlenecks.
* **Data Integration:** Unified three distinct data streams (Transaction history, Center profiles, and Meal metadata).
* **Feature Engineering:** Formulated key operational business drivers including `discount_amount`, `discount_percent`, and promotion flags (`emailer_for_promotion`, `homepage_featured`).
* **Categorical Encoding:** Optimized high-cardinality keys (`center_id`, `meal_id`) using structural preprocessing.

## 📈 Model Performance & Evaluation
Evaluated multiple models using an 80/20 train/test split strategy scored against **RMSE** and **R² Score**:

| Model Candidate | RMSE | R² Score |
| :--- | :--- | :--- |
| **Random Forest Regressor** | **187.16** | **0.7704** |
| Decision Tree Regressor | 236.06 | 0.6347 |
| Linear Regression | 349.65 | 0.1985 |

**Outcome:** The Random Forest Regressor outperformed baseline models, successfully explaining **77%** of variance in unseen test demand.

<img width="1093" height="797" alt="data_structure" src="https://github.com/user-attachments/assets/569b1dc7-bd66-484a-a5a6-dfc6c74c7baa" />

## 📄 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.