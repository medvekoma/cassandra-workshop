## Primary Key

* PRIMARY KEY is just a notation for PARTITION KEY & CLUSTERING KEY
* PARTITION KEY is mandatory
* CLUSTERING KEY is optional

### Start dockerized Cassandra

**NOTE:** If you already have Cassandra installed, skip this section

```bash
cd cluster

# Start cluster
./01-start.sh

# Log in to node1 shell
./node1-shell.sh
```

### Start pre-installed Cassandra

**NOTE:** Skip this section if you use the dockerized Cassandra

```bash
cd cluster

# Open CQL shell (might need to wait a minute)
cqlsh
```
### Nobel dataset

* CSV file: `cluster/nobel/laureates.csv`
* Create a table that is partitioned by `borncountrycode`

```sql
-- create keyspace
CREATE KEYSPACE nobel
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

-- create table
CREATE TABLE nobel.laureates
(
  laureateid int,
  firstname text,
  surname text,
  borncountrycode text,
  borncity text,
  year int,
  category text,
  PRIMARY KEY (borncountrycode, laureateid)
);

COPY nobel.laureates (year, category, laureateid, firstname, surname, borncountrycode, borncity)
FROM 'nobel/laureates.csv';
```

* Note that we need to add `laureateid` for uniqueness
* Partition key: `borncountrycode`
* Clustering key: `laureateid`


### Query nobel dataset

```sql
USE nobel;

-- efficient, we query by partition key 
SELECT * FROM laureates WHERE borncountrycode = 'HU';
```

### Static column

* Stored once by partition key

```sql
-- add new static column
ALTER TABLE laureates ADD borncountry text static;

-- check table
SELECT * FROM laureates WHERE borncountrycode = 'HU';

-- update column (needs to write a single cell)
UPDATE laureates SET borncountry='Hungary' WHERE borncountrycode='HU';

-- check table
SELECT * FROM laureates WHERE borncountrycode = 'HU';

-- add new record without specifying borncountry
INSERT INTO laureates (borncountrycode , laureateid, category, surname, year) 
VALUES ('HU', 1001, 'Cassandra', 'Óbuda University', 2021);

-- check table
SELECT * FROM laureates WHERE borncountrycode = 'HU';

-- add new record
INSERT INTO laureates (borncountrycode , borncountry, laureateid, category, surname, year) 
VALUES ('HU', 'Magyarország', 1002, 'Cassandra', 'Óbuda University', 2022);
```
