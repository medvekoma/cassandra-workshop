# Tools used in the demo

## Cassandra tools

| Tool | Description |
|------|-------------|
|cqlsh | CQL Shell. Command line interface to Cassandra. |
|nodetool| Admin Tool (Cluster management) |

## Dockerized environment

The [cluster](cluster) folder contains the scripts that can be used to set up a
3-node cluster in a dockerized environment. It can be used on any computer that has
docker installed.

```bash
# Create a 3-node Cassandra cluster (4.0.1)
./cluster-start.sh 

# Destroy cluster
./cluster-stop.sh

# Log in to node1
./cluster-cli.sh

# Execute command on node1 (for example `nodetool status`)
./cluster-cli.sh nodetool status
```

The folder also has scripts for running a single-node Cassandra cluster: 

```bash
# Create a 3-node Cassandra cluster (4.0.1)
./single-start.sh 

# Destroy cluster
./single-stop.sh

# Log in to node1
./single-cli.sh

# Execute command on node1 (for example `nodetool status`)
./single-cli.sh nodetool status
```
