#!/bin/sh
set -e

sed 's/\r//g' \
| sed 's/#.*$//' \
| awk '{print $1, $2}' \
| awk '
  {
    if ($2 ~ /^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/) print $2;
    else if ($1 ~ /^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/) print $1;
  }
' \
| tr 'A-Z' 'a-z'
