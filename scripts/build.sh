#!/bin/sh
set -e

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

ROOT="$(pwd)"
TMP="$ROOT/tmp"
DOMAINS="$ROOT/domains"
MAX=370000

mkdir -p "$TMP" "$DOMAINS"
rm -f "$TMP"/*

echo "[+] Fetching CERT.PL"
curl -fsSL https://hole.cert.pl/domains/v2/domains.txt \
| "$ROOT/scripts/normalize.sh" \
> "$TMP/certpl.txt"

echo "[+] Fetching URLhaus (malware domains)"
curl -fsSL https://urlhaus.abuse.ch/downloads/csv_recent/ \
| awk -F',' 'NR>1 {print $3}' \
| sed 's/"//g' \
| sed 's|https\?://||' \
| sed 's|/.*||' \
| "$ROOT/scripts/normalize.sh" \
> "$TMP/urlhaus.txt"

echo "[+] Fetching AdAway"
curl -fsSL https://adaway.org/hosts.txt \
| "$ROOT/scripts/normalize.sh" \
> "$TMP/adaway.txt"

echo "[+] Fetching StevenBlack"
curl -fsSL https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts \
| "$ROOT/scripts/normalize.sh" \
> "$TMP/stevenblack.txt"

echo "[+] Fetching yoyo.org"
curl -fsSL "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext" \
| "$ROOT/scripts/normalize.sh" \
> "$TMP/yoyo.txt"

echo "[+] Fetching Disconnect tracking"
curl -fsSL https://s3.amazonaws.com/lists.disconnect.me/simple_tracking.txt \
| "$ROOT/scripts/normalize.sh" \
> "$TMP/disconnect_tracking.txt"

echo "[+] Fetching Disconnect malvertising"
curl -fsSL https://s3.amazonaws.com/lists.disconnect.me/simple_malvertising.txt \
| "$ROOT/scripts/normalize.sh" \
> "$TMP/disconnect_malvertising.txt"

echo "[+] Building category lists"
cat "$TMP/certpl.txt" | sort -u > "$DOMAINS/certpl.txt"
cat "$TMP/adaway.txt" "$TMP/yoyo.txt" | sort -u > "$DOMAINS/ads.txt"
cat "$TMP/disconnect_tracking.txt" | sort -u > "$DOMAINS/tracking.txt"
cat "$TMP/stevenblack.txt" "$TMP/disconnect_malvertising.txt" "$TMP/urlhaus.txt" | sort -u > "$DOMAINS/malware.txt"

echo "[+] Building profile lists"

# Basic list - kluczowe kategorie
cat "$TMP/certpl.txt" "$TMP/adaway.txt" "$TMP/yoyo.txt" "$TMP/disconnect_tracking.txt" \
| sort -u > "$DOMAINS/basic.txt"

# Full list - większa lista bezpieczeństwa i trackery
cat "$DOMAINS/basic.txt" "$TMP/stevenblack.txt" "$TMP/disconnect_malvertising.txt" "$TMP/urlhaus.txt" \
| sort -u > "$DOMAINS/full.txt"

# Combined list
cat "$DOMAINS/full.txt" | sort -u > "$DOMAINS/combined.txt"

# Hard limit check
COUNT=$(wc -l < "$DOMAINS/combined.txt")
if [ "$COUNT" -gt "$MAX" ]; then
  echo "[!] ERROR: combined.txt too large: $COUNT domains (limit $MAX)"
  exit 1
fi

echo "[+] Stats:"
wc -l "$DOMAINS/"*.txt

# Update badges
BADGE_DIR="$ROOT/.badges"
mkdir -p "$BADGE_DIR"

COMBINED_COUNT=$(wc -l < "$DOMAINS/combined.txt" | tr -d ' ')
cat > "$BADGE_DIR/domains.json" <<EOF
{
  "schemaVersion": 1,
  "label": "domains",
  "message": "$COMBINED_COUNT",
  "color": "blue"
}
EOF

FULL_COUNT=$(wc -l < "$DOMAINS/full.txt" | tr -d ' ')
cat > "$BADGE_DIR/full_domains.json" <<EOF
{
  "schemaVersion": 1,
  "label": "full domains",
  "message": "$FULL_COUNT",
  "color": "green"
}
EOF
