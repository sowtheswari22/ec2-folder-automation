#!/bin/bash

OUTPUT_FILE="/opt/hello_world.txt"

echo "Hello World from Jenkins " > $OUTPUT_FILE
date >> $OUTPUT_FILE
