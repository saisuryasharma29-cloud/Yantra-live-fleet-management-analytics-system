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
## Data Pipeline Architecture

IoT Sensor Data  
↓  
equipment_usage telemetry tables  
↓  
aggregation queries (CTEs + reporting views)  
↓  
maintenance alert logic engine  
↓  
summary reporting dataset  
↓  
Power BI / QuickSight dashboards  

This layered architecture ensures scalable analytics delivery for operational monitoring systems.

---

## End-to-End Reporting Workflow

1. Collect telemetry from equipment IoT sensors
2. Store raw activity logs in MySQL telemetry tables
3. Aggregate runtime metrics using reporting-layer SQL views
4. Detect maintenance thresholds using hour-meter readings
5. Generate utilization KPIs
6. Publish datasets to visualization tools
7. Enable decision dashboards for operations teams

---

## Sample Data Model

### equipment_usage

- equipment_id
- start_time
- worked_hours
- idle_hours
- fuel_consumed

### equipment_shift_log

- equipment_id
- shift_date
- shift_hours
- shift_id

### maintenance_history

- equipment_id
- service_date
- next_service_due_hours

### hour_meter_readings

- equipment_id
- hmr_value

---

## KPIs Generated

The reporting layer produces the following operational KPIs:

- Equipment Utilization Percentage
- Idle Time Ratio
- Fuel Efficiency Index
- Maintenance Alert Flags
- Shift Productivity Metrics
- Equipment Runtime Distribution
- Service Threshold Monitoring Indicators

These KPIs support operational, maintenance, and executive decision-making workflows.

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

## AWS Lambda Fleet Analytics Pipeline

Implemented a serverless analytics workflow using AWS Lambda triggered by S3 uploads.

Pipeline capabilities:

- automatic telemetry ingestion from S3
- utilization percentage calculation
- idle-time ratio computation
- equipment-level aggregation
- processed dataset storage back to S3

This enables scalable event-driven analytics processing without dedicated infrastructure.

---

## Query Optimization Techniques Used

To simulate production-scale reporting performance, the system applies:

* CTE-based aggregation pipelines
* Reporting-layer summary dataset generation
* Null-safe calculations using NULLIF
* Reduced join complexity using staged aggregations
* Stored procedure–ready query architecture
* Trigger-compatible reporting table refresh logic

These techniques reduce dashboard latency and improve analytics reliability.

## Scalability Considerations

The analytics design supports high-frequency telemetry ingestion environments by:

* minimizing repeated joins across raw telemetry tables
* aggregating equipment metrics at reporting-layer views
* enabling scheduled stored-procedure refresh cycles
* supporting dashboard-ready datasets
* preparing structured inputs for predictive maintenance systems

This architecture scales effectively across thousands of equipment records per day.

---

## Dashboard Insights

* Idle vs Active Equipment Ratio
* Geo-location utilization heatmap
* Maintenance risk indicators
* Shift productivity comparison

---

## Real-World Use Case Scenario

A construction company operating 500+ machines across multiple sites uses this analytics system to:

- monitor equipment utilization daily
- detect idle fuel wastage
- identify service-due assets automatically
- compare shift productivity across operators
- optimize fleet allocation across project regions

This improves operational efficiency and reduces unexpected equipment downtime.

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
