-- ============================================================
-- Procedure: etl.Load_DimTime
-- File: etl_load_dim_time.sql
-- Purpose: Populates dw.DimTime with unique timestamps from
--          staging telemetry data.
-- Layer: ETL (Dimension Load)
-- ============================================================

CREATE OR ALTER PROCEDURE etl.Load_DimTime
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO dw.DimTime (
            FullDate,
            Year,
            Quarter,
            Month,
            Day,
            DayOfWeek
        )
        SELECT DISTINCT
            CAST(s.TimestampUTC AS date) AS FullDate,
            DATEPART(YEAR, s.TimestampUTC)    AS Year,
            DATEPART(QUARTER, s.TimestampUTC) AS Quarter,
            DATEPART(MONTH, s.TimestampUTC)   AS Month,
            DATEPART(DAY, s.TimestampUTC)     AS Day,
            DATEPART(WEEKDAY, s.TimestampUTC) AS DayOfWeek
        FROM staging.StgTelemetry s
        LEFT JOIN dw.DimTime d
            ON d.FullDate = CAST(s.TimestampUTC AS date)
        WHERE d.FullDate IS NULL;
    END TRY
    BEGIN CATCH
        INSERT INTO etl.ETL_ErrorLog (RunID, ErrorMessage, ErrorTime, SourceTable)
        VALUES (NULL, ERROR_MESSAGE(), GETDATE(), 'DimTime');
        THROW;
    END CATCH
END;
GO

