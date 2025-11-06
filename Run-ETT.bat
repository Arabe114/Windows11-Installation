@echo off
title ETT - ElN Tech Tool
color 7

:MENU
cls
echo ==============================================
echo  [ E T T ] - ELN Tech Tool Menu
echo ==============================================
echo.
echo  1. Install Windows 11 (Upgrade)
echo  2. Install Microsoft Office (Download x64)
echo  3. Activate Microsoft Office (PowerShell Script)
echo  4. Exit
echo.
echo ==============================================

set /p CHOICE="Enter your choice (1, 2, 3, or 4): "

:: --- FIX: The line "INSTALL_OFFICEACTIVATE_OFFICE" was removed from here. ---
if /i "%CHOICE%"=="1" goto INSTALL_WINDOWS11
if /i "%CHOICE%"=="2" goto INSTALL_OFFICE
if /i "%CHOICE%"=="3" goto ACTIVATE_OFFICE
if /i "%CHOICE%"=="4" goto END
goto INVALID_CHOICE

:INSTALL_OFFICE
cls
echo [*] Opening Office 365 ProPlus x64 download link...
echo.
start "" "https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=O365ProPlusRetail&platform=x64&language=en-us&version=O16GA"
echo.
echo [DONE] The download should start in your browser.
pause
goto MENU

:ACTIVATE_OFFICE
cls
echo [*] Starting Office Activation Script (PowerShell)...
echo [*] This requires administrative privileges to proceed.
echo.
:: The following command executes the user-provided PowerShell script
powershell -NoProfile -ExecutionPolicy Bypass -Command "iex (curl.exe -s --doh-url https://1.1.1.1/dns-query https://get.activated.win | Out-String)"
echo.
echo [DONE] Activation process finished. Check the output above for results.
pause
goto MENU

:INSTALL_WINDOWS11
cls
echo [*] Attempting to launch the Windows 11 installer...
echo [*] Searching for 'Run-Installer.bat' in the 'src' folder...
echo.

:: Check for the file with a specific extension in the 'src' folder.
:: Using 'start' ensures the batch file runs in a new, separate window, keeping this menu open.
if exist "src\Run-Installer.bat" (
    echo [FOUND] Executing 'src\Run-Installer.bat'...
    start "" "src\Run-Installer.bat"
) else if exist "src\Run-Installer.cmd" (
    echo [FOUND] Executing 'src\Run-Installer.cmd'...
    start "" "src\Run-Installer.cmd"
) else (
    echo [ERROR] Installer not found.
    echo Please ensure the file is named 'Run-Installer.bat' or 'Run-Installer.cmd'
    echo and is located inside the 'src' folder next to this ETT script.
)

echo.
echo [DONE] Windows 11 Installation launch attempt finished.
pause
goto MENU

:INVALID_CHOICE
cls
echo [ERROR] Invalid selection. Please enter 1, 2, 3, or 4.
pause
goto MENU

:END
cls
echo Thank you for using ETT! Exiting...
timeout /t 2 /nobreak >nul
exit