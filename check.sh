#!/bin/bash

if [ -f ${1} ]; then
    exit 0
else
    echo "File not found: ${1}"
    exit 2
fi
