<h1>CacheCleaner</h1>

<p><em>A sleek, no-nonsense system cleaning tool for Windows.</em></p>
CacheCleaner helps you free up space by cleaning out unnecessary temp files, logs, and app/browser caches — all from a simple, user-friendly interface.

---

<details>
  <summary><h2>Features</h2></summary>

  <strong>System Cleaners:</strong>
  <ul>
    <li>System Temp files</li>
    <li>User Temp files</li>
    <li>Prefetch data</li>
    <li>System logs & error reports</li>
    <li>Thumbnail cache</li>
    <li>Leftover <code>.log</code>, <code>.bak</code>, <code>.old</code> files</li>
  </ul>

  <strong>Application Cleaners:</strong>
  <ul>
    <li>Discord, Steam, Adobe, Epic Games, Spotify, Teams, Zoom, Slack, Telegram, Roblox, Riot Games, and more</li>
  </ul>

  <strong>Browser Cache Cleaners:</strong>
  <ul>
    <li>Google Chrome</li>
    <li>Microsoft Edge</li>
    <li>Mozilla Firefox</li>
    <li>Brave</li>
    <li>Opera GX</li>
  </ul>

  <strong>Other Perks:</strong>
  <ul>
    <li>Select/Deselect All buttons</li>
    <li>Progress bar with feedback</li>
    <li>Simple and modern Windows Forms UI</li>
  </ul>
</details>

---

<details>
  <summary><h2>How to Use</h2></summary>

Launch CacheCleaner by opening <strong>PowerShell as Administrator</strong> and running the command below:

<pre><code class="language-powershell">
Start-Process powershell -ArgumentList "Set-ExecutionPolicy RemoteSigned -Scope Process -Force; Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/makhlwf/cache_cleaner/refs/heads/main/cache_cleaner_by_makhlwf.ps1' -OutFile 'cache_cleaner.ps1'; .\cache_cleaner.ps1" -Verb RunAs
</code></pre>

This will:

  <ol>
    <li>Temporarily allow scripts in your session</li>
    <li>Download the latest version of the script</li>
    <li>Launch CacheCleaner with admin rights</li>
  </ol>

---

<details>
  <summary><h2>Download</h2></summary>

- [<strong>Download Latest Release</strong>](https://github.com/makhlwf/cache_cleaner/releases/latest)  
- [<strong>Browse All Releases</strong>](https://github.com/makhlwf/cache_cleaner/releases)
</details>

---

<details>
  <summary><h2>Requirements</h2></summary>

- Windows OS  
- PowerShell 5.1 or newer  
- Administrator permissions  
</details>

---

<details>
  <summary><h2>Disclaimer</h2></summary>

> This tool is provided as-is with no guarantees. While CacheCleaner is designed to safely clean common temp/cache files, please review the script before use and run at your own risk.
</details>

---

<details>
  <summary><h2>License</h2></summary>

This project is open source and available under the [MIT License](LICENSE).
</details>

---

<p style="text-align: center;"><em>Made with care by </em><a href="https://github.com/makhlwf">@makhlwf</a></p>
