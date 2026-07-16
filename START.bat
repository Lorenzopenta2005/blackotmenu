@echo off
title BlackOut Menu - Cibo ^& Drink
cd /d "%~dp0"

echo Installazione dipendenze...
call npm install

echo.
echo Avvio server...
node server.js
pause
