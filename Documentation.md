📊 Healthcare Data Analysis with SQL

This project delivers a structured analysis of healthcare data using SQL to derive actionable insights on patient utilization, hospital performance, and cost trends.

🔍 Key Analyses

Patient Admissions & Readmissions: Identification of inpatient trends over time, including readmission patterns using window functions (LAG)

Length of Stay (LOS): Calculation of average hospital stay duration (in days) to evaluate patient throughput and resource utilization

Cost Analysis: Assessment of average cost per encounter to understand financial patterns across visits

Insurance Coverage Insights: Evaluation of procedures covered by insurance through multi-table joins across encounters, procedures, and payer datasets

🧠 Key Insights

📈 Admissions Trend: Inpatient admissions show time-based variation, highlighting potential seasonal or operational patterns

🔁 Readmissions: A measurable proportion of patients experience repeat inpatient visits, indicating opportunities to improve post-discharge care

⏱️ Length of Stay: Average LOS provides a benchmark for hospital efficiency and resource utilization

💰 Cost Patterns: Significant variation exists in encounter costs, suggesting differences in treatment complexity or service utilization

🛡️ Insurance Coverage: Not all procedures are covered by insurance, impacting patient out-of-pocket costs and access to care

🏗️ Project Structure
```
healthcare-sql-analysis/
│
├── data/
│   ├── encounters.csv
│   ├── patients.csv
│   ├── procedures.csv
│   ├── payers.csv
│   └── organizations.csv
│
├── sql/
│   ├── admissions_readmissions.sql
│   ├── length_of_stay.sql
│   ├── cost_analysis.sql
│   └── insurance_coverage.sql
│
├── README.md
└── .gitignore
```
⚙️ Technical Highlights

Advanced SQL techniques including window functions, CTEs, and subqueries

Use of LEFT JOINs to integrate multiple relational tables

Handling of date/time transformations and data type conversions in PostgreSQL

Writing clean, modular, and reusable SQL queries

🚀 Value

This project demonstrates the ability to:

Work with real-world relational datasets

Perform end-to-end data analysis using SQL

Translate raw data into meaningful healthcare and business insights
