CREATE OR ALTER PROCEDURE etl.Load_FactTelemetry
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO dw.FactTelemetry (
            VehicleKey,
            TimeKey,
            LocationKey,
            TimestampUTC,
            Speed,
            BatteryTemp,
            MotorTemp,
            StateOfCharge
        )
        SELECT
            v.VehicleKey,
            t.TimeKey,
            l.LocationKey,
            s.TimestampUTC,
            s.Speed,
            s.BatteryTemp,
            s.MotorTemp,
            s.StateOfCharge
        FROM staging.StgTelemetry s
        INNER JOIN dw.DimVehicle v
            ON v.VIN = s.VIN
        INNER JOIN dw.DimTime t
            ON t.FullDate = CAST(s.TimestampUTC AS date)
        INNER JOIN dw.DimLocation l
            ON l.City = s.City
           AND l.State = s.State
           AND l.Country = s.Country
        LEFT JOIN dw.FactTelemetry f
            ON f.VehicleKey = v.VehicleKey
           AND f.TimeKey = t.TimeKey
           AND f.LocationKey = l.LocationKey
           AND f.TimestampUTC = s.TimestampUTC
        WHERE f.TelemetryKey IS NULL;
    END TRY
    BEGIN CATCH
        INSERT INTO etl.ETL_ErrorLog (RunID, ErrorMessage, ErrorTime, SourceTable)
        VALUES (NULL, ERROR_MESSAGE(), GETDATE(), 'FactTelemetry');
        THROW;
    END CATCH
END;
GO
