# Introduction
Dive into data job market. Focusing on data scientist roles, this project explores $ top-paying jobs, in-demand skills, and where high demand meets high salary in data scientific.

SQL queries? Check them out here:

[project_sql folder](/project_sql/)
# Background

# Tools I used

For my deep dive into the data scientist job market, I harnesed the power of several key tools:

-**SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.

-**PostgresSQL:** The chosen database management system, ideal for handling the job posting data. 

-**Visual Studio Code:** My go-to for database management and executing SQL queires.

-**Git & Github:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here's how I approached the question

### 1. Top Paying Data Scientist Jobs
data scientist postions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field. 

```sql
 SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name

FROM
    job_postings_fact

LEFT JOIN
    company_dim ON job_postings_fact.company_id = company_dim.company_id

WHERE
    job_title_short = 'Data Scientist' AND
    job_location = 'Anywhere' AND
    --removing nulls
    salary_year_avg IS NOT NULL

ORDER BY
    salary_year_avg DESC
LIMIt 10

```

# What I learned

# Conclusion
### Insights

### Closing Thoughts
This project enahnced my SQL skills