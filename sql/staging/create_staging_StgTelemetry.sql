-- Staging Table: StgTelemetry 
-- Holds raw telemetry data before ETL processing

CREATE TABLE staging.StgTelemetry (
    VIN NVARCHAR(50),
    TimestampUTC DATETIME2,
    Speed FLOAT,
    BatteryTemp FLOAT,
    MotorTemp FLOAT,
    StateOfCharge FLOAT,
    Country NVARCHAR(100),
    State NVARCHAR(100),
    City NVARCHAR(100),
    Facility NVARCHAR(100)
);
