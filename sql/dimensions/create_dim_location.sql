-- Dimension: Location
-- Stores geographic or facility-related metadata

CREATE TABLE dw.DimLocation (
    LocationKey INT IDENTITY(1,1) PRIMARY KEY,
    Country NVARCHAR(100),
    State NVARCHAR(100),
    City NVARCHAR(100),
    Facility NVARCHAR(100)
);
