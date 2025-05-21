# CacheCleaner

**A sleek, no-nonsense system cleaning tool for Windows.**  

<p align="center">
  <a href="#features">Features</a> |
  <a href="#how-to-use">How to Use</a> |
  <a href="#download">Download</a> |
  <a href="#requirements">Requirements</a> |
  <a href="#contributing">Contributing</a> |
  <a href="#license">License</a>
</p>

CacheCleaner helps you free up space by cleaning out unnecessary temp files, logs, and app/browser caches — all from a simple, user-friendly interface.

## How It Works

CacheCleaner is a PowerShell script that leverages Windows Forms to provide a simple and lightweight graphical user interface (GUI). This means you get the power of a script with the ease of use of a visual tool, without needing to install a heavy application.

The script dynamically builds its interface when launched, organizing cleaning options into clear categories like "System Cleaners," "Application Cleaners," and "Browser Cache Cleaners."

When you select items and click "Start Cleaning," CacheCleaner goes to work:

*   It iterates through each of your chosen cleaning tasks.
*   For each task, it targets specific, predefined paths known for accumulating temporary files, cache data, or logs.
*   The core cleaning is handled by a function (internally named `Clean-Folder`) that first calculates the size of the data in a target folder, then attempts to delete its contents using `Remove-Item -Recurse -Force`. This function is designed to suppress errors during deletion (using `-ErrorAction SilentlyContinue`) to ensure the script runs smoothly even if some files are in use or already deleted.
*   Specific application caches are targeted by looking for common paths, including those for apps like Discord, Steam, Spotify, Adobe products, Microsoft Teams, and others.
*   For general leftover files (like `.log`, `.bak`, `.old`), the script searches within common program installation directories such as `C:\ProgramData`, `C:\Program Files`, and `C:\Program Files (x86)`.

Throughout the process, a progress bar updates to show what's happening. Once finished, a message box appears, summarizing the total amount of disk space freed.

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

Contributions are welcome! If you have ideas for improvements or find any issues, please feel free to open an issue or submit a pull request.
When creating an issue, please check if one of our issue templates (e.g., for bug reports or feature requests) fits your purpose.

### How to Contribute

*   Fork the repository.
*   Create a new branch for your feature or bug fix.
*   Make your changes.
*   Ensure your code is clear and well-commented, especially if adding new cleaning paths or logic.
*   Test your changes thoroughly.
*   Submit a pull request with a clear description of your changes.

### Examples of Contributions

*   **Suggest new application cache paths:** If you know of other applications or common software that leaves behind cache files not currently covered, you can suggest their paths. This would typically involve adding new entries to the `$folders` array within the `Clean-AppCaches` function or adding new cases to the main `switch` statement for specific browser/app categories.
*   **Optimize existing cleaning functions:** If you see opportunities to make any of the existing cleaning functions (like `Clean-Folder` or the logic for finding leftover files) more efficient or robust, such suggestions are welcome.
*   **Improve UI elements:** While the UI is simple, suggestions for minor improvements to the Windows Forms elements that don't drastically change the tool's lightweight nature could be considered.

---

## License

This project is open source and available under the [MIT License](LICENSE).

---

Made with care by [@makhlwf](https://github.com/makhlwf)
