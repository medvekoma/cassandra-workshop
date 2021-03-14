# Lab

We are creating the datastore for the European Traffic Incidents Office. All incidents arrive with the following information

## Fields
* Registration number
* Registration country code
* Driver PID
* Driver name
* Incident's date and time
* Incident’s location
* Penalty points (if any)

## Queries

### By Vehicle

Provide a list of incidents of a vehicle for a specific date range, sorted by incident's date and time (newest first).

* Filter by: Vehicle & incident timestamp
* Sort by: incident timestamp

```sql
CREATE KEYSPACE lab WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 2};

CREATE TABLE incidents_by_vehicle (
    registration_nr text,
    registration_country text,
    driver_pid bigint,
    driver_name text,
    incident_timestamp timestamp,
    incident_location text,
    penality_points int,
    PRIMARY KEY ((registration_nr, registration_country), incident_timestamp)
)
WITH CLUSTERING ORDER BY (incident_timestamp DESC);      

SELECT * FROM incidents_by_vehicle 
WHERE 
  registration_nr = 'ABC-123' AND registration_country = 'H' 
  AND incident_timestamp >= '2020-01-01' AND incident_timestamp < '2020-03-01';
```                              

### By Vehicle

Provide the same list for a driver (identified by Driver PID), sorted by vehicle, then by date and time (newest first).

* Filter by: driver pid
* Sort by: vehicle, incident timestamp (DESC)

```sql
CREATE TABLE incidents_by_driver (
    registration_nr text,
    registration_country text,
    driver_pid bigint,
    driver_name text,
    incident_timestamp timestamp,
    incident_location text,
    penality_points int,
    PRIMARY KEY ((driver_pid), registration_country, registration_nr, incident_timestamp)
)
WITH CLUSTERING ORDER BY (registration_country ASC, registration_nr ASC, incident_timestamp DESC);      

SELECT * FROM incidents_by_driver
WHERE 
  driver_pid = 100; 
```

### Sum penalty points

```sql
SELECT driver_pid, driver_name, SUM(penality_points) AS penality FROM incidents_by_driver  
WHERE driver_pid = 100;
```

## Try with data

```bash
docker cp incidents.csv cluster_node1_1:.
../cluster/node1-shell.sh
cqlsh
```

```sql
USE lab;

COPY incidents_by_vehicle (registration_nr, registration_country, driver_pid, driver_name, incident_timestamp, incident_location, penality_points) 
FROM 'incidents.csv';

COPY incidents_by_driver (registration_nr, registration_country, driver_pid, driver_name, incident_timestamp, incident_location, penality_points) 
FROM 'incidents.csv';
```
