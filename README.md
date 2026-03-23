# Fleet Management Analytics System (MySQL + Python + Power BI)

## Project Overview

Designed and optimized reporting pipelines for a simulated fleet management client **YantraLive** and predictive maintenance analytics platform handling 10,000+ equipment activity records daily.

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

## Business Impact

This analytics layer enables data-driven decision-making across operations, maintenance, fuel management, workforce productivity, and asset lifecycle planning.

* <ins>Asset Utilization Optimization<ins>

The system calculates daily utilization percentages per equipment, helping operations teams:

Identify underutilized machinery across sites
Detect overused equipment nearing failure risk
Reallocate idle assets before renting additional equipment
Improve capital investment efficiency
Increase ROI per machine across project locations

Result: Reduced unnecessary rentals and improved fleet deployment strategy.

* <ins>Idle-Time Reduction and Fuel Waste Control<ins>

Idle-time analytics highlight machines consuming fuel without productive output.

This enables:

Detection of operator idle behavior patterns
Enforcement of idle shutdown policies
Reduction of unnecessary engine runtime
Monitoring of site-level inefficiencies
Identification of machines running outside scheduled shift windows

Result: Lower fuel costs and improved environmental compliance.

* <ins>Fuel Efficiency Monitoring and Engine Health Insights<ins>

Fuel consumption vs working-hour comparisons help detect abnormal equipment performance.

This supports:

Early identification of engine inefficiencies
Detection of fuel leakage or abnormal burn rates
Comparison across operators, machine types, and terrain conditions
Preventive servicing decisions before major failures
Long-term fuel optimization strategies

Result: Reduced operational fuel expenditure and improved machine reliability.

* <ins>Predictive Maintenance Planning<ins>

Integration of hour-meter readings with service thresholds enables automated maintenance alerts.

This allows organizations to:

Detect service-due equipment proactively
Prevent unexpected equipment breakdowns
Reduce emergency repair costs
Extend asset lifespan
Improve spare-parts planning accuracy
Minimize project delays due to machine failure

Result: Reduced downtime and improved maintenance scheduling efficiency.

* <ins>Shift Productivity and Workforce Optimization<ins>

Shift-level analytics reveal performance variations across operators and working windows.

This helps:

Compare productivity across shifts
Detect underperforming operational windows
Optimize workforce allocation strategies
Reduce overtime dependency
Improve operator accountability
Increase utilization during peak productivity hours

Result: Improved workforce efficiency and scheduling effectiveness.

* <ins>Equipment Health Risk Detection<ins>

Continuous monitoring of utilization patterns enables early identification of abnormal machine behavior.

This supports:

Detection of overuse conditions
Identification of overheating risk scenarios
Monitoring workload imbalance across fleet assets
Preventive workload redistribution
Extension of equipment service intervals through balanced usage

Result: Lower breakdown probability and extended equipment lifecycle.

* <ins>Centralized Reporting Layer for Analytics Dashboards<ins>

The query architecture builds a unified reporting dataset for visualization tools.

This improves:

Dashboard refresh performance
Reporting consistency across teams
Data availability for business stakeholders
Cross-department visibility into fleet KPIs
Decision-making speed for operations managers

Result: Faster executive insights with reduced reporting latency.

* <ins>Geo-Based Fleet Deployment Optimization<ins>

When integrated with equipment GPS coordinates, utilization insights enable spatial intelligence.

This allows:

Region-wise asset allocation optimization
Identification of underutilized locations
Reduction in equipment transportation delays
Strategic redistribution across projects
Improved logistics coordination

Result: Optimized fleet distribution across multiple operational zones.

* <ins>Preventive Cost Control Across Fleet Operations<ins>

Operational analytics reduce multiple hidden cost components:

idle fuel burn
emergency repair costs
rental equipment dependency
spare-part shortages
operator inefficiencies
machine downtime penalties

Result: Significant reduction in total fleet operating expenditure.

* <ins>Executive KPI Monitoring Enablement<ins>

This analytics dataset supports leadership dashboards tracking:

utilization percentage trends
idle-time ratios
service-due equipment counts
fuel efficiency benchmarks
shift productivity distribution
maintenance backlog indicators

Result: Data-backed strategic planning and asset investment decisions.

* <ins>Data Pipeline Automation for Reporting Workflows<ins>

Automated stored procedures and reporting views reduce manual intervention.

This enables:

scheduled analytics refresh cycles
consistent KPI availability
reduced dependency on manual Excel reporting
improved reporting reliability
scalable analytics infrastructure

Result: Faster and more reliable reporting operations.

* <ins>Support for Predictive Analytics Readiness<ins>

Structured telemetry aggregation prepares datasets for future ML models such as:

failure prediction
maintenance forecasting
utilization trend forecasting
fuel consumption prediction
anomaly detection systems

## <ins>Result<ins>: 
Foundation for transitioning from descriptive analytics to predictive fleet intelligence.
