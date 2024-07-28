--CAPSTONE
/*
Questions to Answer
1. What are the top paying jobs for my role?
2. What are the skills required for those top paying roles?
3. What the most in demand skills for my role?
4. What are the top skills based on salary for my role?
5. What are the most optimal skills to learn?
 -- High demand and high paying?*/
 
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

--Q2:

