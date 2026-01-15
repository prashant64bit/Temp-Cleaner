# 🧹 Temp-Cleaner  

![Windows](https://img.shields.io/badge/OS-Windows-blue?logo=windows)  
![License](https://img.shields.io/badge/license-MIT-green)  
![Version](https://img.shields.io/badge/version-1.3.0-orange)  

**Temp-Cleaner** is a lightweight, open-source Windows batch script that safely frees up disk space and improves system performance by removing temporary files, caches, DNS resolver cache, Windows Update leftovers, prefetch files, thumbnail cache, Recycle Bin contents, and more.

---

## Features  

- **Quick Cleanup mode**:
  - Clears user temporary folders (`%TEMP%` and `%LocalAppData%\Temp`)
  - Clears `C:\Windows\Temp`
  - Flushes **DNS cache** (`ipconfig /flushdns`)
  - Clears **browser caches**
  - Safely cleans **Windows Update download cache**
  - Deletes **Prefetch** files
  - Clears **Thumbnail cache** (`thumbcache_*.db`)
  - Empties **Recycle Bin**
  - Runs Windows background idle maintenance tasks (`ProcessIdleTasks`)
- **Auto Disk Cleanup mode** - silently runs Windows built-in Disk Cleanup with your pre-configured preset
- Automatic **admin rights elevation** (requests elevation if not already running as administrator)
- Clean, colorful console menu interface
- Clear progress messages for every cleanup step
- One-time setup instructions included for silent Disk Cleanup
- **Safe by design** - only targets well-known temporary/cache locations

---

## Usage  

**Recommended way:**

1. Double-click `TempCleaner.bat`

2. Allow run as Administrator. 

3. Choose from the menu:
   - **1**  Quick Cleanup            (fast & recommended for regular use)
   - **2**  Auto Disk Cleanup        (powerful silent cleanup – requires one-time setup)
   - **3**  Setup Instructions       (how to configure option 2 the first time)
   - **4**  About Developer
   - **99**  Exit

4. **First time users**:  
   Select **3** (Setup Instructions) and follow the steps to configure your Disk Cleanup preset once.  
   After that, option **2** will run completely silently and clean much more (including old updates, system files, etc.).

---

## When to Use

- Monthly maintenance
- Before or after large Windows updates
- When free disk space on C: is getting low
- Whenever the system feels sluggish

---

## Requirements

- Windows 10 / 11
- Administrator rights (script auto-requests elevation)

---

## LICENSE

This project is licensed under the [MIT License](LICENSE).

Made by **Prashant Thakur**  
Portfolio: https://prashant.us.kg  
LinkedIn: https://linkedin.com/in/prashant64bit
