# HR Analytics & Employee Attrition Study

A comprehensive data analysis project examining key factors behind employee turnover using raw HR data, custom SQL queries, and dynamic Power BI reporting.

## 📌 Project Overview
High attrition rates negatively impact organizational productivity and culture. This project analyzes a dataset of 1,400+ employee records to identify major attrition drivers—such as compensation, department trends, overtime, and work-life balance—to assist HR management in developing targeted retention strategies.

## 📊 Key Insights & Metrics Addressed
* **Department Attrition:** Breakdown of turnover rates across R&D, Sales, and Human Resources.
* **Compensation & Role:** Evaluating monthly income levels, salary hikes, and job satisfaction ratings against attrition.
* **Demographics & Experience:** Tracking turnover relative to age groups, years at the company, and distance from home.
* **Workplace Stressors:** Measuring the impact of overtime and business travel frequency on employee retention.

## 🛠️ Tech Stack & File Structure
* **SQL (MySQL / PostgreSQL):** Data cleaning, ETL pipelines, and analytical querying.
* **Power BI:** Data visualization, interactive dashboarding, and KPI tracking.
* **CSV:** Raw data source.

### Repository Files
* `Human Resources.csv` — Primary dataset containing employee records, demographics, and metrics.
* `HR Data Cleaning.sql` — Data preprocessing scripts (handling missing values, formatting, and data transformation).
* `HR Final Quearies.sql` — Core SQL queries aggregating key performance indicators and attrition metrics.
* `HRdashboardfinal.pbix` — Interactive Power BI dashboard file.

## 🚀 How to Replicate
1. Import `Human Resources.csv` into your SQL database.
2. Run `HR Data Cleaning.sql` to clean and format tables.
3. Execute queries in `HR Final Quearies.sql` to pull analytical aggregations.
4. Load the cleaned dataset into Power BI or open `HRdashboardfinal.pbix` to view visual insights.
