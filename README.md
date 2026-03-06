# Astrafy Take-Home Challenge

This repository contains the full solution to the Astrafy data engineering take-home challenge. It covers data ingestion, transformation with dbt, and reporting with LookML.

---

## Project Overview

The goal of this challenge is to analyse order and sales data from an e-commerce platform, answer specific business questions, and build a reporting layer on top of BigQuery.

**Data scope:** July 2022 – December 2023
**Stack:** Python · dbt · BigQuery · LookML (Looker)

---

## Repository Structure

```
.
├── data/                          # Raw source files (Excel)
│   ├── orders_recrutement.xlsx
│   └── sales_recrutement.xlsx
│
├── dbt_astrafy/                   # dbt project
│   ├── seeds/                     # CSV files loaded into BigQuery
│   ├── models/
│   │   ├── staging/               # Cleaned and typed source models
│   │   └── marts/                 # Business-ready fact tables
│   └── analyses/                  # Ad-hoc SQL queries for the challenge questions
│
├── lookml/                        # LookML definitions for Looker
│   └── models/
│       ├── ecommerce.model.lkml
│       └── views/
│
├── excel_to_csv.py                # Script to convert Excel source files to CSV seeds
└── README.md
```

---

## Setup

### 1. Convert source files to CSV seeds

```bash
pip install pandas openpyxl
python excel_to_csv.py
```

This generates `dbt_astrafy/seeds/orders.csv` and `dbt_astrafy/seeds/sales.csv`.

### 2. Load seeds and run dbt models

```bash
cd dbt_astrafy
dbt seed
dbt run
dbt test
```

---

## Data Architecture

### Staging layer (`models/staging/`)

| Model | Description |
|---|---|
| `stg_orders` | Cleaned orders — types cast, columns renamed |
| `stg_sales` | Cleaned sales lines — types cast, columns renamed |

### Marts layer (`models/marts/`)

| Model | Description |
|---|---|
| `fct_orders` | Orders fact table (2022–2023), enriched with product count per order |
| `fct_orders_segmentation` | 2023 orders with customer segmentation (New / Returning / VIP) |
| `fct_sales` | 2023 sales lines at product level |

---

## Business Questions (analyses/)

| File | Question |
|---|---|
| `q1_nb_orders_2023.sql` | How many orders were placed in 2023? |
| `q2_orders_per_month_2023.sql` | How many orders per month in 2023? |
| `q3_avg_products_per_order_2023.sql` | What is the average number of products per order, per month in 2023? |
| `data_quality_checks.sql` | Data quality checks (duplicates, nulls, date ranges, orphan records) |

---

## Reporting (LookML)

The `lookml/` folder contains a Looker model exposing:

- **`orders_2023_segmented`** view — orders with customer segmentation, measures for revenue and order count
- **`sales_2023`** view — sales lines at product level, joined to the orders explore

---

## Data Quality Summary

| Check | Result |
|---|---|
| Duplicate `order_id` in orders | 0 |
| Duplicate `order_id + product_id` in sales | 0 |
| Orders without associated sales lines | 0 |
| `net_sales` range | 1.77 – 824.01 |
| `qty` range | 1 – 50 |
| Date range | 2022-07-09 – 2023-12-31 |
