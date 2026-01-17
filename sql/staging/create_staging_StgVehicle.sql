-- Staging Table: RawVehicle
-- Holds raw vehicle metadata before ETL processing

CREATE TABLE staging.StgVehicle (
    VIN NVARCHAR(50),
    Model NVARCHAR(100),
    Make NVARCHAR(100),
    Year INT,
    VehicleType NVARCHAR(50),
    EngineType NVARCHAR(50),
    BatteryType NVARCHAR(50)
);
