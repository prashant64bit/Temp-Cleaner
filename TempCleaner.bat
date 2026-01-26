@echo off
title Cleaner - Prashant64bit v1.5.0

reg add HKCU\Console /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1

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
echo  [1;36m====================================================[0m
echo  [1;33m          TempCleaner - Prashant64bit v1.5.0[0m
echo  [1;36m====================================================[0m
echo.
echo  [1;32m    1  -  Quick Cleanup[0m
echo  [1;33m    2  -  Auto Disk Cleanup[0m
echo  [1;36m    3  -  Setup Instructions (for option 2)[0m
echo  [1;35m    4  -  About Developer[0m
echo.
echo  [1;31m   99 - Exit[0m
echo.
echo  [1;36m====================================================[0m
echo.
set /p sel=  [1;37mChoice: [0m

if /i "%sel%"=="1" goto quick
if /i "%sel%"=="2" goto disk
if /i "%sel%"=="3" goto instructions
if /i "%sel%"=="4" goto info
if /i "%sel%"=="99" goto end
goto menu

:quick
cls
echo.
echo  [1;33mQuick Cleanup running...[0m
echo.

echo  [1;36m[1/12][0m [1;37mUser TEMP folders[0m
del /q /f /s /a "%TEMP%\*.*" 2>nul
del /q /f /s /a "%LOCALAPPDATA%\Temp\*.*" 2>nul
del /s /f /q "%LOCALAPPDATA%\LocalLow\Temp\*.*" 2>nul
echo  [1;32mCleared.[0m
echo.

echo  [1;36m[2/12][0m [1;37mWindows Temp[0m
del /q /f /s /a "%WINDIR%\Temp\*.*" 2>nul
echo  [1;32mCleared.[0m
echo.

echo  [1;36m[3/12][0m [1;37mCrash Dumps and Memory Dumps[0m
del /f /q "%WINDIR%\MEMORY.DMP" 2>nul
del /f /q /s "%WINDIR%\Minidump\*.*" 2>nul
del /f /q /s "%LOCALAPPDATA%\CrashDumps\*.*" 2>nul
echo  [1;32mCleared.[0m
echo.

echo  [1;36m[4/12][0m [1;37mPowerShell History and Caches[0m
del /f /q /s "%APPDATA%\Microsoft\Windows\PowerShell\PSReadLine\*.*" 2>nul
del /f /q /s "%LOCALAPPDATA%\Microsoft\Windows\Caches\*.*" 2>nul
echo  [1;32mCleared.[0m
echo.

echo  [1;36m[5/12][0m [1;37mWindows Update cache[0m
net stop wuauserv   >nul 2>&1
net stop bits       >nul 2>&1
del /q /f /s /a "%WINDIR%\SoftwareDistribution\Download\*.*" 2>nul
net start wuauserv  >nul 2>&1
net start bits      >nul 2>&1
echo  [1;32mCleared.[0m
echo.

echo  [1;36m[6/12][0m [1;37mPrefetch[0m
del /q /f /s /a "%WINDIR%\Prefetch\*.*" 2>nul
echo  [1;32mCleared.[0m
echo.

echo  [1;36m[7/12][0m [1;37mThumbnail cache[0m
del /q /f /s /a "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db" 2>nul
echo  [1;32mCleared.[0m
echo.

echo  [1;36m[8/12][0m [1;37mRecycle Bin[0m
powershell -command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" >nul 2>&1
echo  [1;32mCleared.[0m
echo.

echo  [1;36m[9/12][0m [1;37mBrowser caches[0m
rd /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache"         2>nul
rd /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Code Cache"    2>nul
rd /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache"          2>nul
rd /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Code Cache"     2>nul
echo  [1;32mCleared.[0m
echo.

echo  [1;36m[10/12][0m [1;37mLog Files[0m
timeout /t 2 /nobreak >nul
del /s /f /q "%WINDIR%\Logs\CBS\CbsPersist\*.log" 2>nul
del /s /f /q "%WINDIR%\Logs\MoSetup\*.log" 2>nul
del /s /f /q "%WINDIR%\Panther\*.log" 2>nul
del /s /f /q "%WINDIR%\Logs\*.log" 2>nul
del /s /f /q "%LOCALAPPDATA%\Microsoft\Windows\WebCache\*.log" 2>nul
del /s /f /q "%LOCALAPPDATA%\Microsoft\Windows\INetCache\*.log" 2>nul
echo  [1;32mCleared.[0m
echo.

echo  [1;36m[11/12][0m [1;37mWindows Defender Logs[0m
timeout /t 2 /nobreak >nul
del /s /f /q "%ProgramData%\Microsoft\Windows Defender\*.log" 2>nul
del /s /f /q "%ProgramData%\Microsoft\Windows Defender\Scans\History\Service\*.log" 2>nul
echo  [1;32mCleared.[0m
echo.

echo  [1;36m[12/12][0m [1;37mDNS and Network Cache Refresh[0m
timeout /t 2 /nobreak >nul
ipconfig /flushdns >nul 2>&1
ipconfig /release  >nul 2>&1
ipconfig /renew    >nul 2>&1
echo  [1;32mCleared.[0m
echo.

echo  [1;33mRestarting Explorer...[0m
taskkill /f /im explorer.exe >nul 2>&1
DEL /F /S /Q /A "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>nul
DEL /F /S /Q /A "%LOCALAPPDATA%\Microsoft\Windows\Explorer\*.db" >nul 2>nul
start explorer.exe

echo.
echo  [1;32mQuick Cleanup finished successfully![0m
echo.
pause
goto menu


:disk
cls
echo.
echo  [1;33mAuto Disk Cleanup running...[0m
echo.
cleanmgr /sagerun:50
echo.
echo  [1;32mFinished.[0m
echo.
pause
goto menu

:instructions
cls
echo.
echo  [1;36m=============================================[0m
echo  [1;33m        Setup for Auto Disk Cleanup[0m
echo  [1;36m=============================================[0m
echo.
echo  [1;37mDo this ONE TIME so option 2 works silently:[0m
echo.
echo  [1;37m1.[0m Right-click [1;33mStart Terminal (Admin) or Command Prompt (Admin)[0m
echo.
echo  [1;37m2.[0m Type and Enter:
echo     [1;33mcleanmgr /sageset:50[0m
echo.
echo  [1;37m3.[0m In the window:
echo     [1;36m-[0m Click [1;33m"Clean up system files"[0m
echo     [1;36m-[0m Wait for scan
echo     [1;36m-[0m Tick everything you want cleaned regularly
echo        (recommended: Temporary files, Windows Update Cleanup, thumbnails, Recycle Bin, etc.)
echo     [1;36m-[0m Click [1;33mOK[0m
echo.
echo  [1;37mAfter this, option 2 runs fully automatic.[0m
echo  [1;37mChange later [1;33m-[0m run [1;33mcleanmgr /sageset:50[0m again.
echo.
pause
goto menu

:info
cls
echo.
echo  [1;36m=============================================[0m
echo  [1;33m                 Info[0m
echo  [1;36m=============================================[0m
echo.
echo  [1;37mScript Version : [1;33mv1.5.0[0m
echo.
echo  [1;37mMade by:[0m
echo  [1;33mPrashant Thakur[0m
echo.
echo  [1;37mGithub:    [1;36mhttps://github.com/prashant64bit[0m
echo  [1;37mPortfolio: [1;36mhttps://PrashantThakur.is-a.dev[0m
echo  [1;37mLinkedin:  [1;36mhttps://linkedin.com/in/prashant64bit[0m
echo.
pause
goto menu

:end
exit