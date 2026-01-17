-- TEST: Insert sample data into staging tables

-- Clear staging tables first
TRUNCATE TABLE staging.RawVehicle;
TRUNCATE TABLE staging.RawTelemetry;

-- Insert sample vehicle
INSERT INTO staging.RawVehicle (VIN, Model, Make, Year, VehicleType, EngineType, BatteryType)
VALUES
('VIN123', 'Chiron', 'Bugatti', 2022, 'Hypercar', 'Quad-Turbo W16', 'N/A');

-- Insert sample telemetry
INSERT INTO staging.RawTelemetry (VIN, TimestampUTC, Speed, BatteryTemp, MotorTemp, StateOfCharge, Country, State, City, Facility)
VALUES
('VIN123', '2024-01-01T12:00:00', 180.5, 75.2, 90.1, 100, 'USA', 'TN', 'Nashville', 'TestTrack');

-- Runing each ETL step in order
EXEC etl.LoadDimVehicle;
EXEC etl.LoadDimTime;
EXEC etl.LoadFactTelemetry;

-- Runing final checks
SELECT * FROM dw.DimVehicle;

SELECT * FROM dw.DimTime;

SELECT * FROM dw.FactTelemetry;
