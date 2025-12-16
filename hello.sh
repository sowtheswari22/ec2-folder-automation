#!/bin/bash

OUTPUT_FILE="/opt/hello_world.txt"

echo "HELLO WORLD from Jenkins Automation" > $OUTPUT_FILE
date >> $OUTPUT_FILE
