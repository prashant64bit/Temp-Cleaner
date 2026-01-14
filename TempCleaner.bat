@echo off
title Cleaner - Prashant
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
echo          TempCleaner - v1.2.0
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
if /i "%sel%"=="99" exit
goto menu

:quick
cls
echo.
echo  Quick Cleanup running...
echo.

echo [1/7] %TEMP%
del /q /f /s "%TEMP%\*.*" 2>nul
rd /s /q "%TEMP%" 2>nul
md "%TEMP%" 2>nul

echo [2/7] Local Temp
del /q /f /s "%localappdata%\Temp\*.*" 2>nul
rd /s /q "%localappdata%\Temp" 2>nul
md "%localappdata%\Temp" 2>nul

echo [3/7] Windows Temp
del /q /f /s "C:\Windows\Temp\*.*" 2>nul
rd /s /q "C:\Windows\Temp" 2>nul
md "C:\Windows\Temp" 2>nul

echo [4/7] DNS flush
ipconfig /flushdns >nul 2>&1

echo [5/7] Browser caches
rd /s /q "%localappdata%\Microsoft\Edge\User Data\Default\Cache"         2>nul
rd /s /q "%localappdata%\Microsoft\Edge\User Data\Default\Code Cache"    2>nul
rd /s /q "%localappdata%\Google\Chrome\User Data\Default\Cache"          2>nul
rd /s /q "%localappdata%\Google\Chrome\User Data\Default\Code Cache"     2>nul

echo [6/7] Update cache
del /q /f /s "C:\Windows\SoftwareDistribution\Download\*.*"  2>nul
del /q /f /s "C:\Windows\SoftwareDistribution\DataStore\*.*" 2>nul

echo [7/7] Idle tasks
start "" rundll32.exe advapi32.dll,ProcessIdleTasks >nul 2>&1

echo.
echo  Quick done.
pause
goto menu

:disk
cls
echo.
echo  Auto Disk Cleanup running...
echo  (silent mode - your preset)
echo.
cleanmgr /sagerun:50
echo.
echo  Finished - check free space on C:.
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
echo  1. Right-click Start → Command Prompt (Admin) or Terminal (Admin)
echo.
echo  2. Type and Enter:
echo     cleanmgr /sageset:50
echo.
echo  3. In the window that opens:
echo     → Click "Clean up system files" button
echo     → Wait for scan
echo     → Tick all the boxes you want cleaned every time
echo       (tick everything for maximum space recovery)
echo     → Click OK
echo.
echo  After this, option 2 runs completely automatic.
echo  To change selections later → run the same sageset command again.
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
echo  Script Version : 1.2.0
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
