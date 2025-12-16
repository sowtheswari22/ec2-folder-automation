#!/bin/bash

OUTPUT_FILE="/opt/hello_world.txt"

echo "HELLO WORLD FROM JENKINS AUTOMATION" > $OUTPUT_FILE
date >> $OUTPUT_FILE
