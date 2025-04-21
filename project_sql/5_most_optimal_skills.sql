/*
Question: What are the most optimal skills for data analysts?
- Identify skills in high-demand and associated with high average salaries.
- Concentrate on remote positions with specified salaries.
- Why? Targeting skills that offer job security (high demand) and financial benefits (high salaries) is crucial for job seekers. This analysis helps in making informed decisions about skill development and career paths.
*/

-- Using CTEs
WITH skills_demand AS (
    SELECT
        skills,
        COUNT(sj.job_id) AS demand_count
    FROM job_postings_fact AS j
    INNER JOIN skills_job_dim AS sj
        ON j.job_id = sj.job_id
    INNER JOIN skills_dim AS s
        ON sj.skill_id = s.skill_id
    WHERE j.job_title_short = 'Data Analyst'
         AND job_work_from_home = TRUE
         AND salary_year_avg IS NOT NULL
    GROUP BY skills
),
average_salary AS (
    SELECT 
        skills,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact AS j
    INNER JOIN skills_job_dim AS sj
        ON j.job_id = sj.job_id
    INNER JOIN skills_dim AS s
        ON sj.skill_id = s.skill_id
    WHERE job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY skills
)

SELECT 
    skills_demand.skills,
    demand_count,
    avg_salary
FROM skills_demand
INNER JOIN average_salary
    ON skills_demand.skills = average_salary.skills
WHERE demand_count > 50
    AND avg_salary > 90000
ORDER BY avg_salary DESC, demand_count DESC
LIMIT 5;

-- rewriting this same query more concisely
SELECT
    skills,
    COUNT(sj.job_id) AS demand_count,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM skills_dim AS s
INNER JOIN skills_job_dim AS sj
    ON s.skill_id = sj.skill_id
INNER JOIN job_postings_fact AS j
    ON sj.job_id = j.job_id
WHERE j.job_title_short = 'Data Analyst'
    AND job_work_from_home = TRUE
    AND salary_year_avg IS NOT NULL
GROUP BY skills
HAVING COUNT(sj.job_id) > 50
       AND AVG(salary_year_avg) > 90000
ORDER BY avg_salary DESC, demand_count DESC
LIMIT 5;

/*

Here's the breakdown of the most optimal skills for Data Analyst jobs in 2023:

- Versatile Data Powerhouses (Python & R): Python's broad applicability in data science, machine learning, and beyond, coupled with R's strength in statistical analysis, makes both highly sought after for their ability to extract and interpret data.

- Crucial Data Visualization (Tableau & Power BI): The ability to transform raw data into understandable and actionable insights through tools like Tableau and Power BI is critical for businesses, driving high demand and good salaries for those skilled in these platforms.

- Established Analytical Strength (SAS): While potentially facing newer competition, SAS remains a powerful and widely used tool for advanced analytics in many organizations, ensuring consistent demand and strong earning potential for experienced professionals.

Output:
[
  {
    "skills": "python",
    "demand_count": "236",
    "avg_salary": "101397"
  },
  {
    "skills": "r",
    "demand_count": "148",
    "avg_salary": "100499"
  },
  {
    "skills": "tableau",
    "demand_count": "230",
    "avg_salary": "99288"
  },
  {
    "skills": "sas",
    "demand_count": "126",
    "avg_salary": "98902"
  },
  {
    "skills": "power bi",
    "demand_count": "110",
    "avg_salary": "97431"
  }
]

*/