#!/bin/sh
set -e

ROOT="$(pwd)"
TMP="$ROOT/tmp"
DOMAINS="$ROOT/domains"

mkdir -p "$TMP" "$DOMAINS"
rm -f "$TMP"/*

echo "[+] Fetching CERT.PL"
curl -sSL https://hole.cert.pl/domains/v2/domains.txt \
| "$ROOT/scripts/normalize.sh" \
> "$TMP/certpl.txt"

echo "[+] Fetching URLhaus (malware domains)"
curl -sSL https://urlhaus.abuse.ch/downloads/csv_recent/ \
| awk -F',' 'NR>1 {print $3}' \
| sed 's/"//g' \
| sed 's|https\?://||' \
| sed 's|/.*||' \
| "$ROOT/scripts/normalize.sh" \
> "$TMP/urlhaus.txt"

echo "[+] Fetching AdAway"
curl -sSL https://adaway.org/hosts.txt \
| "$ROOT/scripts/normalize.sh" \
> "$TMP/adaway.txt"

echo "[+] Fetching StevenBlack"
curl -sSL https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts \
| "$ROOT/scripts/normalize.sh" \
> "$TMP/stevenblack.txt"

echo "[+] Fetching yoyo.org"
curl -sSL "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext" \
| "$ROOT/scripts/normalize.sh" \
> "$TMP/yoyo.txt"

echo "[+] Fetching Disconnect tracking"
curl -sSL https://s3.amazonaws.com/lists.disconnect.me/simple_tracking.txt \
| "$ROOT/scripts/normalize.sh" \
> "$TMP/disconnect_tracking.txt"

echo "[+] Fetching Disconnect malvertising"
curl -sSL https://s3.amazonaws.com/lists.disconnect.me/simple_malvertising.txt \
| "$ROOT/scripts/normalize.sh" \
> "$TMP/disconnect_malvertising.txt"

echo "[+] Building category lists"

cat "$TMP/certpl.txt" \
| sort -u > "$DOMAINS/certpl.txt"

cat "$TMP/adaway.txt" "$TMP/yoyo.txt" \
| sort -u > "$DOMAINS/ads.txt"

cat "$TMP/disconnect_tracking.txt" \
| sort -u > "$DOMAINS/tracking.txt"

cat "$TMP/stevenblack.txt" "$TMP/disconnect_malvertising.txt" \
| sort -u > "$DOMAINS/malware.txt"

echo "[+] Building combined list"

cat "$DOMAINS/"*.txt \
| sort -u > "$DOMAINS/combined.txt"

echo "[+] Stats:"
wc -l "$DOMAINS/"*.txt

