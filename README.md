# 🦠 COVID-19 Data Exploration in SQL

This project is a **SQL-based data exploration** of a global COVID-19 dataset, This project presents an in-depth data exploration of global COVID-19 trends using SQL. The analysis focuses on understanding the pandemic's impact through case trends, death rates, and vaccination progress across countries and continents. It demonstrates my ability to clean, transform, and analyze large datasets using SQL, while drawing insights relevant to real-world public health scenarios.

---

## 📁 Dataset

The data used in this project comes from **Our World in Data (OWID)** and includes:
- `CovidDeathsInfo`: Contains country-level data on COVID-19 cases, deaths, and population.
- `CovidVaccinationInfo`: Contains vaccination rollout information for each country.

Both datasets were loaded into a local SQL Server database for analysis.

---

## 🧠 Key Skills

- SQL Joins (INNER JOIN)
- CTEs (Common Table Expressions)
- Window Functions (e.g., `SUM() OVER (PARTITION BY ...)`)
- Aggregate Functions (`MAX`, `SUM`, `CAST`)
- Subqueries & Temp Tables
- Filtering, Ordering, Grouping
- Calculating rolling totals and percentages

---

## 📈 Key Objectives

- Understand global COVID-19 trends using data-driven analysis
- Calculate death and infection rates across locations
- Track vaccination progress over time
- Use advanced SQL features like window functions and CTEs to handle time-based calculations
- Practice building analytical queries that simulate real-world business intelligence use cases

---

## 📊 Insights & Analysis

The following exploratory queries were run:

1. **Total cases vs Total deaths**  
   → Likelihood of dying if infected, per country.

2. **Total cases vs Population**  
   → Infection rate per country.

3. **Countries with highest infection rates**  
   → Based on percent population infected.

4. **Highest death counts**  
   → Deaths by country and continent.

5. **Global death percentage**  
   → Aggregated global data showing COVID’s impact.

6. **Vaccination trends**  
   → Rolling number of people vaccinated using a window function.

7. **CTEs & Temp Tables**  
   → Used to calculate and store intermediate results like vaccination percentages.

