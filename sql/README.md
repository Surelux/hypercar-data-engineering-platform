# Hypercar Telemetry Data Warehouse

# A fully implemented star‑schema data warehouse designed to process, store, and analyze high‑frequency vehicle telemetry data. This project demonstrates end‑to‑end data engineering skills, including schema design, ETL development, error logging, validation, and documentation.

# 

# Project Overview

# This warehouse ingests raw telemetry data from high‑performance vehicles and organizes it into a dimensional model optimized for analytics. The solution includes:

# \- A staging layer for raw ingestion

# \- Three dimension tables (Vehicle, Time, Location)

# \- One fact table (Telemetry)

# \- Four ETL stored procedures

# \- Error logging for traceability

# \- Validation queries to ensure data integrity

# The project is structured to mirror real enterprise data engineering workflows.

# 

# Data Model

# The warehouse follows a classic star schema:

# \- FactTelemetry stores all measurable telemetry events

# \- DimVehicle, DimTime, and DimLocation provide descriptive attributes

# \- Surrogate keys ensure consistency and performance

# \- Natural keys from staging are resolved during ETL

# 

# Entity Relationship Diagram (ERD)

&nbsp;                        +---------------------+

&nbsp;                        |     DimVehicle      |

&nbsp;                        +---------------------+

&nbsp;                        | VehicleKey (PK)     |

&nbsp;                        | VIN                 |

&nbsp;                        | Make                |

&nbsp;                        | Model               |

&nbsp;                        | Year                |

&nbsp;                        +----------+----------+

&nbsp;                                   |

&nbsp;                                   | 1-to-many

&nbsp;                                   |

+---------------------+             |

|      DimTime        |             |

+---------------------+             |

| TimeKey (PK)        |             |

| FullDate            |             |

| Year                |

| Quarter             |

| Month               |

| Day                 |

| DayOfWeek           |

+----------+----------+             |

&nbsp;          |                        |

&nbsp;          | 1-to-many              |

&nbsp;          |                        |

&nbsp;          |                        |

&nbsp;          |                        |

+----------v----------+-------------v-----------+

|                 FactTelemetry                  |

+-----------------------------------------------+

| TelemetryKey (PK)                             |

| VehicleKey (FK)                               |

| TimeKey (FK)                                  |

| LocationKey (FK)                              |

| TimestampUTC                                   |

| Speed                                          |

| BatteryTemp                                    |

| MotorTemp                                      |

| StateOfCharge                                  |

+----------------------+------------------------+

&nbsp;                      |

&nbsp;                      | many-to-1

&nbsp;                      |

&nbsp;            +---------v----------+

&nbsp;            |    DimLocation     |

&nbsp;            +---------------------+

&nbsp;            | LocationKey (PK)    |

&nbsp;            | City                |

&nbsp;            | State               |

&nbsp;            | Country             |

&nbsp;            +---------------------+



ETL Pipeline

The ETL layer consists of four stored procedures executed in the following order:

---------------------------------------------------------------------------------------------------------

| Step | Procedure              | Description                                                            | 

---------------------------------------------------------------------------------------------------------

|  1   | etl.Load\_DimVehicle    | Loads distinct VINs into DimVehicle                                    |

--------------------------------------------------------------------------------------------------------- 

|  2   | etl.Load\_DimTime       | Extracts date components from TimestampUTC and loads into DimTime      |

---------------------------------------------------------------------------------------------------------

|  3   | etl.Load\_DimLocation   | Loads distinct city, state, and country combinations into DimLocation  |

---------------------------------------------------------------------------------------------------------

|  4   | etl.Load\_FactTelemetry | Joins staging telemetry to all dimensions and loads into FactTelemetry | 

---------------------------------------------------------------------------------------------------------





ETL Design Principles

\- Surrogate keys generated in each dimension

\- Natural keys resolved from staging

\- Duplicate prevention using left joins

\- Error handling via TRY/CATCH

\- Logging to etl.ETL\_ErrorLog



Error Logging

All ETL procedures write errors to etl.ETL\_ErrorLog with:

\- ErrorMessage

\- ErrorTime

\- SourceTable

\- Optional RunID

This provides traceability and supports debugging in production‑like environments.



Validation

After running the ETL, the following checks confirm pipeline integrity.



Row Count Snapshot

SELECT 'DimVehicle', COUNT(\*) FROM dw.DimVehicle

UNION ALL

SELECT 'DimTime', COUNT(\*) FROM dw.DimTime

UNION ALL

SELECT 'DimLocation', COUNT(\*) FROM dw.DimLocation

UNION ALL

SELECT 'FactTelemetry', COUNT(\*) FROM dw.FactTelemetry;



This confirms:

\- Dimensions contain distinct values from staging

\- FactTelemetry only includes rows with resolved foreign keys

\- No duplicate fact rows are inserted



Referential Integrity Check

SELECT TOP 1 VIN, TimestampUTC, City, State, Country

FROM staging.StgTelemetry;



Verify that:

\- VIN exists in DimVehicle

\- Date exists in DimTime

\- Location exists in DimLocation

\- A matching row exists in FactTelemetry





Summary

This project demonstrates a complete data engineering workflow:

\- Dimensional modeling

\- ETL development

\- Error handling

\- Validation

\- Documentation

It is designed to be clear, reproducible, and aligned with real‑world data engineering practices.



