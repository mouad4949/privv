#!/bin/bash

PROJECT_DIR="/home/mouadrguibi/Desktop/privv"
LAST_PUSH_FILE="$PROJECT_DIR/.last_push_date"
TODAY_DATE=$(date +%Y-%m-%d)

if ! ping -c 1 8.8.8.8 &>/dev/null; then
    echo "Pas de connexion WiFi, arrêt du script."
    exit 1
fi

if [ -f "$LAST_PUSH_FILE" ] && grep -q "$TODAY_DATE" "$LAST_PUSH_FILE"; then
    echo "Le push a déjà été fait aujourd'hui, arrêt du script."
    exit 0
fi

cd "$PROJECT_DIR" || exit

echo "Mise à jour du README - $TODAY_DATE" >> README.md

git add README.md
git commit -m "Mise à jour automatique du README - $TODAY_DATE"

git push origin main

echo "$TODAY_DATE" > "$LAST_PUSH_FILE"

echo "Push effectué avec succès à $(date)"
exit 0

