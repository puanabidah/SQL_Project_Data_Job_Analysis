SELECT 
'2025-03-28'::DATE,
123::INT,
12.34::REAL,
'2025-03-28 12:34:56'::TIMESTAMP,
'TRUE'::BOOLEAN;

SELECT
    job_title_short as title,
    job_location as location,
    job_posted_date as date_time
FROM job_postings_fact
LIMIT 10;

-- date type casting
SELECT
    job_title_short as title,
    job_location as location,
    job_posted_date::date as date
FROM job_postings_fact
LIMIT 10;

-- timezone type casting
SELECT
    job_title_short as title,
    job_location as location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' as date_time
FROM job_postings_fact
LIMIT 10;

-- extract function
SELECT 
    job_id,
    job_title_short as title,
    job_location as location,
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
    job_posted_date as date_time
FROM job_postings_fact
LIMIT 10;

-- count and extract function
SELECT 
    COUNT(job_id) AS job_count,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY month
ORDER BY job_count DESC
LIMIT 13;

SELECT * FROM company_dim
LIMIT 10;

-- problem 1
SELECT 
    job_schedule_type,
    AVG(salary_year_avg) AS avg_salary_year,
    AVG(salary_hour_avg) AS avg_salary_hour
FROM job_postings_fact
WHERE job_posted_date >= '2023-06-01'
GROUP BY job_schedule_type
LIMIT 100;

-- problem 2
SELECT 
    COUNT(job_id) AS job_count,
    EXTRACT(MONTH FROM (job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York')) AS month
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM (job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York')) = 2023
GROUP BY month
ORDER BY month;

-- Q2 (Second Quarter): April, May, and June
SELECT
    job_title_short AS title,
    company_dim.name AS company,
    job_health_insurance AS health_insurance
FROM job_postings_fact
JOIN company_dim
ON job_postings_fact.company_id = company_dim.company_id
WHERE EXTRACT(MONTH FROM job_posted_date) 
    IN (4, 5, 6)
    AND EXTRACT(YEAR FROM job_posted_date) = 2023
LIMIT 100;
