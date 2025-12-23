#!/bin/sh
set -e

ROOT="$(pwd)"
TMP="$ROOT/tmp"
DOMAINS="$ROOT/domains"
BADGE_DIR="$ROOT/.badges"
MAX=370000

mkdir -p "$TMP" "$DOMAINS" "$BADGE_DIR"
rm -f "$TMP"/*

fetch() {
  NAME="$1"
  URL="$2"
  OUT="$3"

  echo "[+] Fetching $NAME"
  if ! curl -fsSL "$URL" > "$OUT.tmp"; then
    echo "[!] WARNING: failed to fetch $NAME"
    : > "$OUT"
  else
    cat "$OUT.tmp" | "$ROOT/scripts/normalize.sh" > "$OUT"
  fi

  rm -f "$OUT.tmp"
}

echo "[+] Downloading lists"

fetch "CERT.PL" \
  "https://hole.cert.pl/domains/v2/domains.txt" \
  "$TMP/certpl.txt"

fetch "AdAway" \
  "https://adaway.org/hosts.txt" \
  "$TMP/adaway.txt"

fetch "StevenBlack" \
  "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" \
  "$TMP/stevenblack.txt"

fetch "yoyo.org" \
  "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext" \
  "$TMP/yoyo.txt"

fetch "Disconnect tracking" \
  "https://s3.amazonaws.com/lists.disconnect.me/simple_tracking.txt" \
  "$TMP/disconnect_tracking.txt"

fetch "Disconnect malvertising" \
  "https://s3.amazonaws.com/lists.disconnect.me/simple_malvertising.txt" \
  "$TMP/disconnect_malvertising.txt"

echo "[+] Fetching URLhaus"
if ! curl -fsSL https://urlhaus.abuse.ch/downloads/csv_recent/ > "$TMP/urlhaus.csv"; then
  echo "[!] WARNING: failed to fetch URLhaus"
  : > "$TMP/urlhaus.txt"
else
  awk -F',' 'NR>1 {print $3}' "$TMP/urlhaus.csv" \
  | sed 's/"//g' \
  | sed 's|https\?://||' \
  | sed 's|/.*||' \
  | sed 's/:.*//' \
  | "$ROOT/scripts/normalize.sh" \
  > "$TMP/urlhaus.txt"
fi

echo "[+] Building category lists"

sort -u "$TMP/certpl.txt" > "$DOMAINS/certpl.txt"
sort -u "$TMP/adaway.txt" "$TMP/yoyo.txt" > "$DOMAINS/ads.txt"
sort -u "$TMP/disconnect_tracking.txt" > "$DOMAINS/tracking.txt"
sort -u "$TMP/stevenblack.txt" "$TMP/disconnect_malvertising.txt" "$TMP/urlhaus.txt" > "$DOMAINS/malware.txt"

echo "[+] Building profiles"

sort -u \
  "$TMP/certpl.txt" \
  "$TMP/adaway.txt" \
  "$TMP/yoyo.txt" \
  "$TMP/disconnect_tracking.txt" \
  > "$DOMAINS/basic.txt"

sort -u \
  "$DOMAINS/basic.txt" \
  "$TMP/stevenblack.txt" \
  "$TMP/disconnect_malvertising.txt" \
  "$TMP/urlhaus.txt" \
  > "$DOMAINS/full.txt"

sort -u "$DOMAINS/full.txt" > "$DOMAINS/combined.txt"

COUNT=$(wc -l < "$DOMAINS/combined.txt")
[ "$COUNT" -gt "$MAX" ] && {
  echo "[!] ERROR: combined.txt too large ($COUNT > $MAX)"
  exit 1
}

echo "[+] Stats"
wc -l "$DOMAINS/"*.txt

make_badge () {
  FILE="$1"
  LABEL="$2"
  COLOR="$3"
  NAME="$4"

  COUNT=$(wc -l < "$FILE" | tr -d ' ')

  cat > "$BADGE_DIR/$NAME.json" <<EOF
{
  "schemaVersion": 1,
  "label": "$LABEL",
  "message": "$COUNT",
  "color": "$COLOR"
}
EOF
}

echo "[+] Updating badges"

make_badge "$DOMAINS/ads.txt"        "ads"        "orange" "ads_domains"
make_badge "$DOMAINS/tracking.txt"   "tracking"   "yellow" "tracking_domains"
make_badge "$DOMAINS/malware.txt"    "malware"    "red"    "malware_domains"
make_badge "$DOMAINS/certpl.txt"     "cert.pl"    "blue"   "certpl_domains"
make_badge "$DOMAINS/basic.txt"      "basic"      "green"  "basic_domains"
make_badge "$DOMAINS/full.txt"       "full"       "green_
