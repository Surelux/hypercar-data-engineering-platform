-- ============================================================
-- Table: etl.ETL_ErrorLog
-- Purpose: Stores error details captured during ETL execution.
-- Layer: ETL (logging and audit)
-- ============================================================

CREATE TABLE etl.ETL_ErrorLog (
    ErrorID INT IDENTITY(1,1) PRIMARY KEY,
    RunID INT NULL,
    ErrorMessage NVARCHAR(MAX),
    ErrorTime DATETIME,
    SourceTable NVARCHAR(100)
);
