#! /bin/bash

while IFS='' read -r line || [[ -n "$line" ]]; do
 grep -w "$line" $2
done < "$1" 
