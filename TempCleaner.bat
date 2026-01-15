@echo off
title Cleaner - Prashant v1.3.0
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
echo       TempCleaner - v1.3.0
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

echo [1/9] User TEMP folders
del /q /f /s /a "%TEMP%\*.*" 2>nul
del /q /f /s /a "%localappdata%\Temp\*.*" 2>nul
echo Cleared.
echo.

echo [2/9] Windows Temp
del /q /f /s /a "C:\Windows\Temp\*.*" 2>nul
echo Cleared.
echo.

echo [3/9] DNS flush
ipconfig /flushdns >nul 2>&1
echo Cleared.
echo.

echo [4/9] Browser caches
rd /s /q "%localappdata%\Microsoft\Edge\User Data\Default\Cache"         2>nul
rd /s /q "%localappdata%\Microsoft\Edge\User Data\Default\Code Cache"    2>nul
rd /s /q "%localappdata%\Google\Chrome\User Data\Default\Cache"          2>nul
rd /s /q "%localappdata%\Google\Chrome\User Data\Default\Code Cache"     2>nul
echo Cleared.
echo.

echo [5/9] Windows Update cache
net stop wuauserv   >nul 2>&1
net stop bits       >nul 2>&1
del /q /f /s /a "C:\Windows\SoftwareDistribution\Download\*.*"  2>nul
net start wuauserv  >nul 2>&1
net start bits      >nul 2>&1
echo Cleared.
echo.

echo [6/9] Prefetch
del /q /f /s /a "C:\Windows\Prefetch\*.*" 2>nul
echo Cleared.
echo.

echo [7/9] Thumbnail cache
del /q /f /s /a "%localappdata%\Microsoft\Windows\Explorer\thumbcache_*.db" 2>nul
echo Cleared.
echo.
echo [8/9] Recycle Bin
powershell -command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" >nul 2>&1
echo Cleared.
echo.

echo [9/9] Idle tasks
start "" rundll32.exe advapi32.dll,ProcessIdleTasks >nul 2>&1
echo Processed.
echo.
echo  Quick done.
echo.
pause
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
echo  Script Version : 1.3.0
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
