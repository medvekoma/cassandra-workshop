#!/bin/bash

COMMAND=${@-bash}

docker exec -it cluster_node1_1 ${COMMAND}
