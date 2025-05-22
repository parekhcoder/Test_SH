#!/bin/bash

# Ensure the log directory exists
LOG_DIR="/app/log"
mkdir -p "$LOG_DIR"

# Get the current year and month
YEAR=$(date +%Y)
MONTH=$(date +%m)

# Get the pod name (using environment variable set in Kubernetes)
POD_NAME=${MY_POD_NAME:-$(hostname)}  # Fallback to hostname if MY_POD_NAME is not set

# Define the log file name
LOG_FILE="$LOG_DIR/${YEAR}_${MONTH}_${POD_NAME}.log"

# Function to log messages to both file and console
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') $1" | tee -a "$LOG_FILE"
}

if [ "$(date +%d)" = "01" ]; then
  # Calculate the date two months ago
  TWO_MONTHS_AGO=$(date -d "2 months ago" +%Y_%m)
  # Delete files not matching current or previous month
  find "$LOG_DIR" -type f -name "*.log" ! -name "${YEAR}_${MONTH}_*.log" ! -name "$(date -d '1 month ago' +%Y_%m)_*.log" -exec rm -f {} \; || log_message "Error deleting old log files"
fi

# Example usage in your script
log_message "Starting the script"
# Your existing script logic here
log_message "Processing step 1"
sleep 2
log_message "Processing step 2"
log_message "Script completed"
tail -f /dev/null
