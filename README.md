# Tools used in the demo

## Cassandra tools

| Tool | Description |
|------|-------------|
|cqlsh | CQL Shell. Command line interface to Cassandra. |
|nodetool| Admin Tool (Cluster management) |

## Virtual machine

The virtual machine has Cassandra installed, both tools are available out of the box. 
No further configuration is needed
## Dockerized environment

The [cluster](cluster) folder contains the scripts that can be used to set up a
3-node cluster in a dockerized environment. It can be used on any computer that has
docker installed.

**NOTE:** Don't use it inside the virtual machine. It doesn't have docker installed.

```bash
# Create a 3-node Cassandra cluster (3.11)
./01-start.sh 

# Destroy cluster
./99-stop.sh

# Log in to node1
./node1-shell.sh

# Execute command on node1 (for example `nodetool status`)
./node1-shell.sh nodetool status
```
