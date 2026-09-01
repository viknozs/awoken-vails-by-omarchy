#!/bin/bash
# awøken⸸vails – gotische Fuzzy-Clock für Waybar
#
# Wörter:   skål = volle Stunde · førsåken = viertel · nørth = halb · åbýss = dreiviertel
# Perioden: uhtwø = a.m. · mýrkr = p.m.
#
# Wie im Deutschen ("viertel elf", "halb neun", "dreiviertel elf") beziehen sich
# førsåken/nørth/åbýss IMMER auf die KOMMENDE Stunde, nur skål auf die aktuelle
# bzw. gerade erreichte Stunde. Das war der Bug in der Vorversion: dort wurde
# immer die aktuelle Stunde ausgegeben (22:16 -> "ten" statt korrekt "eleven").

# 10# erzwingt Dezimal-Interpretation, sonst wertet Bash "08"/"09" als
# ungültige Oktalzahl und bricht mit einem Fehler ab.
H=$((10#$(date +%H)))   # 0-23
M=$((10#$(date +%M)))   # 0-59

numbers=(zero one two three four five six seven eight nine ten eleven twelve)

# Minuten-Zone bestimmen (auf- bzw. abgerundet aufs nächste Viertel)
if   [ "$M" -ge 53 ]; then WORD="skål";     TARGET=$((H + 1))
elif [ "$M" -ge 38 ]; then WORD="åbýss";    TARGET=$((H + 1))
elif [ "$M" -ge 23 ]; then WORD="nørth";    TARGET=$((H + 1))
elif [ "$M" -ge 8  ]; then WORD="førsåken"; TARGET=$((H + 1))
else                       WORD="skål";     TARGET=$H
fi

TARGET=$((TARGET % 24))                        # Mitternachts-Wrap (23:55 -> 0)
if [ "$TARGET" -lt 12 ]; then PERIOD="uhtwø"; else PERIOD="mýrkr"; fi

H12=$((TARGET % 12))
[ "$H12" -eq 0 ] && H12=12

echo "$WORD $PERIOD ${numbers[$H12]}"
