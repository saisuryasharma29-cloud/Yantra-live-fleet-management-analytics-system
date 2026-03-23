WITH latest_hmr AS (
    SELECT
        equipment_id,
        MAX(hmr_value) AS latest_hmr_reading
    FROM hour_meter_readings
    GROUP BY equipment_id
),

last_service AS (
    SELECT
        equipment_id,
        MAX(service_date) AS last_service_date,
        MAX(next_service_due_hours) AS next_service_due_hours
    FROM maintenance_history
    GROUP BY equipment_id
),

equipment_usage_summary AS (
    SELECT
        equipment_id,
        SUM(worked_hours) AS total_runtime_hours,
        SUM(idle_hours) AS total_idle_hours
    FROM equipment_usage
    GROUP BY equipment_id
)

SELECT
    lhmr.equipment_id,
    lhmr.latest_hmr_reading,
    ls.last_service_date,
    ls.next_service_due_hours,
    eus.total_runtime_hours,
    eus.total_idle_hours,

    CASE
        WHEN lhmr.latest_hmr_reading >= ls.next_service_due_hours
        THEN 'SERVICE_REQUIRED'

        WHEN lhmr.latest_hmr_reading >= (ls.next_service_due_hours - 50)
        THEN 'SERVICE_DUE_SOON'

        ELSE 'NORMAL_OPERATION'
    END AS maintenance_status_flag

FROM latest_hmr lhmr
LEFT JOIN last_service ls
    ON lhmr.equipment_id = ls.equipment_id

LEFT JOIN equipment_usage_summary eus
    ON lhmr.equipment_id = eus.equipment_id

ORDER BY maintenance_status_flag DESC;
