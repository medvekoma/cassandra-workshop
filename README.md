# Tools used in the demo

## cluster

This folder contains the dockerized environment.

```bash
# Create a two node Cassandra cluster (3.11)
./01-start.sh 

# Create a three node Cassandra cluster (3.11)
./01-start.sh

# Destroy cluster
./99-stop.sh

# Log in to node1
./node-shell.sh
```

| Tool | Description |
|------|-------------|
|cqlsh | CQL Shell. Command line interface to Cassandra. |
|nodetool| Admin Tool (Cluster management) |
