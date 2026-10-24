# HR Analytics & Employee Attrition Pipeline

### Project Overview
This project analyzes a dataset of 22,214 employee records to identify workforce trends, turnover rates, and tenure distribution. The analysis was conducted using MySQL for data cleaning and querying, followed by a Power BI dashboard for visualization.

### Tools Used
* **Database:** MySQL
* **Visualization:** Power BI
* **Key SQL Concepts:** Multi-table logic, Subqueries, GROUP BY, Date/Time Functions, CASE statements.

### Key Findings (Based on 12 Analytical Queries)
* **Overall Baseline:** The overall company termination rate is **13.08%** (2,905 terminations).
* **Departmental Turnover:** The Auditing department exhibits the highest turnover at **19.23%**, though this rests on a relatively small sample size of 52 employees. The Legal department offers a sturdier headline with a **16.72%** turnover rate across 311 employees.
* **Remote vs. Headquarters:** Employees stationed at Headquarters have a turnover rate of **13.33%**. Remote employees have a slightly lower rate of **12.31%**.

### Data Quality & Caveats Noted
During the ETL process, a data quality anomaly was spotted: 1,024 employees have future termination dates entered into the system (some as far out as 2041). For the integrity of current turnover metrics, the SQL queries were structured to treat future-dated terminations as active employees (`termdate <= CURDATE()`).

### Power BI Dashboard
![HR Dashboard](dashboard_screenshot.png)
*(Note: Please refer to the .pbix file for interactive cross-filtering).*