

USE new_schema;


-- 1. What is the gender breakdown of employees in the company?

SELECT gender ,count(*) AS count
FROM human_resource
GROUP BY gender;

-- 2. What is the race/ethnicity breakdown of employees in the company?

SELECT race, count(*) AS count
FROM human_resource
GROUP BY race
ORDER BY count(*) DESC;

-- 3. What is the age distribution of employees in the company?

SELECT 
min(AGE)AS youngest,
max(AGE) AS oldest
FROM human_resource;

SELECT 
  CASE 
    WHEN age >= 18 AND age <= 24 THEN '18-24'
    WHEN age >= 25 AND age <= 34 THEN '25-34'
    WHEN age >= 35 AND age <= 44 THEN '35-44'
    WHEN age >= 45 AND age <= 54 THEN '45-54'
    WHEN age >= 55 AND age <= 64 THEN '55-64'
    WHEN age >= 65 THEN '65+'
    ELSE 'Unknown'
  END AS age_group,gender,
  COUNT(*) AS count
FROM 
  human_resource
GROUP BY age_group, gender
ORDER BY age_group, gender;

-- 4. How many employees work at headquarters versus remote locations?

SELECT location, count(*)  AS count
FROM human_resource
GROUP BY location;

-- 5. What is the average length of employment for employees who have been terminated?

SELECT
    ROUND(AVG(DATEDIFF(termdate, hire_date)) / 365, 1) AS avg_lengh_employment
FROM human_resource
WHERE termdate <= CURDATE()
  AND termdate <> '0000-00-00';

-- 6. How does the gender distribution vary across departments and job titles?

SELECT department,gender, count(*) AS COUNT
FROM human_resource
GROUP BY department,gender
ORDER BY department;

-- 7. What is the distribution of job titles across the company?

SELECT jobtitle, count(*) AS COUNT
FROM human_resource
GROUP BY jobtitle
ORDER BY jobtitle DESC;


-- 8. Which department has the highest turnover/termination rate?

SELECT
    department,
    total_count,
    terminated_count,
    terminated_count / total_count AS termination_rate
FROM (
    SELECT
        department,
        COUNT(*) AS total_count,
        SUM(
            CASE
                WHEN termdate <= CURDATE()
                 AND termdate <> '0000-00-00'
                THEN 1
                ELSE 0
            END
        ) AS terminated_count
    FROM human_resource
    GROUP BY department
) AS subquery
ORDER BY termination_rate DESC;



-- 9. wHAT IS THE DISTRIBUTION Of EMPLOYEES BY STATE?

SELECT location_state, count(*)AS count
FROM human_resource
GROUP BY location_state
ORDER BY count DESC;

-- 10. How has the company's employee count changed over time based on hire and termination dates?

-- 10. How has the company's employee count changed over time based on hire and termination dates?
WITH hires AS (
    SELECT YEAR(hire_date) yr, COUNT(*) hires 
    FROM human_resource 
    GROUP BY yr
),
terms AS (
    SELECT YEAR(termdate) yr, COUNT(*) terminations 
    FROM human_resource          
    WHERE termdate <= CURDATE() AND termdate <> '0000-00-00' 
    GROUP BY yr
),
years AS (
    SELECT yr FROM hires UNION SELECT yr FROM terms
)
SELECT y.yr AS year, 
       COALESCE(h.hires,0) hires, 
       COALESCE(t.terminations,0) terminations,       
       COALESCE(h.hires,0) - COALESCE(t.terminations,0) AS net_change
FROM years y 
LEFT JOIN hires h ON h.yr = y.yr 
LEFT JOIN terms t ON t.yr = y.yr
ORDER BY y.yr;

      
-- 11. What is the tenure distribution for each department?

SELECT
    department,
    ROUND(AVG(DATEDIFF(termdate, hire_date) / 365), 1) AS avg_tenure
FROM human_resource
WHERE termdate <= CURDATE()
  AND termdate <> '0000-00-00'
GROUP BY department;




-- 12. What is the termination rate difference between Headquarters and Remote locations?
SELECT location,
       count(*) AS total_count,
       SUM(CASE WHEN termdate <= CURDATE() AND termdate <> '0000-00-00' THEN 1 ELSE 0 END) AS terminated_count,
       SUM(CASE WHEN termdate <= CURDATE() AND termdate <> '0000-00-00' THEN 1 ELSE 0 END) / count(*) AS termination_rate
FROM human_resource
GROUP BY location;


-- 13. What is the termination rate by tenure band?
SELECT
    CASE
        WHEN TIMESTAMPDIFF(YEAR, hire_date, IF(termdate <= CURDATE() AND termdate <> '0000-00-00', termdate, CURDATE())) <= 1 THEN '0-1 yr'
        WHEN TIMESTAMPDIFF(YEAR, hire_date, IF(termdate <= CURDATE() AND termdate <> '0000-00-00', termdate, CURDATE())) <= 3 THEN '1-3 yrs'
        WHEN TIMESTAMPDIFF(YEAR, hire_date, IF(termdate <= CURDATE() AND termdate <> '0000-00-00', termdate, CURDATE())) <= 5 THEN '3-5 yrs'
        ELSE '5+ yrs'
    END AS tenure_band,
    COUNT(*) AS total_count,
    SUM(CASE WHEN termdate <= CURDATE() AND termdate <> '0000-00-00' THEN 1 ELSE 0 END) AS terminated_count,
    ROUND(SUM(CASE WHEN termdate <= CURDATE() AND termdate <> '0000-00-00' THEN 1 ELSE 0 END) / COUNT(*) * 100, 1) AS termination_rate
FROM human_resource
GROUP BY tenure_band
ORDER BY tenure_band;

