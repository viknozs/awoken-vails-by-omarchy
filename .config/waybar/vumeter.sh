#!/bin/bash

if ! command -v cava >/dev/null 2>&1; then
  echo ""
  exit 0
fi

CAVA_CFG="/tmp/waybar-vumeter-cava.conf"
cat > "$CAVA_CFG" << 'C_EOF'
[general]
bars = 6
framerate = 30

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
ascii_source_custom = 0,1,2,3,4,5,6,7
C_EOF

BAR_CHARS=" ▂▃▄▅▆▇█"

cava -p "$CAVA_CFG" | while IFS= read -r line; do
  out=""
  IFS=';' read -ra ADDR <<< "$line"
  for val in "${ADDR[@]}"; do
    if [[ "$val" =~ ^[0-7]$ ]]; then
      out="${out}${BAR_CHARS:$val:1}"
    fi
  done
  echo "$out"
done

