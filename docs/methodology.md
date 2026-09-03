# Methodology

## 1. Data integration

The original project combined public DNRPA records for 2022 and 2023. Power Query was used for the first integration and transformation stage.

The final workbook inspected for this portfolio revision contains 83,840 records and 34 columns.

## 2. Cleaning and transformation

The original workflow documented transformations in Power Query and R. The main operations included:

- conversion of date and categorical fields to usable types;
- standardization of province, make, model and vehicle-type fields;
- creation of cleaned make/model variables;
- derivation of day, month and year fields from the report date;
- inspection of missing values;
- inspection of suspicious holder birth years and unusually old vehicle model years;
- recoding of detailed vehicle types into broader analytical categories.

The recovered R code is preserved in `scripts/original_analysis.R`. A cleaned version suitable for portfolio review is included in `scripts/cleaning_eda_refactored.R`.

## 3. Data-quality checks

A direct audit of the final workbook produced 23,079 empty cells. Most of them are concentrated in fields that were residual, split from other variables, or identifier/code fields.

For holder birth year, the original report used a rule flagging values at or before 1934 and from 2005 onward. Recalculation on the final workbook gives 1,588 flagged records, equivalent to 1.89% of non-missing birth-year values.

This portfolio version treats these records as **flags for review**, not automatically as errors. Domain context is required before deleting or imputing them.

## 4. Exploratory analysis

The EDA examines geographic concentration, vehicle make/model, model year, holder gender, vehicle origin and categorical associations.

The original project found a statistically significant chi-square association between vehicle origin and holder gender (X² ≈ 357.6, df = 6). The portfolio revision adds an effect-size interpretation: Cramér's V ≈ 0.046, indicating a very small association despite the low p-value.

## 5. Storage and SQL

The processed data were stored in SQLite using DB Browser for SQLite. The repository includes both the recovered SQL file and a reorganized set of analytical queries.

## 6. Visualization

Power BI was used to explore geographic concentration, makes/models, model years and gender. The `.pbix` file was not present in the recovered project folder. The original report and presentation still document the Power BI stage, but the repository does not claim to include the `.pbix` file.

## 7. Reproducibility

The notebook runs on a 10-row deterministic sample. Full-dataset statistics reported in the README were recalculated from the final Excel workbook.
