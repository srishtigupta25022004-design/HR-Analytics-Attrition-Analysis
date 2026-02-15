CREATE DATABASE hr_analytics;
USE hr_analytics;
SELECT COUNT(*) FROM hr_1;
SELECT COUNT(*) FROM hr_2;

SHOW TABLES;
SHOW COLUMNS FROM hr_1 LIKE '%Employee%';
SHOW COLUMNS FROM hr_2 LIKE '%Employee%';
SELECT COUNT(*) AS TotalEmployees
FROM hr_1;
SELECT COUNT(*) AS AttritionCount
FROM hr_1
WHERE Attrition = 'Yes';
SELECT
  ROUND(SUM(Attrition = 'Yes') / COUNT(*) * 100, 2) AS AttritionRate
FROM hr_1;
SELECT COUNT(DISTINCT EmployeeNumber) FROM hr_1;
SELECT COUNT(DISTINCT `Employee ID`) FROM hr_2;
CREATE OR REPLACE VIEW hr_master AS
SELECT
    h1.*,
    h2.MonthlyIncome,
    h2.MonthlyRate,
    h2.NumCompaniesWorked,
    h2.Over18,
    h2.OverTime,
    h2.PercentSalaryHike,
    h2.PerformanceRating,
    h2.RelationshipSatisfaction,
    h2.StandardHours,
    h2.StockOptionLevel,
    h2.TotalWorkingYears,
    h2.TrainingTimesLastYear,
    h2.WorkLifeBalance,
    h2.YearsInCurrentRole,
    h2.YearsWithCurrManager
FROM hr_1 h1
LEFT JOIN hr_2 h2
ON h1.EmployeeNumber = h2.`Employee ID`;
SELECT COUNT(*) FROM hr_master;
SELECT
ROUND(SUM(Attrition = 'Yes') / COUNT(*) * 100, 2) AS AttritionRate
FROM hr_master;
SELECT
ROUND(AVG(HourlyRate), 2) AS AvgHourlyRate
FROM hr_master
WHERE Gender = 'Male'
AND JobRole = 'Research Scientist';
SELECT
JobRole,
ROUND(AVG(WorkLifeBalance), 2) AS AvgWLB
FROM hr_master
GROUP BY JobRole;

SELECT
Department,
ROUND(AVG(TotalWorkingYears), 2) AS AvgWorkingYears
FROM hr_master
GROUP BY Department;

SELECT
JobRole,
ROUND(AVG(WorkLifeBalance), 2) AS AvgWorkLifeBalance
FROM hr_master
GROUP BY JobRole;

SELECT
    YearsInCurrentRole,
    ROUND(SUM(Attrition = 'Yes') / COUNT(*) * 100, 2) AS AttritionRate
FROM hr_master
GROUP BY YearsInCurrentRole
ORDER BY YearsInCurrentRole;

desc hr_master;
CREATE OR REPLACE VIEW kpi_attrition_vs_role_years AS
SELECT
    YearsInCurrentRole,
    ROUND(SUM(Attrition = 'Yes') / COUNT(*) * 100, 2) AS AttritionRate
FROM hr_master
GROUP BY YearsInCurrentRole
ORDER BY YearsInCurrentRole;

CREATE OR REPLACE VIEW kpi_avg_attrition_rate AS
SELECT
    ROUND(SUM(Attrition = 'Yes') / COUNT(*) * 100, 2) AS AvgAttritionRate
FROM hr_master;

CREATE OR REPLACE VIEW kpi_avg_hourly_rate_male_rs AS
SELECT
    ROUND(AVG(HourlyRate), 2) AS AvgHourlyRate
FROM hr_master
WHERE Gender = 'Male'
AND JobRole = 'Research Scientist';

CREATE OR REPLACE VIEW kpi_attrition_vs_income AS
SELECT
    Attrition,
    ROUND(AVG(MonthlyIncome), 2) AS AvgMonthlyIncome
FROM hr_master
GROUP BY Attrition;

CREATE OR REPLACE VIEW kpi_avg_working_years_dept AS
SELECT
    Department,
    ROUND(AVG(TotalWorkingYears), 2) AS AvgWorkingYears
FROM hr_master
GROUP BY Department;

CREATE OR REPLACE VIEW kpi_jobrole_wlb AS
SELECT
    JobRole,
    ROUND(AVG(WorkLifeBalance), 2) AS AvgWorkLifeBalance
FROM hr_master
GROUP BY JobRole;

CREATE OR REPLACE VIEW kpi_attrition_vs_role_years AS
SELECT
    YearsInCurrentRole,
    ROUND(SUM(Attrition = 'Yes') / COUNT(*) * 100, 2) AS AttritionRate
FROM hr_master
GROUP BY YearsInCurrentRole
ORDER BY YearsInCurrentRole;

SHOW FULL TABLES
WHERE Table_type = 'VIEW';

SELECT * FROM kpi_jobrole_wlb;
SELECT * FROM hr_master;

SELECT * FROM kpi_avg_attrition_rate;
SELECT * FROM kpi_avg_hourly_rate_male_rs;
SELECT * FROM kpi_attrition_vs_income;
SELECT * FROM kpi_avg_working_years_dept;
SELECT * FROM kpi_jobrole_wlb;
SELECT * FROM kpi_attrition_vs_role_years;


