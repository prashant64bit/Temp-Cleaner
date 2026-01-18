@echo off
title Cleaner - Prashant64bit v1.4.0
color 0A

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Requesting admin rights...
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B
)

:menu
cls
echo.
echo  =======================================
echo       TempCleaner - v1.4.0
echo  =======================================
echo.
echo  1 - Quick Cleanup
echo  2 - Auto Disk Cleanup
echo  3 - Setup Instructions (for option 2)
echo  4 - About Developer
echo  99 - Exit
echo.
set /p sel=   Choice: 

if /i "%sel%"=="1" goto quick
if /i "%sel%"=="2" goto disk
if /i "%sel%"=="3" goto instructions
if /i "%sel%"=="4" goto info
if /i "%sel%"=="99" goto end
goto menu

:quick
cls
echo.
echo  Quick Cleanup running...
echo.

echo [1/12] User TEMP folders
del /q /f /s /a "%TEMP%\*.*" 2>nul
del /q /f /s /a "%LOCALAPPDATA%\Temp\*.*" 2>nul
del /s /f /q "%LOCALAPPDATA%\LocalLow\Temp\*.*" 2>nul
echo Cleared.
echo.

echo [2/12] Windows Temp
del /q /f /s /a "%WINDIR%\Temp\*.*" 2>nul
echo Cleared.
echo.

echo [3/12] Crash Dumps and Memory Dumps
del /f /q "%WINDIR%\MEMORY.DMP" 2>nul
del /f /q /s "%WINDIR%\Minidump\*.*" 2>nul
del /f /q /s "%LOCALAPPDATA%\CrashDumps\*.*" 2>nul
echo Cleared.
echo.

echo [4/12] PowerShell History and Caches
del /f /q /s "%APPDATA%\Microsoft\Windows\PowerShell\PSReadLine\*.*" 2>nul
del /f /q /s "%LOCALAPPDATA%\Microsoft\Windows\Caches\*.*" 2>nul
echo Cleared.
echo.

echo [5/12] Windows Update cache
net stop wuauserv   >nul 2>&1
net stop bits       >nul 2>&1
del /q /f /s /a "%WINDIR%\SoftwareDistribution\Download\*.*" 2>nul
net start wuauserv  >nul 2>&1
net start bits      >nul 2>&1
echo Cleared.
echo.

echo [6/12] Prefetch
del /q /f /s /a "%WINDIR%\Prefetch\*.*" 2>nul
echo Cleared.
echo.

echo [7/12] Thumbnail cache
del /q /f /s /a "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db" 2>nul
echo Cleared.
echo.

echo [8/12] Recycle Bin
powershell -command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" >nul 2>&1
echo Cleared.
echo.

echo [9/12] Browser caches
rd /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache"         2>nul
rd /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Code Cache"    2>nul
rd /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache"          2>nul
rd /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Code Cache"     2>nul
echo Cleared.
echo.

echo [10/12] Log Files
timeout /t 2 /nobreak >nul
del /s /f /q "%WINDIR%\Logs\CBS\CbsPersist\*.log" 2>nul
del /s /f /q "%WINDIR%\Logs\MoSetup\*.log" 2>nul
del /s /f /q "%WINDIR%\Panther\*.log" 2>nul
del /s /f /q "%WINDIR%\Logs\*.log" 2>nul
del /s /f /q "%LOCALAPPDATA%\Microsoft\Windows\WebCache\*.log" 2>nul
del /s /f /q "%LOCALAPPDATA%\Microsoft\Windows\INetCache\*.log" 2>nul
echo Cleared.
echo.

echo [11/12] Windows Defender Logs
timeout /t 2 /nobreak >nul
del /s /f /q "%ProgramData%\Microsoft\Windows Defender\*.log" 2>nul
del /s /f /q "%ProgramData%\Microsoft\Windows Defender\Scans\History\Service\*.log" 2>nul
echo Cleared.
echo.

echo [12/12] DNS and Network Cache Refresh
timeout /t 2 /nobreak >nul
ipconfig /flushdns >nul 2>&1
ipconfig /release  >nul 2>&1
ipconfig /renew    >nul 2>&1
echo Cleared.
echo.

echo  Restarting Explorer...
taskkill /f /im explorer.exe >nul 2>&1
DEL /F /S /Q /A "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>nul
DEL /F /S /Q /A "%LOCALAPPDATA%\Microsoft\Windows\Explorer\*.db" >nul 2>nul
start explorer.exe

echo.
echo  Quick Cleanup finished successfully!
echo.
pause
color 0A
goto menu


:disk
cls
echo.
echo  Auto Disk Cleanup running...
echo.
cleanmgr /sagerun:50
echo.
echo  Finished.
echo.
pause
goto menu

:instructions
cls
echo.
echo  =======================================
echo     Setup for Auto Disk Cleanup
echo  =======================================
echo.
echo  Do this ONE TIME so option 2 works silently:
echo.
echo  1. Right-click Start → Terminal (Admin) or Command Prompt (Admin)
echo.
echo  2. Type and Enter:
echo     cleanmgr /sageset:50
echo.
echo  3. In the window:
echo     → Click "Clean up system files"
echo     → Wait for scan
echo     → Tick everything you want cleaned regularly
echo       (recommended: Temporary files, Windows Update Cleanup, thumbnails, Recycle Bin, etc.)
echo     → Click OK
echo.
echo  After this, option 2 runs fully automatic.
echo  Change later → run sageset:50 again.
echo.
pause
goto menu

:info
cls
echo.
echo  =======================================
echo               Info
echo  =======================================
echo.
echo  Script Version : 1.4.0
echo.
echo  Made by:
echo  Prashant Thakur
echo.
echo  Github:    https://github.com/prashant64bit
echo  Portfolio: https://prashant.us.kg
echo  Linkedin:  https://linkedin.com/in/prashant64bit
echo.
pause
goto menu

:end
exit
