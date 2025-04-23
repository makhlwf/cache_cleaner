# === Load WinForms ===
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# === Create Form ===
$form = New-Object System.Windows.Forms.Form
$form.Text = "SuperCleaner - Intelligent Space Saver"
$form.Size = New-Object System.Drawing.Size(500, 720)
$form.StartPosition = "CenterScreen"
$form.Topmost = $true

# === Checkbox Data ===
$checkboxes = @{}
$row = 0

# Group Title Function
function Add-GroupTitle($text) {
    $label = New-Object System.Windows.Forms.Label
    $label.Text = $text
    $label.Location = New-Object System.Drawing.Point(20, 20 + ($row * 25))
    $label.AutoSize = $true
    $label.Font = 'Microsoft Sans Serif,10,style=Bold'
    $form.Controls.Add($label)
    $row++
}

function Add-Checkbox($key, $text) {
    $cb = New-Object System.Windows.Forms.CheckBox
    $cb.Text = $text
    $cb.Location = New-Object System.Drawing.Point(40, 20 + ($row * 25))
    $cb.AutoSize = $true
    $form.Controls.Add($cb)
    $checkboxes[$key] = $cb
    $row++
}

# === Build GUI ===

Add-GroupTitle "System Cleaners"
Add-Checkbox "SystemTemp" "System Temp Files"
Add-Checkbox "UserTemp" "User Temp Files"
Add-Checkbox "Prefetch" "Prefetch Data"
Add-Checkbox "WindowsLogs" "System Logs & Error Reports"
Add-Checkbox "ThumbCache" "Thumbnail Cache"
Add-Checkbox "LeftoverFiles" ".log/.bak/.old Leftovers"

Add-GroupTitle "Application Cleaners"
Add-Checkbox "AppCaches" "Application Cache & Data Cleaner (Discord, Steam, Adobe, etc.)"

Add-GroupTitle "Browser Cache Cleaners"
Add-Checkbox "Chrome" "Google Chrome"
Add-Checkbox "Edge" "Microsoft Edge"
Add-Checkbox "Firefox" "Mozilla Firefox"
Add-Checkbox "Brave" "Brave Browser"
Add-Checkbox "Opera" "Opera GX"

# Select All / Deselect All
$selectAll = New-Object System.Windows.Forms.Button
$selectAll.Text = "Select All"
$selectAll.Size = New-Object System.Drawing.Size(100, 30)
$selectAll.Location = New-Object System.Drawing.Point(40, 20 + ($row * 25))
$selectAll.Add_Click({ $checkboxes.Values | ForEach-Object { $_.Checked = $true } })
$form.Controls.Add($selectAll)

$deselectAll = New-Object System.Windows.Forms.Button
$deselectAll.Text = "Deselect All"
$deselectAll.Size = New-Object System.Drawing.Size(100, 30)
$deselectAll.Location = New-Object System.Drawing.Point(150, 20 + ($row * 25))
$deselectAll.Add_Click({ $checkboxes.Values | ForEach-Object { $_.Checked = $false } })
$form.Controls.Add($deselectAll)
$row += 2

# Progress Bar
$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Location = New-Object System.Drawing.Point(40, 50 + ($row * 25))
$progressBar.Size = New-Object System.Drawing.Size(400, 20)
$progressBar.Minimum = 0
$progressBar.Maximum = $checkboxes.Count
$form.Controls.Add($progressBar)
$row++

# Start Button
$startButton = New-Object System.Windows.Forms.Button
$startButton.Text = "Start Cleaning"
$startButton.Size = New-Object System.Drawing.Size(400, 40)
$startButton.Location = New-Object System.Drawing.Point(40, 80 + ($row * 25))
$form.Controls.Add($startButton)

# === Cleanup Functionality ===
$startButton.Add_Click({
    $progressBar.Value = 0
    $totalFreed = 0

    function Clean-Folder {
        param ($Path)
        if (Test-Path $Path) {
            $size = (Get-ChildItem -Path $Path -Recurse -Force -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum
            Remove-Item -Path $Path -Recurse -Force -ErrorAction SilentlyContinue
            return [math]::Round(($size / 1MB), 2)
        }
        return 0
    }

    function Clean-AppCaches {
        $folders = @(
            "$env:APPDATA\discord\Cache",
            "$env:APPDATA\Spotify\Storage",
            "$env:LOCALAPPDATA\Spotify\Data",
            "$env:LOCALAPPDATA\EpicGamesLauncher\Saved\webcache",
            "C:\ProgramData\Battle.net\Cache",
            "$env:ProgramFiles(x86)\Steam\appcache",
            "$env:ProgramFiles(x86)\Steam\steamapps\shadercache",
            "$env:APPDATA\Adobe\Common\Media Cache Files",
            "$env:APPDATA\Adobe\Premiere Pro\*\Media Cache",
            "$env:APPDATA\Microsoft\Teams",
            "$env:APPDATA\Slack\Cache",
            "$env:APPDATA\WhatsApp\Cache",
            "$env:APPDATA\Zoom\data",
            "$env:APPDATA\Telegram Desktop\tdata\user_data",
            "$env:LOCALAPPDATA\Roblox\logs",
            "$env:LOCALAPPDATA\Roblox\versions\*\*.tmp",
            "$env:LOCALAPPDATA\Riot Games\Riot Client\Cache"
        )
        foreach ($f in $folders) {
            $totalFreed += Clean-Folder $f
        }
    }

    foreach ($key in $checkboxes.Keys) {
        if ($checkboxes[$key].Checked) {
            switch ($key) {
                "SystemTemp"   { $totalFreed += Clean-Folder "$env:SystemRoot\Temp\*" }
                "UserTemp"     { $totalFreed += Clean-Folder "$env:TEMP\*" }
                "Prefetch"     { $totalFreed += Clean-Folder "$env:SystemRoot\Prefetch\*" }
                "WindowsLogs"  {
                    $totalFreed += Clean-Folder "$env:LOCALAPPDATA\Microsoft\Windows\WER\*"
                    $totalFreed += Clean-Folder "$env:SystemRoot\Logs\*"
                }
                "ThumbCache"   { $totalFreed += Clean-Folder "$env:LOCALAPPDATA\Microsoft\Windows\Explorer\thumbcache_*.db" }
                "LeftoverFiles" {
                    $folders = "C:\ProgramData","C:\Program Files","C:\Program Files (x86)"
                    foreach ($folder in $folders) {
                        Get-ChildItem $folder -Recurse -Include *.log,*.bak,*.old -ErrorAction SilentlyContinue | ForEach-Object {
                            $totalFreed += $_.Length / 1MB
                            Remove-Item $_.FullName -Force -ErrorAction SilentlyContinue
                        }
                    }
                }
                "AppCaches"    { Clean-AppCaches }
                "Chrome"       { $totalFreed += Clean-Folder "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache" }
                "Edge"         { $totalFreed += Clean-Folder "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache" }
                "Firefox"      {
                    $profilePath = Get-ChildItem "$env:APPDATA\Mozilla\Firefox\Profiles" -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -match "\.default" }
                    foreach ($p in $profilePath) {
                        $totalFreed += Clean-Folder "$($p.FullName)\cache2"
                    }
                }
                "Brave"        { $totalFreed += Clean-Folder "$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\User Data\Default\Cache" }
                "Opera"        { $totalFreed += Clean-Folder "$env:APPDATA\Opera Software\Opera GX Stable\Cache" }
            }
            $progressBar.PerformStep()
            Start-Sleep -Milliseconds 200
        }
    }

    [System.Windows.Forms.MessageBox]::Show("Cleanup complete! Space freed: $([math]::Round($totalFreed, 2)) MB", "Finished", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
})

$form.Add_Shown({$form.Activate()})
[void]$form.ShowDialog()