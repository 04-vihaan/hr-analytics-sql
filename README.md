# HR Analytics & Employee Attrition Study

### Overview
Analysis of 22,214 employee records in MySQL examining which departments and groups lose people fastest, along with hiring and exit trends over time.

**Attribution:** Dataset is a public HR dataset used in common SQL tutorials. Q1–Q11 follow the standard question list; Q12 (HQ vs. Remote turnover), Q13 (3-year cohort retention), and the CTE/JOIN rewrite of Q10 are my extensions.

### SQL Methods Used
CTEs, LEFT JOINs, CASE statements, date/time functions, subqueries, and `GROUP BY` aggregations.

### Key Results (As of 2026-10-24)
* **Baseline Turnover:** 13.1% overall (2,911 of 22,214 records).
* **Department Turnover (Q8):** Auditing is highest at 19.2%, but rests on a small sample (10 of 52 employees). Legal is the sturdier headline at 16.7% (52 of 311 employees), followed by Support at 13.8% (132 of 954).
* **HQ vs. Remote (Q12):** Headquarters turnover is 13.4% vs. 12.3% for Remote.
* **Cohort Retention (Q13):** Across 21 hire-year cohorts, 0.9–3.5% of new hires left within 3 years (average 2.5%).

### Data Quality Caveats
* **Synthetic Terminations:** The fact that only 2.5% leave within 3 years but 13% leave overall suggests synthetic or skewed termination dates in the dataset. Additionally, 1,024 records have future `termdate` values (up to 2041). Queries filter with `termdate <= @as_of` to count them as active.
* **Data Cutoff:** The extract contains no hire dates after Dec 2020. Post-2020 headcount shrinkage trends in the data cannot be trusted as real business trends.
* **Birthdate Errors:** 967 birthdates had two-digit years parsed into future dates (causing negative ages). Ages `< 18` were set to `NULL` and bucketed as `Unknown`.

### How to Run
1. Import `Human Resources.csv` into a MySQL schema.
2. Run `HR Data Cleaning.sql` (Note: if your CSV importer retains the UTF-8 BOM, you may need to strip `ï»¿` from the ID column).
3. Run `HR Final Queries.sql`.
*(See the `results` folder for output visual proofs).*