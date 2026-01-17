-- Staging Table: RawTelemetry
-- Holds raw telemetry data before ETL processing

CREATE TABLE staging.RawTelemetry (
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
