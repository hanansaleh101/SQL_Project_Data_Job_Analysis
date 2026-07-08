# Introduction

📊 Dive into the data analyst job market! This project explores the highest-paying data analyst positions, the most in-demand skills, and the relationship between salary and technical skills using SQL. By analyzing real-world job posting data, the project uncovers insights that help identify the most valuable skills to learn and the best opportunities within data analytics.

🔎 SQL queries used throughout this project can be found in the [project_sql](project_sql/) folder.

---

# Background

With the rapid growth of data careers, understanding which skills employers value most has become increasingly important. This project was created to analyze the 2023 data analyst job market, helping answer questions about salary trends, skill demand, and the technologies that provide the greatest career opportunities. Through SQL analysis, the project transforms raw job posting data into actionable insights for aspiring and current data analysts.

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

---

# Tools I Used

- **SQL** – Queried and analyzed the job posting database.
- **PostgreSQL** – Managed and stored the relational database.
- **Visual Studio Code** – Wrote and executed SQL queries.
- **Git & GitHub** – Version control and project documentation.

---

# The Analysis

Each SQL query was designed to investigate a different aspect of the data analyst job market. Together, these analyses provide a comprehensive view of salary trends, employer demand, and the most valuable technical skills.

## 1. Top-Paying Data Analyst Jobs

To identify the highest-paying opportunities, I filtered data analyst positions by average annual salary and location, focusing on remote roles. This analysis highlights the companies and positions offering the strongest compensation.

```sql 
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
 ```
 ### Insights

Here's the breakdown of the top-paying data analyst jobs in 2023:

- **Wide Salary Range:** The top 10 highest-paying remote data analyst roles offer salaries ranging from **$184,000 to $650,000**, highlighting the significant earning potential within the field.

- **Diverse Employers:** Companies such as **Meta, AT&T, SmartAsset, Pinterest,** and **UCLA Health** appear among the highest-paying employers, demonstrating that lucrative data analyst opportunities exist across multiple industries.

- **Variety of Senior Roles:** While traditional **Data Analyst** positions are represented, many of the highest-paying opportunities are **Principal**, **Director**, and **Associate Director** roles, showing that higher compensation is closely tied to leadership and specialized expertise.



## 2. Skills Required for Top-Paying Jobs

To understand what employers value in high-paying roles, I joined job postings with their required skills. This analysis reveals the technical skills most commonly associated with top-paying data analyst positions.
```sql 
WITH top_paying_jobs AS
(SELECT
jpf.job_id,
jpf.job_title,
cd.name,
jpf.salary_year_avg

FROM job_postings_fact JPF
LEFT JOIN company_dim CD ON JPF.company_id = cd.company_id

WHERE salary_year_avg IS NOT NULL AND job_title_short= 'Data Analyst' AND job_location= 'Anywhere'

ORDER BY salary_year_avg DESC
 LIMIT 10)

SELECT
top_paying_jobs.*,
skills_dim.skills

FROM top_paying_jobs
INNER JOIN
skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN 
skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC;
```

### Insights

Here's the breakdown of the skills required for the top-paying data analyst jobs in 2023:

- **SQL is Essential:** **SQL** appears in every one of the top-paying roles, making it the most consistently required skill for high-paying data analyst positions.

- **Programming and Visualization Go Hand in Hand:** **Python** is requested in the majority of these roles, while **Tableau** is the most common visualization tool, showing employers value both data analysis and the ability to communicate insights.

- **Cloud and Modern Data Tools Stand Out:** High-paying positions frequently require platforms such as **AWS**, **Azure**, and **Snowflake**, along with technologies like **Databricks** and **PySpark**, highlighting the growing importance of cloud-based data engineering skills.

![Top 10 Highest-Paying Remote Data Analyst Jobs](assets/Top%2010%20Highest-Paying%20Remote%20Data%20Analyst%20Jobs%20(2023).png)

## 3. Most In-Demand Skills for Data Analysts

This query examined job postings to identify the skills requested most frequently by employers. The results highlight the technologies and tools that are currently in the highest demand across the data analyst job market.
```sql
SELECT
skills,
count(skills_job_dim.job_id) AS demand_count

FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND job_work_from_home = 'True'
GROUP BY skills
ORDER BY demand_count DESC 
LIMIT 5;
```

### Insights
![Top 5 Most in-demand Skills for Data Analysts](assets/Top%205%20Most%20In-Demand%20Skills%20for%20Data%20Analysts%20(2023).png)

Here's the breakdown of the most in-demand skills for data analysts in 2023:

- **SQL Leads the Market:** **SQL** is the most sought-after skill, appearing in **7,291** job postings, making it the foundational skill for data analyst roles.

- **Spreadsheets and Programming Remain Essential:** **Excel** (4,611 postings) and **Python** (4,330 postings) rank just behind SQL, showing employers continue to value both traditional data analysis and programming expertise.

- **Business Intelligence Skills Are Highly Valued:** **Tableau** (3,745 postings) and **Power BI** (2,609 postings) round out the top five, highlighting the strong demand for professionals who can transform data into actionable visual insights.



| Skills | Demand Count |
|--------|-------------:|
| SQL | 7,291 |
| Excel | 4,611 |
| Python | 4,330 |
| Tableau | 3,745 |
| Power BI | 2,609 |

*Table of the demand for the top 5 skills in data analyst job postings*

## 4. Skills Associated with Higher Salaries

By comparing average salaries across different skills, this analysis identifies which technical skills are associated with the highest-paying data analyst positions, helping prioritize valuable skills for career growth.
```sql
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
```
### Insights

![Highest-Paying Skills for Data Analysts](assets/Highest-Paying%20Skills%20for%20Data%20Analysts%20(2023).png)


Here's the breakdown of the highest-paying skills for data analysts in 2023:

- **Big Data Skills Command the Highest Salaries:** **PySpark** tops the list with an average salary of **$208K**, followed by tools like **Databricks** and **Airflow**, highlighting the premium placed on big data processing expertise.

- **Cloud and DevOps Skills Boost Earning Potential:** Skills such as **Kubernetes**, **GitLab**, **Jenkins**, and **GCP** appear among the highest-paying technologies, showing that employers highly value analysts with cloud infrastructure and deployment knowledge.

- **Programming and Machine Learning Remain Highly Rewarded:** Libraries and tools including **Pandas**, **NumPy**, **Scikit-learn**, and **Jupyter** rank among the top-paying skills, emphasizing the financial value of advanced data analysis and machine learning capabilities.

| Skills | Average Salary ($) |
|--------|-------------------:|
| PySpark | 208,172 |
| Bitbucket | 189,155 |
| Couchbase | 160,515 |
| Watson | 160,515 |
| DataRobot | 155,486 |
| GitLab | 154,500 |
| Swift | 153,750 |
| Jupyter | 152,777 |
| Pandas | 151,821 |
| Elasticsearch | 145,000 |

*Table of the average salary for the top 10 paying skills for data analysts*

## 5. Most Optimal Skills to Learn

By combining skill demand with average salary data, this analysis pinpoints the skills that offer the best balance of high demand and strong earning potential, making them the most strategic investments for aspiring data analysts.
```sql
SELECT
skills_job_dim.skill_id,
skills_dim.skills,
count(skills_job_dim.job_id) AS demand_count,
round(avg(job_postings_fact.salary_year_avg), 0) AS salary_average

FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' 
AND job_work_from_home = 'True'
AND salary_year_avg IS NOT NULL

GROUP BY skills_job_dim.skill_id, skills_dim.skills
HAVING count(skills_job_dim.job_id) > 10
ORDER BY 
salary_average DESC,
demand_count DESC

LIMIT 25;
```
### Insight
![Highest-Paying Skills for Data Analysts](assets/Most%20Optimal%20Skills%20for%20Data%20Analysts%20(2023).png)

Here's the breakdown of the most optimal skills for data analysts in 2023:

- **Python Offers the Best Overall Value:** **Python** appears in **236** job postings while offering an average salary of over **$101K**, making it one of the strongest combinations of demand and earning potential.

- **Cloud Skills Deliver High Salaries:** Technologies such as **Snowflake**, **Azure**, and **AWS** combine above-average salaries (over **$108K** for Azure and AWS, **$113K** for Snowflake) with solid demand, making them excellent skills for career growth.

- **Programming and Data Engineering Skills Stand Out:** Skills like **Go**, **Hadoop**, and **BigQuery** command some of the highest average salaries, showing that analysts with modern programming and big data expertise can earn a significant premium.

| Skill ID | Skills | Demand Count | Average Salary ($) |
|---------:|--------|-------------:|-------------------:|
| 8 | Go | 27 | 115,320 |
| 234 | Confluence | 11 | 114,210 |
| 97 | Hadoop | 22 | 113,193 |
| 80 | Snowflake | 37 | 112,948 |
| 74 | Azure | 34 | 111,225 |
| 77 | BigQuery | 13 | 109,654 |
| 76 | AWS | 32 | 108,317 |
| 4 | Java | 17 | 106,906 |
| 194 | SSIS | 12 | 106,683 |
| 233 | Jira | 20 | 104,918 |

*Table of the most optimal skills for data analysts sorted by salary*

---

# What I Learned


Throughout this project, I enhanced my ability to:

- **Write Advanced SQL:** Combined multiple tables using joins, CTEs, and subqueries.
- **Analyze Data Efficiently:** Applied aggregation, filtering, and sorting to uncover meaningful trends.
- **Generate Business Insights:** Used SQL to answer practical questions about salaries, in-demand skills, and career opportunities.

---

# Conclusions

## Insights

From the analysis, several key insights emerged:

1. **Top-Paying Jobs:** Remote data analyst roles offer excellent earning potential, with salaries reaching as high as **$650K** for senior-level positions.

2. **Top-Paying Skills:** **SQL** consistently appears in the highest-paying roles, while cloud and big data technologies further increase earning potential.

3. **Most In-Demand Skills:** **SQL**, **Python**, and **Excel** remain the most sought-after skills, making them essential for aspiring data analysts.

4. **Highest-Paying Skills:** Specialized skills such as **PySpark**, **Databricks**, and cloud platforms command the highest average salaries.

5. **Optimal Skills:** Combining demand with salary shows that **SQL**, **Python**, and cloud technologies like **AWS** and **Azure** provide the strongest return for career growth.

## Closing Thoughts

This project demonstrates how SQL can be used to transform raw job posting data into actionable career insights. By analyzing salaries, skill demand, and industry trends, I identified the technical skills that provide the greatest opportunities for aspiring and experienced data analysts.
