#!/bin/bash
# awøken⸸vails – gotische Fuzzy-Clock für Waybar
#
# Wörter:   skøl  = volle Stunde · vīk  = viertel · mīrd = halb · abýss = dreiviertel
# Perioden: uþwø = a.m. · mýrk = p.m.
#
# Wie im Deutschen ("viertel elf", "halb neun", "dreiviertel elf") beziehen sich
# IMMER auf die KOMMENDE Stunde, nur skål auf die aktuelle
# bzw. gerade erreichte Stunde. Das war der Bug in der Vorversion: dort wurde
# immer die aktuelle Stunde ausgegeben (22:16 -> "ten" statt korrekt "eleven").
# 10# erzwingt Dezimal-Interpretation, sonst wertet Bash "08"/"09" als
# ungültige Oktalzahl und bricht mit einem Fehler ab.
H=$((10#$(date +%H)))   # 0-23
M=$((10#$(date +%M)))   # 0-59
numbers=(zérø øné twø þréé føúr fīvé sīx sævén éīght nīné tén élévøn twélv)
# Minuten-Zone bestimmen (auf- bzw. abgerundet aufs nächste Viertel)
if   [ "$M" -ge 53 ]; then WORD="skøl";     TARGET=$((H + 1))
elif [ "$M" -ge 38 ]; then WORD="abýss";    TARGET=$((H + 1))
elif [ "$M" -ge 23 ]; then WORD="mīrd";     TARGET=$((H + 1))
elif [ "$M" -ge 8  ]; then WORD="vīk";      TARGET=$((H + 1))
else                       WORD="skøl";     TARGET=$H
fi
TARGET=$((TARGET % 24))                         # Mitternachts-Wrap (23:55 -> 0)
if [ "$TARGET" -lt 12 ]; then 
  PERIOD="<span foreground='#d4af37'>uþwø</span>" 
else 
  PERIOD="<span foreground='#d4af37'>mýrk</span>" 
fi
H12=$((TARGET % 12))
[ "$H12" -eq 0 ] && H12=12
echo "$WORD $PERIOD ${numbers[$H12]}"

