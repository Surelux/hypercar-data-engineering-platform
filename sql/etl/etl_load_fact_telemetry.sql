-- ETL: Load FactTelemetry
-- Transforms raw telemetry into fact table rows

CREATE PROCEDURE etl.LoadFactTelemetry
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dw.FactTelemetry (
        VehicleKey,
        TimeKey,
        LocationKey,
        Speed,
        BatteryTemp,
        MotorTemp,
        StateOfCharge,
        TimestampUTC
    )
    SELECT
        dv.VehicleKey,
        dt.TimeKey,
        dl.LocationKey,
        rt.Speed,
        rt.BatteryTemp,
        rt.MotorTemp,
        rt.StateOfCharge,
        rt.TimestampUTC
    FROM staging.RawTelemetry rt
    INNER JOIN dw.DimVehicle dv
        ON rt.VIN = dv.VIN
    INNER JOIN dw.DimTime dt
        ON CAST(rt.TimestampUTC AS DATE) = dt.FullDate
    LEFT JOIN dw.DimLocation dl
        ON rt.Country = dl.Country
        AND rt.State = dl.State
        AND rt.City = dl.City
        AND rt.Facility = dl.Facility;
END;
