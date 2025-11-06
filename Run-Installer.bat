@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul

rem ===============================================
rem   Emir Tech Tools Windows 11 25H2 Installer(BAT)
rem   Opens classic blue Windows PowerShell window
rem   AV-friendly (no CurrentUser policy changes)
rem ===============================================

set "SCRIPT=Windows11_QuickInstaller.ps1"
set "FULLPATH=%~dp0%SCRIPT%"

echo.
echo Emir Tech Tools Windows 11 Installer
echo ------------------------------------------
echo.

rem 1) Ensure the PS1 exists
if not exist "%FULLPATH%" (
  echo ERROR: %SCRIPT% not found in this folder.
  echo Please place the script in the same folder as this batch file.
  pause
  exit /b 1
)


rem 2) Unblock the file quietly (no error if not blocked)
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "try{Unblock-File -LiteralPath '%FULLPATH%' -ErrorAction SilentlyContinue}catch{}"

rem 3) Launch a *separate* elevated Windows PowerShell (classic blue) and run the PS1
echo Launching installer (UAC prompt will appear)...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "Start-Process -FilePath '%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe' -ArgumentList '-NoProfile','-ExecutionPolicy','Bypass','-NoLogo','-File','\"%FULLPATH%\"' -Verb RunAs -WindowStyle Normal"

endlocal
exit /b 0
