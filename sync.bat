@echo off
:: Spiele-Portal Sync-Skript für Windows
chcp 65001 > nul
echo =============================================
echo === Spiele-Portal Synchronisation (Windows) ===
echo =============================================
echo.

:: 1. Neueste Änderungen herunterladen
echo 1. Lade neueste Änderungen von GitHub herunter (git pull)...
git pull
if %errorlevel% neq 0 (
    echo Fehler beim Herunterladen der Änderungen von GitHub.
    echo Bitte ueberpruefe deine Internetverbindung oder Git-Berechtigungen.
    pause
    exit /b 1
)
echo Erfolgreich aktualisiert!
echo.

:: 2. Lokale Änderungen speichern
echo 2. Suche nach neuen oder geänderten Spielen...
git add .

:: Prüfen, ob Änderungen vorhanden sind
git diff-index --quiet HEAD --
if %errorlevel% neq 0 (
    echo Änderungen gefunden! Speichere lokale Änderungen (git commit)...
    git commit -m "Update von %date% %time%"
    echo.
    
    :: 3. Änderungen hochladen
    echo 3. Übertrage Änderungen auf GitHub (git push)...
    git push origin main
    if %errorlevel% neq 0 (
        echo Fehler beim Hochladen auf GitHub.
        pause
        exit /b 1
    )
    echo Erfolgreich hochgeladen!
) else (
    echo Keine neuen Änderungen zum Speichern vorhanden.
)

echo.
echo === FERTIG! Du kannst jetzt auf einem anderen PC weiterarbeiten. ===
echo.
pause
