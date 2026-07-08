--What are the top-paying jobs for my role? 
--Identify the top 10 highest-paying Data Analyst roles that are available remotely.
--Focus on job postings with specified salaries (remove NULL salaries).
--Highlight the top-paying opportunities for Data Analysts, offering insights into employment opportunities and compensation.-- 


SELECT
jpf.job_id,
jpf.job_title,
cd.name,
jpf.job_location,
jpf.job_schedule_type,
jpf.salary_year_avg,
jpf.job_posted_date



 FROM job_postings_fact JPF
LEFT JOIN company_dim CD ON JPF.company_id = cd.company_id
 WHERE salary_year_avg IS NOT NULL AND job_title_short= 'Data Analyst' AND job_location= 'Anywhere'
 ORDER BY salary_year_avg DESC
 LIMIT 10;