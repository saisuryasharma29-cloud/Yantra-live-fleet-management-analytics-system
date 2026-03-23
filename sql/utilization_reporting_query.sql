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
