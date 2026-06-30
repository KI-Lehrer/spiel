#!/bin/bash
# Spiele-Portal Sync-Skript für macOS / Linux
echo "============================================="
echo "=== Spiele-Portal Synchronisation (macOS) ==="
echo "============================================="
echo ""

# 1. Neueste Änderungen herunterladen
echo "1. Lade neueste Änderungen von GitHub herunter (git pull)..."
git pull
if [ $? -ne 0 ]; then
    echo "Fehler beim Herunterladen der Änderungen von GitHub."
    echo "Bitte überprüfe deine Internetverbindung oder Git-Berechtigungen."
    read -n 1 -s -p "Drücke eine beliebige Taste zum Beenden..."
    exit 1
fi
echo "Erfolgreich aktualisiert!"
echo ""

# 2. Lokale Änderungen speichern
echo "2. Suche nach neuen oder geänderten Spielen..."
git add .

# Prüfen, ob Änderungen vorhanden sind
if git diff-index --quiet HEAD --; then
    echo "Keine neuen Änderungen zum Speichern vorhanden."
else
    echo "Änderungen gefunden! Speichere lokale Änderungen (git commit)..."
    git commit -m "Update von $(date '+%d.%m.%Y %H:%M:%S')"
    echo ""
    
    # 3. Änderungen hochladen
    echo "3. Übertrage Änderungen auf GitHub (git push)..."
    git push origin main
    if [ $? -ne 0 ]; then
        echo "Fehler beim Hochladen auf GitHub."
        read -n 1 -s -p "Drücke eine beliebige Taste zum Beenden..."
        exit 1
    fi
    echo "Erfolgreich hochgeladen!"
fi

echo ""
echo "=== FERTIG! Du kannst jetzt auf einem anderen PC weiterarbeiten. ==="
echo ""
read -n 1 -s -p "Drücke eine beliebige Taste zum Schließen..."
echo ""
