EXEC etl.Load_DimVehicle;
EXEC etl.Load_DimTime;
EXEC etl.Load_DimLocation;
EXEC etl.Load_FactTelemetry;

SELECT 'DimVehicle', COUNT(*) FROM dw.DimVehicle
UNION ALL
SELECT 'DimTime', COUNT(*) FROM dw.DimTime
UNION ALL
SELECT 'DimLocation', COUNT(*) FROM dw.DimLocation
UNION ALL
SELECT 'FactTelemetry', COUNT(*) FROM dw.FactTelemetry;

SELECT TOP 1 VIN, TimestampUTC, City, State, Country
FROM staging.StgTelemetry;
