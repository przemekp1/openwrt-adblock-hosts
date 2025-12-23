#!/bin/sh
set -e

ROOT="$(pwd)"
TMP="$ROOT/tmp"
DOMAINS="$ROOT/domains"
BADGE_DIR="$ROOT/.badges"
MAX=1000000   # zwiększamy limit, bo duża lista

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
    echo "[*] $NAME count after normalization: $(wc -l < "$OUT")"
  fi
  rm -f "$OUT.tmp"
}

echo "[+] Downloading lists"

# CERT.PL
fetch "CERT.PL" \
  "https://hole.cert.pl/domains/v2/domains.txt" \
  "$TMP/certpl.txt"

# AdAway
fetch "AdAway" \
  "https://adaway.org/hosts.txt" \
  "$TMP/adaway.txt"

# yoyo.org
fetch "yoyo.org" \
  "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext" \
  "$TMP/yoyo.txt"

# Disconnect
fetch "Disconnect tracking" \
  "https://s3.amazonaws.com/lists.disconnect.me/simple_tracking.txt" \
  "$TMP/disconnect_tracking.txt"

fetch "Disconnect malvertising" \
  "https://s3.amazonaws.com/lists.disconnect.me/simple_malvertising.txt" \
  "$TMP/disconnect_malvertising.txt"

# URLhaus
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

# StevenBlack (3 warianty)
fetch "StevenBlack Standard" \
  "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" \
  "$TMP/stevenblack_standard.txt"

fetch "StevenBlack Porn" \
  "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/porn/hosts" \
  "$TMP/stevenblack_porn.txt"

fetch "StevenBlack FakeNews" \
  "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews/hosts" \
  "$TMP/stevenblack_fakenews.txt"

# OISD (DNS, list1)
fetch "OISD Full" \
  "https://abp.oisd.nl/basic/" \
  "$TMP/oisd.txt"

# EasyList
fetch "EasyList" \
  "https://easylist.to/easylist/easylist.txt" \
  "$TMP/easylist.txt"

# AdGuard DNS filter
fetch "AdGuard" \
  "https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt" \
  "$TMP/adguard.txt"

echo "[+] Building full_combined list"

sort -u \
  "$TMP/certpl.txt" \
  "$TMP/adaway.txt" \
  "$TMP/yoyo.txt" \
  "$TMP/disconnect_tracking.txt" \
  "$TMP/disconnect_malvertising.txt" \
  "$TMP/urlhaus.txt" \
  "$TMP/stevenblack_standard.txt" \
  "$TMP/stevenblack_porn.txt" \
  "$TMP/stevenblack_fakenews.txt" \
  "$TMP/oisd.txt" \
  "$TMP/easylist.txt" \
  "$TMP/adguard.txt" \
  > "$DOMAINS/full_combined.txt"

COUNT=$(wc -l < "$DOMAINS/full_combined.txt")
[ "$COUNT" -gt "$MAX" ] && {
  echo "[!] ERROR: full_combined.txt too large ($COUNT > $MAX)"
  exit 1
}

echo "[+] Stats"
wc -l "$DOMAINS/full_combined.txt"

echo "[+] Generating badge"
cat > "$BADGE_DIR/full_combined.json" <<EOF
{
  "schemaVersion": 1,
  "label": "full_combined",
  "message": "$COUNT",
  "color": "blue"
}
EOF

echo "[+] Done ✅ full_combined.txt + badge ready"
