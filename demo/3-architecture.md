## Architecture

**NOTE:** This demo only works with the dockerized Cassandra

#### Setup Data

* Table of Nobel Laureates, partitioned by year
* Cassandra Cluster with 3 nodes
* Replication factor of 2

```bash
# Open shell on node1
./node1-shell.sh

# Start CQL shell
cqlsh
```

```sql
-- create keyspace
CREATE KEYSPACE nobel
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 2};

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
  PRIMARY KEY (year, laureateid)
);

-- ingest data from CSV file
COPY nobel.laureates (year, category, laureateid, firstname, surname, borncountrycode, borncity)
FROM '/nobel/laureates.csv';

-- test data
SELECT * FROM nobel.laureates WHERE year = 2010;
```

#### Partitioning and Replication

```bash
# Exit CQL shell (Ctrl+D)

# check cluster status (3 nodes, 3 IP addresses)
nodetool status

# check which node(s) hold the partition
nodetool getendpoints nobel laureates 2010
nodetool getendpoints nobel laureates 2012
nodetool getendpoints nobel laureates 2013

# what happens for a missing partition?
nodetool getendpoints nobel laureates 3000
```

#### Consistency

```bash
# Exit node1 shell (Ctrl+D)

# Kill one of the nodes
docker stop cluster_node2_1

# Open node1 shell
./node1-shell.sh

# Check cluster status
nodetool status

# Open CQL shell
cqlsh
```

```sql
-- Is my cluster operational?
SELECT * FROM nobel.laureates WHERE year = 2010;
SELECT * FROM nobel.laureates WHERE year = 2012;
SELECT * FROM nobel.laureates;
```

#### Tunable Consistency

```sql
-- Let's use higher consistency
CONSISTENCY QUORUM;

-- Is my cluster operational?
SELECT * FROM nobel.laureates WHERE year = 2010;
SELECT * FROM nobel.laureates WHERE year = 2012;
SELECT * FROM nobel.laureates WHERE year = 2013;
```

#### Terminate cluster

```bash
# Exit CQL shell (Ctrl+D)
# Exit node1 shell (Ctrl+D)

# Terminate cluster
./99-stop.sh
```