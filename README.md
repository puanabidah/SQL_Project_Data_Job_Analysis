# 📊 Introduction SQL Project: Data Job Analysis

This project is focused on exploring and analyzing job posting data using **SQL**.  
The analysis includes top-paying jobs, in-demand skills, and where high demand skills meet high salary — especially for data-related roles like **Data Analyst**.

🔍 For the SQL queries, you can check [here](/project_sql/).

# 📝 Background

To navigate the data analyst job market more efficiently, this project aims to deliver significant information on top-paying and in-demand skills, ultimately streamlining the process for others to find optimal jobs.

The dataset itself came from this [SQL Course](https://www.lukebarousse.com/sql), which packed with insights on job titles, salaries, location, and essential skills.

# ❓Questions to Answer

1. What are the top-paying jobs for Data Analyst role?
2. What are the skills required for these top_paying roles?
3. What are the most in-demand skills for Data Analyst role?
4. What are the top skills based on salary for Data Analyst role?
5. What are the most optimal skills to learn?
   - Optimal: High Demand AND High Paying

# 🛠️ Tools I used

For my deep dive into the analysis, I used several tools to support that:

- SQL: The backbone of my analysis, allowing me to query the database and the data.
- PostgreSQL: my primary database system for managing relational data, leveraging SQL for querying and manipulating data.
- Visual Studio Code: my go-to code editor, which I used with SQL and PostgreSQL extensions.
- Git & GitHub: Git is essential for version control while GitHub used for sharing all of my codes along with some documentation.

# The Analysis

Each query of this project aimed to investigate some specific aspect of the Data Analyst job market. Here's how I approached that:

## 1. Top-Paying Data Analyst Jobs

This query highlights the top 10 highest-paying Data Analyst jobs that are available remotely and focuses on specified salaries.

```sql
SELECT
    job_id,
    job_title,
    name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM job_postings_fact as jp
LEFT JOIN company_dim as cd
    ON jp.company_id = cd.company_id
WHERE job_title_short = 'Data Analyst' AND
      job_location = 'Anywhere' AND
      salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```

Here's the breakdown from the list of top 10 highest-paying remote data analyst roles in 2023:

- **Exceptional Earning Potential at the Very Top**: The highest-paying role, "Data Analyst" at Mantys with a staggering $650,000 annual salary, indicates that highly specialized or senior-level remote data analyst positions can command exceptionally high compensation, potentially far exceeding typical data analyst salary ranges.
- **Leadership and Specialized Roles Drive High Salaries**: Many of the top roles are leadership positions (Director, Associate Director, Principal Data Analyst), suggesting that experience and the ability to lead data-driven strategies are highly valued. Additionally, specialization in areas like marketing (Pinterest) and AV performance (Motional) can also lead to premium pay.
- **Remote Work is Viable at All Levels**: The presence of fully remote roles across various seniority levels (from "Data Analyst" at Mantys to "Principal Data Analyst" at multiple companies) demonstrates that high-paying data analyst positions are increasingly available with the flexibility of remote work arrangements. Even hybrid roles on this list still offer a significant degree of remote work.

## 2. Skills for Top Paying Jobs

To understand what skills are required for top-paying jobs, I combined the job posting data with skills data, provides information on the companies and the specific skills they need, correlated with the highest average salaries.

```sql
WITH top_paying_jobs AS(
    SELECT
        job_id,
        job_title,
        name AS company_name,
        salary_year_avg
    FROM job_postings_fact AS jp
    LEFT JOIN company_dim AS cd
        ON jp.company_id = cd.company_id
    WHERE job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT
    tpj.*,
    skills AS skills_required
FROM top_paying_jobs AS tpj
INNER JOIN skills_job_dim AS sj
    ON tpj.job_id = sj.job_id
INNER JOIN skills_dim AS sd
    ON sj.skill_id = sd.skill_id
ORDER BY salary_year_avg DESC;
```

Here's the breakdown of skills for the top 10 high-paying Data Analyst jobs in 2023:

- SQL got the most mentions (8 times).
- Python and Tableau followed closely, with 7 and 6 mentions respectively.
- Othe skills like R, Snowflake, Pandas, and Excel show varying degree of demand.
- This indicates that SQL and Python are the most sought-after skills in high-paying data analyst roles, while Tableau is also a strong contender.

## 3. In-Demand Skills for Data Analyst Role

This query focuses on the top 5 most in-demand skills for Data Analyst positions that are remote (work from home), regardless of salary.

```sql
SELECT
    skills,
    COUNT(*) AS demand_count
FROM job_postings_fact AS j
INNER JOIN skills_job_dim AS sj
    ON j.job_id = sj.job_id
INNER JOIN skills_dim AS s
    ON sj.skill_id = s.skill_id
WHERE j.job_title_short = 'Data Analyst'
      AND job_work_from_home = TRUE
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;
```

Here's the breakdown of the most in-demand skills for Data Analyst jobs in 2023:

- SQL and Excel, representing data querying and fundamental data manipulation, remain the most sought-after skills. This highlights that a strong base in accessing and organizing data is crucial for any Data Analyst role, even with the rise of more advanced tools.
- Python's strong demand indicates a significant need for Data Analysts who can perform more complex statistical analysis, build predictive models, and automate tasks. This signals a trend towards more sophisticated analytical capabilities within the data analysis field.
- The high demand for both Tableau and Power BI underscores the critical importance of effectively communicating data insights through compelling visuals. Being able to translate complex data into understandable and actionable dashboards is a key requirement for Data Analysts.

You can see the results of this query in the table below:

| skills   | demand_count |
| -------- | ------------ |
| sql      | 7291         |
| excel    | 4611         |
| python   | 4330         |
| tableau  | 3745         |
| power bi | 2609         |

_Table 1: Top 5 In-Demand Skills for Data Analyst Role_

# 4. Top Skills Based on Salary for Data Analyst Role

This query identifies the top 25 skills with the highest average salaries for remote Data Analyst positions.

```sql
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
```

Here's the breakdown of the top skills based on salary for Data Analyst jobs in 2023:

- **Data Processing and Management Dominate:** Skills like PySpark, Pandas, Jupyter, Elasticsearch, Golang, Numpy, Databricks, Linux, Kubernetes, Airflow, Scala, and PostgreSQL, which are heavily used in data processing, big data management, and backend infrastructure, command high average salaries. This indicates a strong demand for professionals who can handle and analyze large datasets and build scalable systems.

- **DevOps and Collaboration Tools are Highly Valued:** Skills such as Bitbucket, GitLab, Atlassian, and Jenkins, which facilitate collaboration, version control, and automation in software development and deployment (DevOps), also show significant average salaries. This highlights the importance organizations place on efficient and streamlined development workflows.

- **Cloud and Specific Platforms Offer Competitive Pay:** Skills related to specific cloud platforms (like GCP) and specialized platforms (like Couchbase, Watson, Datarobot, Swift, Twilio, Notion, and Microstrategy) also appear in the top 25. This suggests that expertise in niche but valuable technologies is well-compensated.

You can see the results of this query in the table below:

| skill_name    | avg_salary |
| ------------- | ---------- |
| pyspark       | 208172     |
| bitbucket     | 189155     |
| couchbase     | 160515     |
| watson        | 160515     |
| datarobot     | 155486     |
| gitlab        | 154500     |
| swift         | 153750     |
| jupyter       | 152777     |
| pandas        | 151821     |
| elasticsearch | 145000     |
| golang        | 145000     |
| numpy         | 143513     |
| databricks    | 141907     |
| linux         | 136508     |
| kubernetes    | 132500     |
| atlassian     | 131162     |
| twilio        | 127000     |
| airflow       | 126103     |
| scikit-learn  | 125781     |
| jenkins       | 125436     |
| notion        | 125000     |
| scala         | 124903     |
| postgresql    | 123879     |
| gcp           | 122500     |
| microstrategy | 121619     |

_Table 2: Top 25 Skills Based on Salary for Data Analyst Role_

# 5. Optimal Skills for Data Analyst Role

This query identifies the top 5 skills that are both in high demand (appears in more than 50 job postings) and associated with high average salaries for Remote Data Analyst positions.

```sql
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
```

Here's the breakdown of the most optimal skills for Data Analyst jobs in 2023:

- **Versatile Data Powerhouses (Python & R)**: Python's broad applicability in data science, machine learning, and beyond, coupled with R's strength in statistical analysis, makes both highly sought after for their ability to extract and interpret data.
- **Crucial Data Visualization (Tableau & Power BI)**: The ability to transform raw data into understandable and actionable insights through tools like Tableau and Power BI is critical for businesses, driving high demand and good salaries for those skilled in these platforms.
- **Established Analytical Strength (SAS)**: While potentially facing newer competition, SAS remains a powerful and widely used tool for advanced analytics in many organizations, ensuring consistent demand and strong earning potential for experienced professionals.

You can see the results of this query in the table below:

| skills   | demand_count | avg_salary |
| -------- | ------------ | ---------- |
| python   | 236          | 101397     |
| r        | 148          | 100499     |
| tableau  | 230          | 99288      |
| sas      | 126          | 98902      |
| power bi | 110          | 97431      |

_Table 3: Top 5 Optimal Skills for Data Analyst Role_

# What I Learned

This journey has been incredibly enriching, and here are some key takeaways:

- **📖 Mastering SQL Fundamentals and Beyond:** I thoroughly enjoyed diving into SQL, progressing from foundational concepts like SELECT, FROM, and WHERE clauses to more advanced techniques such as JOIN operations, Aggregation functions, GROUP BY clauses, subqueries, and Common Table Expressions (CTEs). It was a blast!
- **🔎 Sharpening Analytical Skills:** I've also developed my analytical abilities by interpreting query results. This involved breaking down the data to extract meaningful insights and formulate well-supported answers to the questions at hand.
- **👩‍🏫 Crafting Clear and Presentable Documentation:** I've learned the importance of creating comprehensive and easily understandable documentation. My aim is to ensure that anyone reviewing my work can readily grasp the process and the resulting insights.

# Conclusions

### 💡Insights

1. **Top-Paying Data Analyst Jobs**: The highest paying for data analyst job that allow remote work offer have a wide ranges of salay, and the highest is at $650K.
2. **Skills for Top-Paying Jobs**: High-paying data analyst job require advance proficiency in SQL, suggesting that SQL is a critical skill for high-paying data analyst roles.
3. **In-Demand Skills**: SQL and Excel are the most in-demand skills for data analyst roles, indicating that these foundational skills are essential for success in the field.
4. **Top Skills Based on Salary**: Skills in big data processing with tools like PySpark command the highest average salaries, alongside experience in version control using Bitbucket and high-performance NoSQL databases like Couchbase.
5. **Most Optimal Skills**: The most optimal skills to learn for data analyst roles, which have a high demand (more than 50 job postings) and average salaries above $90K, include as SQL, Tableau, Python, Power BI, and SAS.

### ✨ Closing Throughts

My learning journey with SQL has been incredibly enlightening, equipping me with a wealth of valuable insights. From grasping the fundamentals to diving into advanced techniques, I’ve gained a deep understanding of how to analyze data effectively. More importantly, I’ve learned how to transform raw data into actionable, meaningful insights that tell a story. The discoveries from my analyses have opened my eyes to the critical skills that are not only essential but also highly sought-after in the field of data analysis—particularly those that lead to the most lucrative opportunities. This transformative experience underscores the valuable skills I've acquired and can guide others seeking to navigate the data analysis job market.
