-- Dimension: Time
-- Stores calendar breakdown for analytics

CREATE TABLE dw.DimTime (
    TimeKey INT IDENTITY(1,1) PRIMARY KEY,
    FullDate DATE NOT NULL,
    Year INT NOT NULL,
    Quarter INT NOT NULL,
    Month INT NOT NULL,
    Day INT NOT NULL,
    DayOfWeek INT NOT NULL
);
