#!/bin/bash

COMMAND=${@-bash}

docker exec -it cassandra1 ${COMMAND}
