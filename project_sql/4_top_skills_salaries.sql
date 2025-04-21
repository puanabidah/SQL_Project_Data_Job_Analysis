/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions.
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals the most financially rewarding skills to acquire or improve. 
*/

SELECT 
    skills AS skill_name,
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
ORDER BY avg_salary DESC
LIMIT 25;

/*
Here are quick insights from the provided list of the top 25 highest salaries based on skill:

- Data Processing and Management Dominate: Skills like PySpark, Pandas, Jupyter, Elasticsearch, Golang, Numpy, Databricks, Linux, Kubernetes, Airflow, Scala, and PostgreSQL, which are heavily used in data processing, big data management, and backend infrastructure, command high average salaries. This indicates a strong demand for professionals who can handle and analyze large datasets and build scalable systems.

- DevOps and Collaboration Tools are Highly Valued: Skills such as Bitbucket, GitLab, Atlassian, and Jenkins, which facilitate collaboration, version control, and automation in software development and deployment (DevOps), also show significant average salaries. This highlights the importance organizations place on efficient and streamlined development workflows.

- Cloud and Specific Platforms Offer Competitive Pay: Skills related to specific cloud platforms (like GCP) and specialized platforms (like Couchbase, Watson, Datarobot, Swift, Twilio, Notion, and Microstrategy) also appear in the top 25. This suggests that expertise in niche but valuable technologies is well-compensated.

Output:
[
  {
    "skill_name": "pyspark",
    "avg_salary": "208172"
  },
  {
    "skill_name": "bitbucket",
    "avg_salary": "189155"
  },
  {
    "skill_name": "couchbase",
    "avg_salary": "160515"
  },
  {
    "skill_name": "watson",
    "avg_salary": "160515"
  },
  {
    "skill_name": "datarobot",
    "avg_salary": "155486"
  },
  {
    "skill_name": "gitlab",
    "avg_salary": "154500"
  },
  {
    "skill_name": "swift",
    "avg_salary": "153750"
  },
  {
    "skill_name": "jupyter",
    "avg_salary": "152777"
  },
  {
    "skill_name": "pandas",
    "avg_salary": "151821"
  },
  {
    "skill_name": "elasticsearch",
    "avg_salary": "145000"
  },
  {
    "skill_name": "golang",
    "avg_salary": "145000"
  },
  {
    "skill_name": "numpy",
    "avg_salary": "143513"
  },
  {
    "skill_name": "databricks",
    "avg_salary": "141907"
  },
  {
    "skill_name": "linux",
    "avg_salary": "136508"
  },
  {
    "skill_name": "kubernetes",
    "avg_salary": "132500"
  },
  {
    "skill_name": "atlassian",
    "avg_salary": "131162"
  },
  {
    "skill_name": "twilio",
    "avg_salary": "127000"
  },
  {
    "skill_name": "airflow",
    "avg_salary": "126103"
  },
  {
    "skill_name": "scikit-learn",
    "avg_salary": "125781"
  },
  {
    "skill_name": "jenkins",
    "avg_salary": "125436"
  },
  {
    "skill_name": "notion",
    "avg_salary": "125000"
  },
  {
    "skill_name": "scala",
    "avg_salary": "124903"
  },
  {
    "skill_name": "postgresql",
    "avg_salary": "123879"
  },
  {
    "skill_name": "gcp",
    "avg_salary": "122500"
  },
  {
    "skill_name": "microstrategy",
    "avg_salary": "121619"
  }
]

*/