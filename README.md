

# CacheCleaner

**A sleek, no-nonsense system cleaning tool for Windows.**  
CacheCleaner helps you free up space by cleaning out unnecessary temp files, logs, and app/browser caches — all from a simple, user-friendly interface.

---

## Features

- **System Cleaners**:
  - System Temp files
  - User Temp files
  - Prefetch data
  - System logs & error reports
  - Thumbnail cache
  - Leftover `.log`, `.bak`, `.old` files

- **Application Cleaners**:
  - Discord, Steam, Adobe, Epic Games, Spotify, Teams, Zoom, Slack, Telegram, Roblox, Riot Games, and more

- **Browser Cache Cleaners**:
  - Google Chrome
  - Microsoft Edge
  - Mozilla Firefox
  - Brave
  - Opera GX

- **Other Perks**:
  - Select/Deselect All buttons
  - Progress bar with feedback
  - Simple and modern Windows Forms UI

---

## How to Use

Launch CacheCleaner by opening **PowerShell as Administrator** and running the command below:

```powershell
Start-Process powershell -ArgumentList "Set-ExecutionPolicy RemoteSigned -Scope Process -Force; Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/makhlwf/cache_cleaner/refs/heads/main/cache_cleaner_by_makhlwf.ps1' -OutFile 'cache_cleaner.ps1'; .\cache_cleaner.ps1" -Verb RunAs
```
This will:

1. Temporarily allow scripts in your session


2. Download the latest version of the script


3. Launch CacheCleaner with admin rights




---

Download

Latest Release (v1.0) — Click to download the latest version of CacheCleaner from the GitHub Releases page.

Or browse the full list of versions in the Releases section.


---

Requirements

Windows OS

PowerShell 5.1 or newer

Administrator permissions



---

Disclaimer

> This tool is provided as-is with no guarantees. While CacheCleaner is designed to safely clean common temp/cache files, please review the script before use and run at your own risk.




---

License

This project is open source and available under the MIT License.


---

Made with care by @makhlwf
