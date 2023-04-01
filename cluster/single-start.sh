#!/bin/bash

docker run -d --name cassandra1 -v $PWD/nobel:/nobel cassandra:4.0.1
