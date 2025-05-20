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
  - Discord
  - Spotify
  - Epic Games Launcher
  - Battle.net
  - Steam
  - Adobe (Common Media Cache, Premiere Pro)
  - Microsoft Teams
  - Slack
  - WhatsApp
  - Zoom
  - Telegram Desktop
  - Roblox
  - Riot Games Client

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

## Planned Enhancements

We aim to continuously improve CacheCleaner. Some features planned for future releases include:

- Cleaning for VLC Media Player cache
- Cleaning for Windows Update cache
- Option to flush DNS cache

*Note: We've encountered some technical difficulties with our current toolset for modifying the PowerShell script, which has temporarily delayed the implementation of these features. We're working on resolving these issues.*

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

## Screenshots

*(Coming soon! We'll add some screenshots of CacheCleaner in action.)*

---

## Download

- [**Download Latest Release**](https://github.com/makhlwf/cache_cleaner/releases/latest)  
- [**Browse All Releases**](https://github.com/makhlwf/cache_cleaner/releases)

---

## Requirements

- Windows OS  
- PowerShell 5.1 or newer  
- Administrator permissions  

---

## Disclaimer

> This tool is provided as-is with no guarantees. While CacheCleaner is designed to safely clean common temp/cache files, please review the script before use and run at your own risk.

---

## Contributing

Contributions are welcome! If you have suggestions for improvements, new features, or bug fixes, please feel free to:

1.  Fork the repository.
2.  Create a new branch for your changes.
3.  Make your changes and test them.
4.  Submit a pull request with a clear description of your contributions.

Alternatively, you can also open an issue to discuss your ideas.

---

## License

This project is open source and available under the [MIT License](LICENSE).

---

Made with care by [@makhlwf](https://github.com/makhlwf)
