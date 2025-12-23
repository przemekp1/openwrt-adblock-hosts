#!/bin/sh
# Normalize to plain <DOMAIN>
set -e

sed 's/\r//g' \
| sed 's/^0\.0\.0\.0[[:space:]]*//g' \
| sed 's/^127\.0\.0\.1[[:space:]]*//g' \
| sed 's/^::1[[:space:]]*//g' \
| grep -E '^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' \
| tr 'A-Z' 'a-z'
