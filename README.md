# Tools used in the demo

## Manage Cassandra Cluster

This folder contains the dockerized environment.

```bash
# Create a two node Cassandra cluster (3.11)
./01-start.sh 

# Destroy cluster
./99-stop.sh

# Log in to node1
./node1-shell.sh

# Execute command on node1 (for example `nodetool status`)
./node1-shell.sh nodetool status
```

## Cassandra tools

| Tool | Description |
|------|-------------|
|cqlsh | CQL Shell. Command line interface to Cassandra. |
|nodetool| Admin Tool (Cluster management) |
