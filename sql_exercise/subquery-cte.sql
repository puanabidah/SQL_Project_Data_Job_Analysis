SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs

WITH january_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)
SELECT *
FROM january_jobs
LIMIT 100; 


SELECT
    company_id,
    name AS company_name
FROM company_dim
WHERE company_id IN (
    SELECT 
        company_id
    FROM job_postings_fact
    WHERE job_no_degree_mention = TRUE
)

WITH comp AS (
    SELECT 
        company_id,
        name AS company_name
    FROM company_dim
)


WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS job_count
    FROM job_postings_fact
    GROUP BY company_id
)

SELECT 
    name AS company_name,
    job_count
FROM company_dim
LEFT JOIN company_job_count
ON company_dim.company_id = company_job_count.company_id
ORDER BY job_count DESC
LIMIT 100;

SELECT *
FROM skills_dim;

SELECT *
FROM skills_job_dim
WHERE job_id IS NULL;

SELECT *
FROM job_postings_fact
where job_title = 'Work From Home Real Jobs – Data Scientist In Victorville – Wells Fargo'
limit 10;

SELECT *
FROM company_dim
limit 10;

WITH skill_detail AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM skills_job_dim
    GROUP BY skill_id
) 
SELECT 
    skill_detail.skill_id,
    skills_dim.skills AS skill_name,
    skill_count
FROM skill_detail
LEFT JOIN skills_dim
ON skill_detail.skill_id = skills_dim.skill_id
ORDER BY skill_count DESC
LIMIT 5


SELECT 
    skill_detail.skill_id,
    skills_dim.skills AS skill_name,
    skill_count
FROM (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM skills_job_dim
    GROUP BY skill_id
) AS skill_detail
LEFT JOIN skills_dim
ON skill_detail.skill_id = skills_dim.skill_id
ORDER BY skill_count DESC
LIMIT 5;


WITH num_of_jobs AS (
    SELECT
        company_id,
        COUNT(*) AS job_count
    FROM job_postings_fact
    GROUP BY company_id
)
SELECT
    company_dim.company_id,
    company_dim.name AS company_name,
    num_of_jobs.job_count,
    CASE
        WHEN num_of_jobs.job_count < 10 THEN 'Small'
        WHEN num_of_jobs.job_count BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Large'
    END AS job_count_category
FROM num_of_jobs
LEFT JOIN company_dim
ON num_of_jobs.company_id = company_dim.company_id;


-- Find the number of remote job postings per skill 
-- Display the top 5 skills by demand in remote jobs
-- include skill_id, name, and count of postings requiring the skill

WITH job_counts AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_remote_job_count
    FROM skills_job_dim AS skills_to_job
    JOIN job_postings_fact AS job_posting
    ON skills_to_job.job_id = job_posting.job_id
    WHERE job_posting.job_work_from_home = TRUE AND
          job_posting.job_title_short = 'Data Analyst'
    GROUP BY skill_id
)
SELECT
    skills_dim.skill_id,
    skills_dim.skills AS skill_name,
    job_counts.skill_remote_job_count
FROM skills_dim
JOIN job_counts
ON skills_dim.skill_id = job_counts.skill_id
ORDER BY job_counts.skill_remote_job_count DESC
LIMIT 5;