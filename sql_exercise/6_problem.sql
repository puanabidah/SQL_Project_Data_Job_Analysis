-- display top 5 in-demand skills from data analyst job postings

WITH remote_job_skills AS (
    SELECT 
        skill_id,
        COUNT(*) AS skill_count
    FROM skills_job_dim AS sj
    JOIN job_postings_fact AS j 
        ON sj.job_id = j.job_id
    WHERE job_title_short = 'Data Analyst'
      AND job_work_from_home = TRUE
    GROUP BY skill_id
)

SELECT
    skills,
    skill_count
FROM skills_dim AS s
INNER JOIN remote_job_skills AS r
    ON s.skill_id = r.skill_id
ORDER BY skill_count DESC
LIMIT 5;


