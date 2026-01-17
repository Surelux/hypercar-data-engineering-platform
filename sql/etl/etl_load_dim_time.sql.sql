-- ETL: Load DimTime
-- Inserts unique dates from staging into the time dimension

CREATE PROCEDURE etl.LoadDimTime
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dw.DimTime (FullDate, Year, Quarter, Month, Day, DayOfWeek)
    SELECT 
        CAST(rt.TimestampUTC AS DATE) AS FullDate,
        YEAR(rt.TimestampUTC) AS Year,
        DATEPART(QUARTER, rt.TimestampUTC) AS Quarter,
        MONTH(rt.TimestampUTC) AS Month,
        DAY(rt.TimestampUTC) AS Day,
        DATEPART(WEEKDAY, rt.TimestampUTC) AS DayOfWeek
    FROM staging.RawTelemetry rt
    LEFT JOIN dw.DimTime dt
        ON CAST(rt.TimestampUTC AS DATE) = dt.FullDate
    WHERE dt.FullDate IS NULL;  -- Only insert new dates
END;
