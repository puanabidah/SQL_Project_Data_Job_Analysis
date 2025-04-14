/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2.
- Identify the top 5 in-demand skills for data analyst.
- Focus on all job postings.
- Why? Retrive the top 5 skills with the highest demand in the job market, providing insights into the most valuable skills for job seekers.
*/

SELECT 
    skills,
    COUNT(*) AS demand_count
FROM job_postings_fact AS j
INNER JOIN skills_job_dim AS sj
    ON j.job_id = sj.job_id
INNER JOIN skills_dim AS s
    ON sj.skill_id = s.skill_id
WHERE j.job_title_short = 'Data Analyst'
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;


/*
Top 5 in-demand skills for data analysts:
1. SQL 
2. Excel
3. Python
4. Tableau
5. Power BI

These skills are essential for data analysis, data visualization, and data manipulation, making them highly sought after in the job market.

[
  {
    "skills": "sql",
    "demand_count": "92628"
  },
  {
    "skills": "excel",
    "demand_count": "67031"
  },
  {
    "skills": "python",
    "demand_count": "57326"
  },
  {
    "skills": "tableau",
    "demand_count": "46554"
  },
  {
    "skills": "power bi",
    "demand_count": "39468"
  }
]

*/