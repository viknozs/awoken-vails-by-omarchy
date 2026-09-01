#!/bin/bash

# Aktuelle Stunde im 12-Stunden-Format (1-12)
HOUR=$(date +%I | sed 's/^0//')
MIN=$(date +%M)
AMPM=$(date +%p)

# AM/PM → uhtwø / mýrkr
[ "$AMPM" = "AM" ] && PERIOD="uhtwø" || PERIOD="mýrkr"

# Zahlen in Worte
numbers=(zero one two three four five six seven eight nine ten eleven twelve)
NUM_WORD=${numbers[HOUR]}

# Zeitwörter
if [ $MIN -ge 53 ]; then
    WORD="skål"
elif [ $MIN -ge 38 ]; then
    WORD="åbýss"
elif [ $MIN -ge 23 ]; then
    WORD="nørth"
elif [ $MIN -ge 8 ]; then
    WORD="førsåken"
else
    WORD="skål"
fi

echo "$WORD $PERIOD $NUM_WORD"
