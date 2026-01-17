Hypercar Data Engineering Platform

Full Enterprise ERD (Final Architecture)

This document contains the complete end‑state Entity Relationship Diagram (ERD) for the Hypercar Data Engineering Platform, including all dimension tables, fact tables, staging tables, ERP simulation tables, telemetry tables, and ETL logging structures.



Data Warehouse Layer — Dimensions

---------------------------------

dw.DimVehicle

\- VehicleKey (PK)

\- VIN

\- Make

\- Model

\- Year

\- BatteryCapacity

\- MotorType



dw.DimTime

\- TimeKey (PK)

\- FullDate

\- Year

\- Quarter

\- Month

\- Day

\- DayOfWeek

\- Hour

\- Minute



dw.DimLocation

\- LocationKey (PK)

\- Latitude

\- Longitude

\- City

\- State

\- Country



dw.DimSupplier

\- SupplierKey (PK)

\- SupplierID

\- SupplierName

\- Country

\- Rating



dw.DimPart

\- PartKey (PK)

\- PartID

\- PartName

\- Category

\- Cost



dw.DimWorkCenter

\- WorkCenterKey (PK)

\- WorkCenterID

\- Description

\- Department



Data Warehouse Layer — Fact Tables

----------------------------------

dw.FactTelemetry

\- TelemetryKey (PK)

\- VehicleKey (FK)

\- TimeKey (FK)

\- LocationKey (FK)

\- Speed

\- Torque

\- SOC

\- Temperature

\- Latitude

\- Longitude



dw.FactWorkOrder

\- WorkOrderFactKey (PK)

\- WorkOrderID

\- VehicleKey (FK)

\- PartKey (FK)

\- WorkCenterKey (FK)

\- TimeKey (FK)

\- QuantityUsed

\- LaborHours

\- Cost



dw.FactInventoryMovement

\- InventoryFactKey (PK)

\- PartKey (FK)

\- SupplierKey (FK)

\- TimeKey (FK)

\- MovementType

\- Quantity

\- UnitCost



ERP Simulation Layer (Operational)

----------------------------------

erp.Inventory

\- InventoryID (PK)

\- PartID

\- QuantityOnHand

\- Location



erp.BOM

\- BOMID (PK)

\- ParentPartID

\- ChildPartID

\- QuantityRequired



erp.WorkOrders

\- WorkOrderID (PK)

\- VehicleID

\- PartID

\- WorkCenterID

\- StartTime

\- EndTime

\- Status



erp.Suppliers

\- SupplierID (PK)

\- SupplierName

\- Country

\- Rating



Telemetry Simulation Layer (Operational)

----------------------------------------

telemetry.RawTelemetry

\- RawID (PK)

\- VIN

\- Timestamp

\- Speed

\- Torque

\- SOC

\- Temperature

\- Latitude

\- Longitude



Staging Layer

-------------

staging.StgVehicle

\- VIN

\- Make

\- Model

\- Year

\- BatteryCapacity

\- MotorType



staging.StgTelemetry

\- VIN

\- Timestamp

\- Speed

\- Torque

\- SOC

\- Temperature

\- Latitude

\- Longitude



staging.StgLocation

\- Latitude

\- Longitude

\- City

\- State

\- Country



ETL Layer

---------

etl.ETL\_RunLog

\- RunID (PK)

\- PipelineName

\- StartTime

\- EndTime

\- Status

\- RowsInserted



etl.ETL\_ErrorLog

\- ErrorID (PK)

\- RunID

\- ErrorMessage

\- ErrorTime

\- SourceTable



ERD Diagram

-----------

&nbsp;                        +------------------+

&nbsp;                        |   dw.DimVehicle  |

&nbsp;                        |------------------|

&nbsp;                        | VehicleKey (PK)  |

&nbsp;                        | VIN              |

&nbsp;                        | Make             |

&nbsp;                        | Model            |

&nbsp;                        | Year             |

&nbsp;                        +---------+--------+

&nbsp;                                  |

&nbsp;                                  |

&nbsp;                        +---------v---------+

&nbsp;                        |  dw.FactTelemetry |

&nbsp;                        |-------------------|

&nbsp;                        | TelemetryKey (PK) |

&nbsp;                        | VehicleKey (FK)   |

&nbsp;                        | TimeKey (FK)      |

&nbsp;                        | LocationKey (FK)  |

&nbsp;                        | Speed             |

&nbsp;                        | Torque            |

&nbsp;                        | SOC               |

&nbsp;                        | Temperature       |

&nbsp;                        +---------+---------+

&nbsp;                                  |

&nbsp;       +--------------------------+---------------------------+

&nbsp;       |                                                          |

+-------v--------+                                      +---------v--------+

|  dw.DimTime    |                                      | dw.DimLocation   |

|----------------|                                      |------------------|

| TimeKey (PK)   |                                      | LocationKey (PK) |

| FullDate       |                                      | Latitude         |

| Year           |                                      | Longitude        |

| Month          |                                      | City             |

| Day            |                                      | State            |

+----------------+                                      +------------------+





&nbsp;                        +-----------------------+

&nbsp;                        |   dw.FactWorkOrder    |

&nbsp;                        |-----------------------|

&nbsp;                        | WorkOrderFactKey (PK) |

&nbsp;                        | VehicleKey (FK)       |

&nbsp;                        | PartKey (FK)          |

&nbsp;                        | WorkCenterKey (FK)    |

&nbsp;                        | TimeKey (FK)          |

&nbsp;                        +-----------+-----------+

&nbsp;                                    |

&nbsp;       +----------------------------+-----------------------------+

&nbsp;       |                            |                             |

+-------v--------+        +----------v----------+        +---------v---------+

| dw.DimVehicle  |        |    dw.DimPart       |        | dw.DimWorkCenter  |

+----------------+        +----------------------+        +-------------------+





&nbsp;                        +-----------------------------+

&nbsp;                        | dw.FactInventoryMovement    |

&nbsp;                        |-----------------------------|

&nbsp;                        | InventoryFactKey (PK)       |

&nbsp;                        | PartKey (FK)                |

&nbsp;                        | SupplierKey (FK)            |

&nbsp;                        | TimeKey (FK)                |

&nbsp;                        +--------------+--------------+

&nbsp;                                       |

&nbsp;       +-------------------------------+------------------------------+

&nbsp;       |                               |                              |

+-------v--------+            +----------v----------+         +---------v---------+

|  dw.DimPart    |            |  dw.DimSupplier     |         |   dw.DimTime      |

+----------------+            +----------------------+         +-------------------+





&nbsp;                    (ERP Operational Layer)

+------------------+     +------------------+     +------------------+

|  erp.Inventory   |     |   erp.BOM        |     | erp.WorkOrders   |

+------------------+     +------------------+     +------------------+

| InventoryID (PK) |     | BOMID (PK)       |     | WorkOrderID (PK) |

| PartID           |     | ParentPartID     |     | VehicleID        |

| QuantityOnHand   |     | ChildPartID      |     | PartID           |

+------------------+     +------------------+     +------------------+





&nbsp;                    (Telemetry Operational Layer)

+------------------------+

| telemetry.RawTelemetry |

+------------------------+

| RawID (PK)             |

| VIN                    |

| Timestamp              |

| Speed                  |

| Torque                 |

| SOC                    |

+------------------------+

# 

# 



