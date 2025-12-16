#!/bin/bash

OUTPUT_FILE="/opt/hello_world.txt"

echo "Hello WORLD from Jenkins Automation" > $OUTPUT_FILE
date >> $OUTPUT_FILE
