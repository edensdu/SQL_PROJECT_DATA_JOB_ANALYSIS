SELECT 
    
    COUNT(job_id) AS number_of_jobs,
    avg(salary_year_avg) AS Average_Yearly_salaries,
    CASE
        WHEN
            job_location='Anywhere' 
            THEN 'Remote'
        WHEN job_location = 'New York, NY'
            THEN 'Local'
        ELSE 'Onsite'
    END AS location_category -- name of new column
FROM 
    job_postings_fact
WHERE
    job_title_short='Data Analyst'
GROUP BY
    location_category; --name of column;

SELECT 
    job_id,
    salary_year_avg,
    CASE
        WHEN salary_year_avg < 90000
            THEN 'Low'
        WHEN salary_year_avg >=90000 OR salary_year_avg <=150000
            THEN 'Standard'

        WHEN salary_year_avg >150000
            THEN 'High'
        ELSE 'Low'
    END AS Salary_Categories

FROM job_postings_fact

WHERE 
    job_title_short = 'Data Analyst'

ORDER BY
    Salary_Categories DESC

--GROUP BY Salary_Categories

SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date)=1)
    AS january_jobs;

-- CTE
WITH january_jobs as (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date)=1)

SELECT *
FROM january_jobs;

--GeT data for no degress using subqueries

SELECT 
    name as company_name
FROM company_dim
WHERE company_id IN(
    SELECT
        company_id
    FROM 
        job_postings_fact

    WHERE
        job_no_degree_mention = true)

-- find companies with most job openings
WITH company_job_count AS(
SELECT  
    company_id,
    count(*) AS Total_Jobs
FROM
    job_postings_fact
GROUP BY
    company_id)

SELECT 
    company_dim.name AS company_name,
    company_job_count.Total_Jobs

FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY   
    Total_Jobs DESC


/*CTE problem - find the count of the number of repote job postings per skill
 didplay the top 5 skills by their demand in remote jobs
include skill ID, name, count of postings requiring the skill*/

--built a cte to collect job posting per skills
WITH remote_job_skills AS (
    SELECT 
        skill_id,
        COUNT(*) AS skill_count

    FROM 
        skills_job_dim AS skills_to_job
    INNER JOIN 
        job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id

    WHERE
        job_postings.job_work_from_home = true AND
        job_postings.job_title_short = 'Data Analyst'

    --Anytime you do an aggregation like count you need a groupby

    GROUP BY
        skill_id)

SELECT 
    skills.skill_id,
    skills as skill_name,
    skill_count
FROM remote_job_skills
INNER JOIN
    skills_dim AS skills on skills.skill_id = remote_job_skills.skill_id

ORDER BY
    skill_count DESC

LIMIT 5

/*
Union Operators
Combine results sets of two or more SELECT statements into a single result set
UNION: remove duplicate rows
UNION ALL: Includes all duplicate rows
Each select statement within the union must have the same number of columns in the 
result sets with similar data types*

SELECT column_name
FROM table_one

UNION -- combine the two tables

SELECT column_name
FROM table_two;
*/

--USING UNION
select
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION

select
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs
    
UNION
select
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs


--USING UNION ALL

select
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION ALL

select
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs
    
UNION ALL
select
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs


--Get the corresponding skill and skill type for each job posting in q1
SELECT
    skills AS skill_names,
    type AS skill_type

FROM
    skills_dim
INNER JOIN

select *

FROM
january_jobs;

SELECT *
FROM skills_job_dim

/*Practice Proble
Find job postings from the first quarter that have a salary greater than 70k
combine job posting tables from the first quarter of 2023
get job postings with average yearly salary*/
SELECT 
    quarter1_job_postings.job_title_short,
    quarter1_job_postings.job_location,
    quarter1_job_postings.job_via,
    quarter1_job_postings.job_posted_date::date,
    quarter1_job_postings.salary_year_avg
FROM (
SELECT *
FROM january_jobs
UNION all
SELECT *
FROM february_jobs
UNION ALL
SELECT *
FROM march_jobs) AS quarter1_job_postings
WHERE
    quarter1_job_postings.salary_year_avg>70000 AND 
    quarter1_job_postings.job_title_short='Data Analyst'
ORDER BY
    quarter1_job_postings.salary_year_avg DESC