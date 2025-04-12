-- get the corresponding skill and skill type for each job postings in quarter 1
-- includes those without any skills, too
-- why? Look at the skills and the type for each job in the first quarter that has a salary > $70000

-- hasil dari union all kita jadiin subquery

SELECT 
    quarter_one_jobs.job_id,
    quarter_one_jobs.job_title_short,
    skills_dim.skills AS skill_name,
    skills_dim.type AS skill_type,
    quarter_one_jobs.salary_year_avg AS salary,
    quarter_one_jobs.job_location,
    quarter_one_jobs.job_via,
    quarter_one_jobs.job_posted_date::DATE
FROM (
    SELECT
        *
    FROM january_jobs
    UNION ALL
    SELECT
        *
    FROM february_jobs
    UNION ALL
    SELECT
        *
    FROM march_jobs
) AS quarter_one_jobs
LEFT JOIN skills_job_dim
    ON quarter_one_jobs.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE quarter_one_jobs.salary_year_avg > 70000 AND
    quarter_one_jobs.job_title_short = 'Data Analyst'
ORDER BY salary DESC;



