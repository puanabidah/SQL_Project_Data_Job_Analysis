SELECT 
    job_id,
    job_title_short AS job_title,
    job_posted_date,
    CASE 
        WHEN EXTRACT(MONTH FROM job_posted_date) IN (1, 2, 3) THEN 'Quarter 1'
        WHEN EXTRACT(MONTH FROM job_posted_date) IN (4, 5, 6) THEN 'Quarter 2'
        WHEN EXTRACT(MONTH FROM job_posted_date) IN (7, 8, 9) THEN 'Quarter 3'
        ELSE 'Quarter 4'
    END AS quarter
FROM job_postings_fact
LIMIT 100;

SELECT 
    COUNT(job_id) AS job_count,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY location_category;


SELECT
    job_title_short,
    MAX(salary_year_avg) AS max_salary,
    MIN(salary_year_avg) AS min_salary
FROM job_postings_fact
GROUP BY job_title_short
ORDER BY max_salary DESC, min_salary DESC;

SELECT
    job_title_short,
    MAX(salary_year_avg) AS max_salary,
    MIN(salary_year_avg) AS min_salary
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY job_title_short;

SELECT
    job_id,
    job_title_short,
    salary_year_avg,
    CASE
        WHEN salary_year_avg >= 500000 THEN 'High Salary'
        WHEN salary_year_avg >= 350000 THEN 'Medium Salary' 
        ELSE 'Low Salary'
    END AS salary_buckets
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 100;

SELECT
    CASE
        WHEN salary_year_avg >= 500000 THEN 'High Salary'
        WHEN salary_year_avg >= 350000 THEN 'Medium Salary' 
        ELSE 'Low Salary'
    END AS salary_buckets,
    COUNT(salary_year_avg) AS total_postings
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
GROUP BY salary_buckets
ORDER BY total_postings DESC;