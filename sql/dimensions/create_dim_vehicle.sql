CREATE TABLE dw.DimVehicle (
    VehicleKey INT IDENTITY(1,1) PRIMARY KEY,
    VIN NVARCHAR(50) NOT NULL UNIQUE,
    Model NVARCHAR(100),
    Make NVARCHAR(100),
    Year INT,
    VehicleType NVARCHAR(50),
    EngineType NVARCHAR(50),
    BatteryType NVARCHAR(50)
);
