/*
Question: What are the top skills based on salary?

- Look at the average salary associated with each skill for Data Analyst positions.
- Focus on roles with specified salaries, regardless of location.

Why?
It reveals how different skills impact salary levels for Data Analysts and helps
identify the most financially rewarding skills to acquire or improve.
*/


SELECT
skills,
round(avg(salary_year_avg), 0) AS salary_average

FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' 
AND salary_year_avg IS NOT NULL
AND job_work_from_home = 'True'
GROUP BY skills
ORDER BY salary_average DESC 
LIMIT 25;

/*
Here's a breakdown of the top-paying skills for Data Analysts based on the query results:
- Big data and cloud technologies dominate the highest salaries, with skills like PySpark, Databricks, Airflow, and GCP leading the list.
- Programming and machine learning skills are highly valued, as Python libraries (Pandas, NumPy, Scikit-learn) and AI tools consistently appear among the top-paying skills.
- The highest-paying Data Analyst roles require technical versatility, combining analytics with data engineering, cloud infrastructure, and software development practices.

[
  {
    "skills": "pyspark",
    "salary_average": "208172"
  },
  {
    "skills": "bitbucket",
    "salary_average": "189155"
  },
  {
    "skills": "couchbase",
    "salary_average": "160515"
  },
  {
    "skills": "watson",
    "salary_average": "160515"
  },
  {
    "skills": "datarobot",
    "salary_average": "155486"
  },
  {
    "skills": "gitlab",
    "salary_average": "154500"
  },
  {
    "skills": "swift",
    "salary_average": "153750"
  },
  {
    "skills": "jupyter",
    "salary_average": "152777"
  },
  {
    "skills": "pandas",
    "salary_average": "151821"
  },
  {
    "skills": "elasticsearch",
    "salary_average": "145000"
  },
  {
    "skills": "golang",
    "salary_average": "145000"
  },
  {
    "skills": "numpy",
    "salary_average": "143513"
  },
  {
    "skills": "databricks",
    "salary_average": "141907"
  },
  {
    "skills": "linux",
    "salary_average": "136508"
  },
  {
    "skills": "kubernetes",
    "salary_average": "132500"
  },
  {
    "skills": "atlassian",
    "salary_average": "131162"
  },
  {
    "skills": "twilio",
    "salary_average": "127000"
  },
  {
    "skills": "airflow",
    "salary_average": "126103"
  },
  {
    "skills": "scikit-learn",
    "salary_average": "125781"
  },
  {
    "skills": "jenkins",
    "salary_average": "125436"
  },
  {
    "skills": "notion",
    "salary_average": "125000"
  },
  {
    "skills": "scala",
    "salary_average": "124903"
  },
  {
    "skills": "postgresql",
    "salary_average": "123879"
  },
  {
    "skills": "gcp",
    "salary_average": "122500"
  },
  {
    "skills": "microstrategy",
    "salary_average": "121619"
  }
] /*