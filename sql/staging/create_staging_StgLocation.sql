-- Staging Table: StgLocation
-- Holds raw Location data before ETL processing
CREATE TABLE staging.StgLocation (
    Latitude FLOAT,
    Longitude FLOAT,
    City NVARCHAR(100),
    State NVARCHAR(100),
    Country NVARCHAR(100)
);
GO