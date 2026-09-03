# Data Cleaning & Exploratory Data Analysis: Vehicle Theft in Argentina (2022–2023)

Portfolio project based on public vehicle-theft records from Argentina's **Dirección Nacional del Registro de la Propiedad Automotor (DNRPA)**.

The project focuses on the **data pipeline** rather than only the final charts: dataset integration, cleaning, quality checks, exploratory analysis, relational storage, SQL queries and dashboarding.

![Power BI dashboard](dashboard/dashboard_vehicles.jpg)

## Project overview

The final processed workbook contains **83,840 records and 34 columns**. The original written report states 83,480 records, while the final workbook and Power BI dashboard show 83.84k; this repository uses the count verified directly from the final workbook.

The workflow developed for the course project was:

**DNRPA raw files → Power Query → R / EDA → SQLite / SQL → Power BI**

### Main tasks

- Combined 2022 and 2023 records.
- Standardized dates, provinces, vehicle types, makes and models.
- Created derived variables for analysis.
- Audited missing values and suspicious records.
- Explored vehicle age, make/model, geography and holder gender.
- Stored processed data in SQLite and wrote SQL queries.
- Built a Power BI dashboard for geographic and descriptive exploration.

## Data quality audit

A fresh audit of the final workbook confirms:

| Check | Result |
|---|---:|
| Records | 83,840 |
| Variables | 34 |
| Empty cells | 23,079 |
| Missing `Tipo_descripcion2` | 11,397 |
| Missing country ID | 4,750 |
| Missing vehicle-type code | 2,399 |
| Missing model-year values | 174 |
| Missing holder birth year | 14 |

The original project also flagged suspicious holder birth years. Reapplying the documented rule (**birth year ≤ 1934 or ≥ 2005**) identifies **1,588 records (1.89%)**. This corrects the percentage reported in the original coursework while preserving the original criterion.

## Selected findings

- **Buenos Aires** accounts for 55,848 records, followed by **CABA** (10,439), **Córdoba** (7,021) and **Santa Fe** (4,048).
- The most frequent cleaned makes are **Volkswagen (17,350)**, **Chevrolet (11,534)**, **Fiat (11,361)** and **Renault (11,221)**.
- The leading make/model combinations are **Volkswagen Gol (8,366)**, **Chevrolet Corsa (3,544)**, **Renault Kangoo (2,294)** and **Toyota Hilux (2,168)**.
- Among records identified as male or female, **66.7% correspond to male holders**.
- A chi-square test between vehicle origin and holder gender is statistically significant, but the association is **very small** (Cramér's V ≈ 0.046). This distinction between statistical significance and effect size is added in the portfolio revision.

## Repository structure

```text
.
├── README.md
├── notebooks/
│   └── 01_data_cleaning_eda.ipynb
├── data/
│   ├── README.md
│   └── robo_autos_sample.csv
├── scripts/
│   ├── original_analysis.R
│   └── cleaning_eda_refactored.R
├── sql/
│   ├── original_queries.sql
│   └── analysis.sql
├── dashboard/
│   └── dashboard_vehicles.jpg
├── docs/
│   └── methodology.md
└── requirements.txt
```

## Reproducible notebook

The notebook uses a **deterministic 30-row sample** extracted from the final processed workbook. The sample is included so the repository can be cloned and executed without distributing the 26 MB Excel file.

The full-data metrics in this README were recalculated directly from the final workbook and are not inferred from the sample.

## Tools

`Power Query` · `R` · `Python` · `pandas` · `SQLite` · `SQL` · `Power BI` · `Excel`

## Context

Originally developed for **Laboratorio de Datos**, Licenciatura en Análisis y Gestión de Datos, Universidad Nacional de San Luis. The repository was later reorganized as a data-analysis portfolio case study, preserving the original R/SQL files while adding a reproducible notebook and clearer methodological documentation.
