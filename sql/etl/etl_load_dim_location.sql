-- ============================================================
-- Procedure:etl.Load_DimLocation
-- File: etl_load_dim_location.sql
-- Purpose: Loads location fact records by resolving foreign keys
--          from all dimensions and inserting measures.
-- Layer: ETL (Fact Load)
-- ============================================================
CREATE OR ALTER PROCEDURE etl.Load_DimLocation
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO dw.DimLocation (
            City,
            State,
            Country
        )
        SELECT DISTINCT
            s.City,
            s.State,
            s.Country
        FROM staging.StgTelemetry s
        LEFT JOIN dw.DimLocation d
            ON d.City = s.City
           AND d.State = s.State
           AND d.Country = s.Country
        WHERE d.LocationKey IS NULL;
    END TRY
    BEGIN CATCH
        INSERT INTO etl.ETL_ErrorLog (RunID, ErrorMessage, ErrorTime, SourceTable)
        VALUES (NULL, ERROR_MESSAGE(), GETDATE(), 'DimLocation');
        THROW;
    END CATCH
END;
GO

