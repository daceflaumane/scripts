#!/bin/bash

# Path to the input file
input_file="io_files/notify_list.txt"
# Path to the output file
output_file="io_files/netname_descr.txt"

# Initialize the output file (clear if exists)
> "$output_file"

# Variable to keep track of the current company name
current_company=""

# Read the input file line by line
while IFS= read -r line
do
    # Check if the line contains an IP address
    if [[ "$line" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        # Perform whois lookup and extract netname and descr
        echo "IP: $line" >> "$output_file"
        whois "$line" | grep -E 'netname:|descr:' >> "$output_file"
        echo "" >> "$output_file"
    else
        # Not an IP, so it must be a company name
        current_company="$line"
        echo "$current_company" >> "$output_file"
    fi
done < "$input_file"
