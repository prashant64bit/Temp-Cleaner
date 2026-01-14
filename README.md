# 🧹 Temp-Cleaner  

![Windows](https://img.shields.io/badge/OS-Windows-blue?logo=windows)  
![License](https://img.shields.io/badge/license-MIT-green)  
![Version](https://img.shields.io/badge/version-1.2.0-orange)  

**Temp-Cleaner** is a lightweight, open-source Windows batch script that helps free up disk space and improve performance by removing temporary files, caches, DNS cache, Windows Update leftovers, and integrated Disk Cleanup automation.

---

## Features  

- **Quick Cleanup mode** :
  - Clears temporary folders:
    - `%TEMP%`
    - `%LocalAppData%\Temp`
    - `C:\Windows\Temp`
  - Flushes **DNS cache**
  - Clears **Microsoft Edge** & **Google Chrome** browser caches (Cache + Code Cache)
  - Removes **Windows Update** download & datastore cache
  - Runs Windows background idle maintenance tasks (`ProcessIdleTasks`)
- **Auto Disk Cleanup mode** — runs Windows built-in Disk Cleanup silently with your pre-configured preset
- Automatic **admin rights request** (elevates itself if not run as administrator)
- Clean, colorful menu interface
- Setup instructions included for Disk Cleanup preset
- Only targets temporary & cache data (no system-critical files are touched)

---

## Usage  

**Recommended way:**

1. Run The `TempCleaner.bat`.

2. Choose from the menu:
   -Quick Cleanup           (fast one-click cleaning)
   -Auto Disk Cleanup       (silent Windows Disk Cleanup – requires one-time setup)
   -Setup Instructions      (how to configure option 2)
   -About Developer
   -Exit

3. Then Select "Setup Instructions"
   and setup Auto Disk Cleanup as per the guide

---

## When to Use
- Monthly maintenance
- Before or after large Windows updates
- When free disk space on C: is getting low
- Whenever the system feels sluggish

---

## LICENSE
This project is licensed under the [MIT License](LICENSE).
