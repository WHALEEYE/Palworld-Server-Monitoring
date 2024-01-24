#!/bin/bash

# Service name
SERVICE="palw.service"

# Maximum allowed memory in KB (15 GB in KB)
MAX_MEMORY=$((15 * 1024 * 1024))

# Log file path
LOG_FILE="/home/steam/logs/monitor.log"

# Get the current time
CURRENT_TIME=$(date '+%Y-%m-%d %H:%M:%S')

# Check if the service is running
if ! systemctl is-active --quiet $SERVICE; then
    echo "$CURRENT_TIME: The service $SERVICE is not running. Starting the service." >> $LOG_FILE
    systemctl start $SERVICE
    echo "$CURRENT_TIME: The service $SERVICE has been started. Exiting script." >> $LOG_FILE
    exit 0
fi

# Get the total memory usage of the service in KB
MEMORY_USAGE=$(ps -C PalServer-Linux -o rss= | awk '{sum+=$1} END {print sum}')

# Check if memory usage exceeds the limit
if [ "$MEMORY_USAGE" -gt "$MAX_MEMORY" ]; then
    echo "$CURRENT_TIME: Memory limit exceeded (Limit: $MAX_MEMORY KB, Used: $MEMORY_USAGE KB). Restarting the service." >> $LOG_FILE
    systemctl restart $SERVICE
fi
