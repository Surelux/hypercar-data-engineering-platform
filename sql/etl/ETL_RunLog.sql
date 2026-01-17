-- ============================================================
-- Table: etl.ETL_RunLog
-- Purpose: Records ETL pipeline execution details, including
--          start/end times, status, and row counts.
-- Layer: ETL (logging and audit)
-- ============================================================

CREATE TABLE etl.ETL_RunLog (
    RunID INT IDENTITY(1,1) PRIMARY KEY,
    PipelineName NVARCHAR(100),
    StartTime DATETIME,
    EndTime DATETIME,
    Status NVARCHAR(50),
    RowsInserted INT
);
GO
