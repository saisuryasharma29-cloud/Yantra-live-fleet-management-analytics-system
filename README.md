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
WITH daily_usage AS (
    SELECT
        eu.equipment_id,
        DATE(eu.start_time) AS usage_date,
        SUM(eu.worked_hours) AS total_worked_hours,
        SUM(eu.idle_hours) AS total_idle_hours,
        SUM(eu.fuel_consumed) AS total_fuel_consumed
    FROM equipment_usage eu
    GROUP BY eu.equipment_id, DATE(eu.start_time)
),

shift_summary AS (
    SELECT
        es.equipment_id,
        DATE(es.shift_date) AS shift_date,
        COUNT(DISTINCT es.shift_id) AS shifts_operated,
        SUM(es.shift_hours) AS total_shift_hours
    FROM equipment_shift_log es
    GROUP BY es.equipment_id, DATE(es.shift_date)
),

maintenance_status AS (
    SELECT
        mh.equipment_id,
        MAX(mh.service_date) AS last_service_date,
        MAX(mh.next_service_due_hours) AS next_service_due_hours
    FROM maintenance_history mh
    GROUP BY mh.equipment_id
),

hmr_readings AS (
    SELECT
        hr.equipment_id,
        MAX(hr.hmr_value) AS latest_hmr
    FROM hour_meter_readings hr
    GROUP BY hr.equipment_id
)

SELECT
    du.equipment_id,
    du.usage_date,

    du.total_worked_hours,
    du.total_idle_hours,

    ROUND(
        du.total_worked_hours /
        (du.total_worked_hours + du.total_idle_hours) * 100,
        2
    ) AS utilization_percentage,

    du.total_fuel_consumed,

    ROUND(
        du.total_worked_hours /
        NULLIF(du.total_fuel_consumed, 0),
        2
    ) AS fuel_efficiency,

    ss.shifts_operated,
    ss.total_shift_hours,

    ms.last_service_date,
    ms.next_service_due_hours,
    hr.latest_hmr,

    CASE
        WHEN hr.latest_hmr >= ms.next_service_due_hours
        THEN 'SERVICE_REQUIRED'
        ELSE 'OK'
    END AS maintenance_alert_flag

FROM daily_usage du
LEFT JOIN shift_summary ss
    ON du.equipment_id = ss.equipment_id
    AND du.usage_date = ss.shift_date

LEFT JOIN maintenance_status ms
    ON du.equipment_id = ms.equipment_id

LEFT JOIN hmr_readings hr
    ON du.equipment_id = hr.equipment_id

ORDER BY du.usage_date DESC, du.equipment_id;
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
