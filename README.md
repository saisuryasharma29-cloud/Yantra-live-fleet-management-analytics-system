# Fleet Management Analytics System (MySQL + Python + Power BI)

## Project Overview

Designed and optimized reporting pipelines for a simulated fleet management and predictive maintenance analytics platform handling 10,000+ equipment activity records daily.

This project demonstrates SQL optimization, stored procedure automation, and dashboard-ready dataset engineering similar to production-grade fleet intelligence platforms.

---

## Business Problem

Fleet operators require:

* Equipment utilization tracking
* Idle-time monitoring
* Predictive maintenance alerts
* Geo-location usage visibility
* Shift-wise performance analytics

This project builds a reporting layer to support those decisions.

---

## Tech Stack

* MySQL (Views, Stored Procedures, Triggers)
* Python (Data Processing)
* Power BI / QuickSight (Visualization-ready datasets)

---

## Key Features

### 1. Equipment Utilization Engine

Calculates daily working hours per machine.

### 2. Predictive Maintenance Signals

Detects abnormal usage patterns from runtime trends.

### 3. Shift-Level Productivity Reports

Breaks equipment activity into operator shift windows.

### 4. Automated Reporting Tables

Triggers populate intermediate analytics tables.

---

## Sample Query Example

```sql
SELECT equipment_id,
SUM(worked_hours) AS utilization_hours
FROM equipment_usage
GROUP BY equipment_id;
```

---

## Dashboard Insights

* Idle vs Active Equipment Ratio
* Geo-location utilization heatmap
* Maintenance risk indicators
* Shift productivity comparison

---

## Impact

Improves operational visibility across fleet assets and supports predictive maintenance decisions.
