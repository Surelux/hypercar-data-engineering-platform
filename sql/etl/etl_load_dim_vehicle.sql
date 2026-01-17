-- ============================================================
-- Procedure: etl.Load_DimVehicle
-- File: etl_load_dim_vehicle.sql
-- Purpose: Loads unique vehicle records from staging into
--          dw.DimVehicle while preventing duplicates.
-- Layer: ETL (Dimension Load)
-- ============================================================

CREATE OR ALTER PROCEDURE etl.Load_DimVehicle
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO dw.DimVehicle (VIN, Make, Model, Year, BatteryCapacity, MotorType)
        SELECT DISTINCT
            s.VIN,
            s.Make,
            s.Model,
            s.Year,
            s.BatteryCapacity,
            s.MotorType
        FROM staging.StgVehicle s
        LEFT JOIN dw.DimVehicle d
            ON d.VIN = s.VIN
        WHERE d.VIN IS NULL;
    END TRY
    BEGIN CATCH
        INSERT INTO etl.ETL_ErrorLog (RunID, ErrorMessage, ErrorTime, SourceTable)
        VALUES (NULL, ERROR_MESSAGE(), GETDATE(), 'DimVehicle');
        THROW;
    END CATCH
END;
GO
