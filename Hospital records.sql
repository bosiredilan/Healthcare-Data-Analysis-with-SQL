
set search_path to data_trials;

-- How many patients have been admitted or readmitted over time? 

-- 1. Admissions over time 
-- Number of patients admitted per month/year.

SELECT 
    DATE_TRUNC('month', CAST("START" AS timestamptz)) AS month, -- convert to date, column stored as TEXT
    TRIM(TO_CHAR("START"::timestamptz, 'Month')) AS month_name, -- getting the month name
    COUNT(DISTINCT "PATIENT") AS admitted_patients  -- counts the number of unique patients
FROM encounters
WHERE "ENCOUNTERCLASS" = 'inpatient'
GROUP BY month, month_name
ORDER BY month;


--2. Readmissions over time
--Use a window function (LAG) to compare each patient’s previous visit.

SELECT 
    DATE_TRUNC('month', CAST("START" AS timestamptz)) AS month,
    TRIM(TO_CHAR("START"::timestamptz, 'Month')) AS month_name,
    COUNT(DISTINCT "PATIENT") AS readmitted_patients
FROM (
    SELECT 
        "PATIENT",
        "START",
        LAG("START") OVER (
            PARTITION BY "PATIENT" 
            ORDER BY "START"
        ) AS previous_visit
    FROM encounters
    WHERE "ENCOUNTERCLASS" = 'inpatient'
) t --Treat everything as a temporary table, name it t
WHERE previous_visit IS NOT NULL
GROUP BY month, month_name
ORDER BY month;

-- How long are patients staying in the hospital, on average? 

SELECT 
    AVG(EXTRACT(EPOCH FROM ("STOP"::timestamptz - "START"::timestamptz)) / 86400) -- 1 day = 86,400 seconds, EXTRACT(EPOCH) gives seconds
    AS avg_days
FROM encounters
WHERE "ENCOUNTERCLASS" = 'inpatient'
AND "STOP" IS NOT NULL;


--How much is the average cost per visit?
 
SELECT 	
	AVG("TOTAL_CLAIM_COST") as AVG_COST
FROM encounters;



-- How many procedures are covered by insurance?
-- Using CTE
WITH insured AS (
    SELECT 
        p."PATIENT", 
        e."PAYER", 
        e."BASE_ENCOUNTER_COST", 
        r."NAME", 
        r."PHONE"
    FROM procedures AS p
    LEFT JOIN encounters AS e
        ON e."Id" = p."ENCOUNTER"
    LEFT JOIN payers r
        ON e."PAYER" = r."Id"
)
SELECT 
    COUNT("NAME") AS total_procedures_insured
FROM insured
WHERE "NAME" <> 'NO_INSURANCE';



--Using subquery
SELECT 
    COUNT(*) AS total_procedures_insured
    FROM(
    	SELECT 
        p."PATIENT", 
        e."PAYER", 
        e."BASE_ENCOUNTER_COST", 
        r."NAME", 
        r."PHONE"
    FROM procedures AS p
    LEFT JOIN encounters AS e
        ON e."Id" = p."ENCOUNTER"
    LEFT JOIN payers r
        ON e."PAYER" = r."Id"
) as sub
WHERE "NAME" <> 'NO_INSURANCE';

