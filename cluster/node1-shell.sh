#!/bin/bash

COMMAND=${@-bash}

docker exec -it cluster-node1-1 ${COMMAND}
