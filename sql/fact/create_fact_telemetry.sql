-- Fact Table: Telemetry
-- Stores time-series vehicle telemetry linked to dimensions

CREATE TABLE dw.FactTelemetry (
    TelemetryKey INT IDENTITY(1,1) PRIMARY KEY,
    VehicleKey INT NOT NULL,
    TimeKey INT NOT NULL,
    LocationKey INT NULL,
    Speed FLOAT,
    BatteryTemp FLOAT,
    MotorTemp FLOAT,
    StateOfCharge FLOAT,
    TimestampUTC DATETIME2 NOT NULL,

    CONSTRAINT FK_FactTelemetry_Vehicle
        FOREIGN KEY (VehicleKey) REFERENCES dw.DimVehicle(VehicleKey),

    CONSTRAINT FK_FactTelemetry_Time
        FOREIGN KEY (TimeKey) REFERENCES dw.DimTime(TimeKey),

    CONSTRAINT FK_FactTelemetry_Location
        FOREIGN KEY (LocationKey) REFERENCES dw.DimLocation(LocationKey)
);
