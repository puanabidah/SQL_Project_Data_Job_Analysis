DROP TABLE IF EXISTS jan_jobs,
             feb_jobs,
             mar_jobs; 

CREATE TABLE january_jobs AS
    SELECT 
        *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
        AND EXTRACT(YEAR FROM job_posted_date) = 2023;
CREATE TABLE february_jobs AS
    SELECT 
        *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2
        AND EXTRACT(YEAR FROM job_posted_date) = 2023;
CREATE TABLE march_jobs AS
    SELECT 
        *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3
        AND EXTRACT(YEAR FROM job_posted_date) = 2023;


select * from january_jobs limit 100;
select * from february_jobs limit 100;
select * from march_jobs limit 100;

