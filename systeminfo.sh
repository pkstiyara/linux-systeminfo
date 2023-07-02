#!/bin/bash

# Function to retrieve system information
get_system_info() {
  echo "System Information:"
  echo "==================="
  echo "Hostname: $(hostname)"
  echo "Kernel Version: $(uname -r)"
  echo "Operating System: $(cat /etc/*release | grep -oP '(?<=PRETTY_NAME=").*?(?=")')"
  echo "CPU: $(grep 'model name' /proc/cpuinfo | uniq | awk -F ':' '{print $2}' | xargs)"
  echo "Memory: $(grep 'MemTotal' /proc/meminfo | awk '{print $2/1024/1024 " GB"}')"
  
  disk_usage=$(df -h / | awk 'NR==2{print $5}')
  total_disk=$(df -h / | awk 'NR==2{print $2}')
  used_disk=$(df -h / | awk 'NR==2{print $3}')
  available_disk=$(df -h / | awk 'NR==2{print $4}')
  
  echo "Disk Usage: $disk_usage ($used_disk used, $available_disk available out of $total_disk)"
  
  echo "Uptime: $(uptime -p)"
  echo "Users Logged In: $(who | wc -l)"
  echo "Processes Running: $(ps -e --no-header | wc -l)"
}

# Call the function
get_system_info
