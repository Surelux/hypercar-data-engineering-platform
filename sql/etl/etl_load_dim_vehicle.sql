-- ETL: Load DimVehicle
-- Inserts new VINs from staging into the dimension

CREATE PROCEDURE etl.LoadDimVehicle
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dw.DimVehicle (VIN, Model, Make, Year, VehicleType, EngineType, BatteryType)
    SELECT 
        rv.VIN,
        rv.Model,
        rv.Make,
        rv.Year,
        rv.VehicleType,
        rv.EngineType,
        rv.BatteryType
    FROM staging.RawVehicle rv
    LEFT JOIN dw.DimVehicle dv
        ON rv.VIN = dv.VIN
    WHERE dv.VIN IS NULL;  -- Only insert new VINs
END;
