# Lab

We are creating the datastore for the European Traffic Incidents Office. All incidents arrive with the following information

## Fields
* Registration country code
* Registration number
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
CREATE KEYSPACE lab WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};
USE lab;

CREATE TABLE incidents_by_vehicle (
    reg_country text,
    reg_nr text,
    driver_pid text,
    driver_name text,
    incident_time timestamp,
    incident_location text,
    penality_points int,
    PRIMARY KEY ((reg_country, reg_nr), incident_time)
)
WITH CLUSTERING ORDER BY (incident_time DESC);      

SELECT * FROM incidents_by_vehicle 
WHERE 
  reg_country = 'H' AND reg_nr = 'ABC-123'  
  AND incident_time >= '2020-01-01' AND incident_time < '2020-03-01'
ORDER BY incident_time DESC;
```                              

### By Driver

Provide the same list for a driver (identified by Driver PID), sorted by vehicle, then by date and time (newest first).

* Filter by: driver pid
* Sort by: vehicle, incident timestamp (DESC)

```sql
CREATE TABLE incidents_by_driver (
    driver_pid text,
    driver_name text static,
    reg_country text,
    reg_nr text,
    incident_time timestamp,
    incident_location text,
    penality_points int,
    PRIMARY KEY ((driver_pid), reg_country, reg_nr, incident_time)
)
WITH CLUSTERING ORDER BY (reg_country ASC, reg_nr ASC, incident_time DESC);      

SELECT * FROM incidents_by_driver
WHERE 
  driver_pid = 'H-100'; 
```

### Sum penalty points

```sql
SELECT driver_pid, driver_name, SUM(penality_points) AS penality FROM incidents_by_driver  
WHERE driver_pid = 'H-100';
```

## Try with data

From outside the docker container, copy the CSV file into the container

```bash
# copy file into container
docker cp incidents.csv cassandra1:/

# run CLI
./single-cli
```

```bash
cqlsh
```

```sql
USE lab;

COPY incidents_by_vehicle (reg_nr, reg_country, driver_pid, driver_name, incident_time, incident_location, penality_points) 
FROM 'incidents.csv';

COPY incidents_by_driver (reg_nr, reg_country, driver_pid, driver_name, incident_time, incident_location, penality_points) 
FROM 'incidents.csv';
```
