#Requires -RunAsAdministrator

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

function Test-IsAdmin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-IsAdmin)) {
    [System.Windows.Forms.MessageBox]::Show("This script requires Administrator privileges to run correctly. Please re-run as Administrator.", "Admin Rights Required", "OK", "Error")
    exit 1
}

$checkboxes = @{}
$currentRow = 0
$formWidth = 520
$formHeight = 800
$padding = 20
$controlHeight = 25
$labelIndent = $padding
$checkboxIndent = $padding + 20
$logMessages = New-Object System.Collections.Generic.List[string]

$form = New-Object System.Windows.Forms.Form
$form.Text = "SuperCleaner Pro - Intelligent Space Saver"
$form.Size = New-Object System.Drawing.Size($formWidth, $formHeight)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$form.MaximizeBox = $false

$toolTip = New-Object System.Windows.Forms.ToolTip
$toolTip.AutoPopDelay = 5000; $toolTip.InitialDelay = 500; $toolTip.ReshowDelay = 500; $toolTip.ShowAlways = $true

function Add-GroupTitle($text) {
    $label = New-Object System.Windows.Forms.Label
    $label.Text = $text
    $label.Location = New-Object System.Drawing.Point($labelIndent, $padding + ($script:currentRow * $controlHeight))
    $label.AutoSize = $true
    $label.Font = 'Microsoft Sans Serif,10,style=Bold'
    $form.Controls.Add($label)
    $script:currentRow++
}

function Add-Checkbox($key, $text, $tooltipText = $null) {
    $cb = New-Object System.Windows.Forms.CheckBox
    $cb.Text = $text
    $cb.Location = New-Object System.Drawing.Point($checkboxIndent, $padding + ($script:currentRow * $controlHeight))
    $cb.AutoSize = $true
    $form.Controls.Add($cb)
    $checkboxes[$key] = $cb
    if ($tooltipText) { $toolTip.SetToolTip($cb, $tooltipText) }
    $script:currentRow++
}

function Add-LogEntry ($message, $type = "INFO") {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $formattedMessage = "$timestamp [$type] - $message"
    $logMessages.Add($formattedMessage)
    if ($logTextBox) {
        $logTextBox.AppendText("$formattedMessage`r`n")
        $logTextBox.ScrollToCaret()
    }
    Write-Host $formattedMessage
}

# === Build GUI (omitted for brevity - same as before) ===
Add-GroupTitle "System Cleaners"
Add-Checkbox "SystemTemp" "System Temp Files" "Deletes files from C:\Windows\Temp"
Add-Checkbox "UserTemp" "User Temp Files" "Deletes files from %TEMP% (user's temporary folder)"
Add-Checkbox "Prefetch" "Prefetch Data" "Clears Windows prefetch files (C:\Windows\Prefetch)"
Add-Checkbox "WindowsLogs" "System Logs & Error Reports" "Clears Windows event logs content and error reporting files" # Modified tooltip
Add-Checkbox "ThumbCache" "Thumbnail Cache" "Deletes thumbnail cache files (thumbcache_*.db)"
Add-Checkbox "LeftoverFiles" ".log/.bak/.old Leftovers" "Scans Program Files & ProgramData for common leftover files"

Add-GroupTitle "Application Cleaners"
Add-Checkbox "AppCaches" "Common Application Caches" "Clears caches for Discord, Steam, Adobe, Spotify, Teams, etc."

Add-GroupTitle "Browser Cache Cleaners"
Add-Checkbox "Chrome" "Google Chrome Cache" "Clears Google Chrome's main cache folder"
Add-Checkbox "Edge" "Microsoft Edge Cache" "Clears Microsoft Edge's main cache folder"
Add-Checkbox "Firefox" "Mozilla Firefox Cache" "Clears Mozilla Firefox's cache folders for all profiles"
Add-Checkbox "Brave" "Brave Browser Cache" "Clears Brave Browser's main cache folder"
Add-Checkbox "Opera" "Opera GX/Stable Cache" "Clears Opera GX/Stable's main cache folder"

$script:currentRow++
$buttonY = $padding + ($script:currentRow * $controlHeight)

$selectAllButton = New-Object System.Windows.Forms.Button
$selectAllButton.Text = "Select All"; $selectAllButton.Size = New-Object System.Drawing.Size(100, 30)
$selectAllButton.Location = New-Object System.Drawing.Point($checkboxIndent, $buttonY)
$selectAllButton.Add_Click({ $checkboxes.Values | ForEach-Object { $_.Checked = $true }; Add-LogEntry "All items selected." })
$form.Controls.Add($selectAllButton)

$deselectAllButton = New-Object System.Windows.Forms.Button
$deselectAllButton.Text = "Deselect All"; $deselectAllButton.Size = New-Object System.Drawing.Size(100, 30)
$deselectAllButton.Location = New-Object System.Drawing.Point($checkboxIndent + 110, $buttonY)
$deselectAllButton.Add_Click({ $checkboxes.Values | ForEach-Object { $_.Checked = $false }; Add-LogEntry "All items deselected." })
$form.Controls.Add($deselectAllButton)
$script:currentRow += 2

$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Text = "Status: Idle"
$statusLabel.Location = New-Object System.Drawing.Point($labelIndent, $padding + ($script:currentRow * $controlHeight))
$statusLabel.AutoSize = $true
$form.Controls.Add($statusLabel)
$script:currentRow++

$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Location = New-Object System.Drawing.Point($labelIndent, $padding + ($script:currentRow * $controlHeight))
$progressBar.Size = New-Object System.Drawing.Size($formWidth - (2 * $labelIndent) - 20, 20)
$progressBar.Minimum = 0; $progressBar.Step = 1
$form.Controls.Add($progressBar)
$script:currentRow += 2

$startButton = New-Object System.Windows.Forms.Button
$startButton.Text = "Start Cleaning"; $startButton.Font = 'Microsoft Sans Serif,10,style=Bold'
$startButton.Size = New-Object System.Drawing.Size($formWidth - (2 * $labelIndent) - 20, 40)
$startButton.Location = New-Object System.Drawing.Point($labelIndent, $padding + ($script:currentRow * $controlHeight))
$form.Controls.Add($startButton)
$script:currentRow += 3

$logLabel = New-Object System.Windows.Forms.Label
$logLabel.Text = "Activity Log:"
$logLabel.Location = New-Object System.Drawing.Point($labelIndent, $padding + ($script:currentRow * $controlHeight) -10)
$logLabel.AutoSize = $true
$form.Controls.Add($logLabel)
$script:currentRow++

$logTextBox = New-Object System.Windows.Forms.TextBox
$logTextBox.Location = New-Object System.Drawing.Point($labelIndent, $padding + ($script:currentRow * $controlHeight) - 15)
$logTextBox.Size = New-Object System.Drawing.Size($formWidth - (2 * $labelIndent) - 20, 150)
$logTextBox.Multiline = $true; $logTextBox.ScrollBars = "Vertical"; $logTextBox.ReadOnly = $true
$logTextBox.Font = 'Consolas,8'
$form.Controls.Add($logTextBox)

# === Cleanup Functionality ===

function Clean-Path {
    param (
        [string]$PathPattern,
        [string]$ItemNameForLog = "Items"
    )
    $freedSpace = 0
    $errorsEncountered = $false
    $itemsFound = $false

    try {
        # Ensure PathPattern is a string and not empty
        if (-not ([string]::IsNullOrWhiteSpace($PathPattern))) {
            $expandedPathPattern = $ExecutionContext.InvokeCommand.ExpandString($PathPattern)

            # Test-Path the base if it's a wildcard pattern for folder contents
            $basePathToTest = $expandedPathPattern
            if ($expandedPathPattern.EndsWith("\*") -or $expandedPathPattern.EndsWith("\/")) {
                $basePathToTest = Split-Path -Path $expandedPathPattern -Parent
            }
            
            if (Test-Path $basePathToTest -ErrorAction SilentlyContinue) {
                $itemsToDelete = $null
                try {
                    $itemsToDelete = Get-ChildItem -Path $expandedPathPattern -Recurse -Force -ErrorAction SilentlyContinue
                } catch {
                    Add-LogEntry "Error enumerating items in '$ItemNameForLog' ($expandedPathPattern): $($_.Exception.Message)" "ERROR"
                    $errorsEncountered = $true
                }

                if ($itemsToDelete) {
                    $itemsFound = $true
                    Add-LogEntry "Found items to clean in '$ItemNameForLog' ($expandedPathPattern)..."
                    foreach ($item in $itemsToDelete) {
                        try {
                            $itemSize = $item.Length # Will be $null for directories, which is fine for +=
                            Remove-Item -Path $item.FullName -Recurse -Force -ErrorAction Stop
                            if ($itemSize -is [long] -and $itemSize -gt 0) {
                                $freedSpace += $itemSize
                            }
                        } catch {
                            # Don't log "Cannot find path" errors as they are common for temp files
                            if ($_.Exception.Message -notmatch "Cannot find path.*because it does not exist") {
                                Add-LogEntry "Error deleting $($item.FullName): $($_.Exception.Message)" "ERROR"
                                $errorsEncountered = $true
                            }
                        }
                    }
                } else {
                    if (-not $errorsEncountered) { # Only log if no enumeration error occurred
                        Add-LogEntry "No items to clean found in '$ItemNameForLog' ($expandedPathPattern)."
                    }
                }
            } else {
                Add-LogEntry "Base path not found for '$ItemNameForLog': $basePathToTest (from $expandedPathPattern)" "WARN"
            }
        } else {
            Add-LogEntry "Invalid or empty path pattern for '$ItemNameForLog'." "WARN"
            $errorsEncountered = $true
        }
    } catch {
        Add-LogEntry "General error processing '$ItemNameForLog' ($PathPattern): $($_.Exception.Message)" "ERROR"
        $errorsEncountered = $true
    }

    $freedMB = [math]::Round(($freedSpace / 1MB), 2)
    if ($itemsFound -and $freedMB -gt 0) {
        Add-LogEntry "Cleaned $ItemNameForLog. Freed: $freedMB MB."
    } elseif ($itemsFound -and $freedMB -eq 0 -and -not $errorsEncountered) {
         Add-LogEntry "Processed $ItemNameForLog. No significant space freed or items were empty."
    }
    return [PSCustomObject]@{ FreedSpace = $freedMB; ErrorsEncountered = $errorsEncountered }
}

function Clean-AppCachesPaths {
    $totalFreed = 0
    $anyErrors = $false
    # Same $appCachePaths definition as before (omitted for brevity)
    $appCachePaths = @{
        "Discord Cache" = @("$env:APPDATA\discord\Cache\*", "$env:APPDATA\discord\Code Cache\*");
        "Spotify Cache" = @("$env:APPDATA\Spotify\Storage\*", "$env:LOCALAPPDATA\Spotify\Data\*");
        "Epic Games Launcher Cache" = @("$env:LOCALAPPDATA\EpicGamesLauncher\Saved\webcache\*");
        "Battle.net Cache" = @("C:\ProgramData\Battle.net\Cache\*");
        "Steam Cache" = @("$env:ProgramFiles(x86)\Steam\appcache\*", "$env:ProgramFiles(x86)\Steam\steamapps\shadercache\*");
        "Adobe Common Cache" = @("$env:APPDATA\Adobe\Common\Media Cache Files\*");
        "Adobe Premiere Pro Cache" = @("$env:APPDATA\Adobe\Premiere Pro\*\Media Cache Files\*"); # Corrected to Media Cache Files
        "Microsoft Teams Cache" = @(
            Join-Path $env:APPDATA "Microsoft\Teams\Application Cache\Cache\*",
            Join-Path $env:APPDATA "Microsoft\Teams\Cache\*",
            Join-Path $env:APPDATA "Microsoft\Teams\GPUCache\*",
            Join-Path $env:APPDATA "Microsoft\Teams\blob_storage\*",
            Join-Path $env:APPDATA "Microsoft\Teams\databases\*",
            Join-Path $env:APPDATA "Microsoft\Teams\IndexedDB\*",
            Join-Path $env:APPDATA "Microsoft\Teams\Local Storage\*"
        );
        "Slack Cache" = @("$env:APPDATA\Slack\Cache\*", "$env:APPDATA\Slack\Service Worker\CacheStorage\*");
        "WhatsApp Cache" = @("$env:APPDATA\WhatsApp\Cache\*"); # May need UWP path if store app
        "Zoom Cache" = @("$env:APPDATA\Zoom\data\cache\*");
        "Telegram Desktop Cache" = @("$env:APPDATA\Telegram Desktop\tdata\user_data\cache\*"); 
        "Roblox Logs/Temp" = @("$env:LOCALAPPDATA\Roblox\logs\*", "$env:LOCALAPPDATA\Roblox\HTTP\*", "$env:LOCALAPPDATA\Roblox\versions\*\*.tmp");
        "Riot Client Cache" = @("$env:LOCALAPPDATA\Riot Games\Riot Client\Cache\*");
    }

    foreach ($appName in $appCachePaths.Keys) {
        $statusLabel.Text = "Cleaning: $appName..."; $form.Refresh()
        $pathsToClean = $appCachePaths[$appName]
        if ($pathsToClean -isnot [array]) { $pathsToClean = @($pathsToClean) } # Ensure it's an array

        foreach ($pathPattern_from_config in $pathsToClean) {
            $resolvedPath = ""
            try {
                $resolvedPath = $ExecutionContext.InvokeCommand.ExpandString($pathPattern_from_config)
            } catch {
                Add-LogEntry "Error expanding path pattern for $appName: $pathPattern_from_config. Error: $($_.Exception.Message)" "ERROR"
                $anyErrors = $true
                continue
            }
            
            if ([string]::IsNullOrWhiteSpace($resolvedPath)) {
                Add-LogEntry "Skipping empty resolved path for $appName from pattern $pathPattern_from_config." "WARN"
                continue
            }

            # Check for wildcards in directory segments (e.g., Adobe Premiere Pro\*)
            $pathLeaf = Split-Path -Path $resolvedPath -Leaf
            $pathParent = Split-Path -Path $resolvedPath -Parent

            if ($resolvedPath -match '\*' -and $pathParent -match '\*') { # Wildcard likely in a parent directory segment
                $basePathForWildcardExpansion = $resolvedPath.Substring(0, $resolvedPath.IndexOf('*'))
                $baseDirToEnumerate = Split-Path -Path $basePathForWildcardExpansion -Resolve # Get parent of the wildcard segment itself
                
                if (-not (Test-Path $baseDirToEnumerate)) {
                    Add-LogEntry "Base directory for wildcard expansion not found for $appName: $baseDirToEnumerate (from $resolvedPath)" "WARN"
                    continue
                }

                $childSegmentPattern = $resolvedPath.Substring($resolvedPath.IndexOf('*') + ($basePathForWildcardExpansion.Length - $baseDirToEnumerate.Length) ) # Relative path from enumerated dir
                
                Get-ChildItem -Path $baseDirToEnumerate -Directory -ErrorAction SilentlyContinue | Where-Object {$_.Name -like $basePathForWildcardExpansion.Split('\')[-1] } | ForEach-Object {
                    $expandedDir = $_
                    $fullPatternToClean = ""
                    try {
                        $fullPatternToClean = Join-Path -Path $expandedDir.FullName -ChildPath $childSegmentPattern
                    } catch {
                        Add-LogEntry "Error joining path for $appName: $($expandedDir.FullName) and $childSegmentPattern. Error: $($_.Exception.Message)" "ERROR"
                        $anyErrors = $true
                        continue # Skip this problematic joined path
                    }
                    $result = Clean-Path -PathPattern $fullPatternToClean -ItemNameForLog "$appName ($($expandedDir.Name))"
                    $totalFreed += $result.FreedSpace
                    if ($result.ErrorsEncountered) { $anyErrors = $true }
                }
            } else { # Standard pattern (wildcard in leaf or no wildcard)
                 $result = Clean-Path -PathPattern $resolvedPath -ItemNameForLog $appName
                 $totalFreed += $result.FreedSpace
                 if ($result.ErrorsEncountered) { $anyErrors = $true }
            }
        }
    }
    return [PSCustomObject]@{ FreedSpace = $totalFreed; ErrorsEncountered = $anyErrors }
}

$startButton.Add_Click({
    $startButton.Enabled = $false; $selectAllButton.Enabled = $false; $deselectAllButton.Enabled = $false
    $logMessages.Clear(); $logTextBox.Clear()
    Add-LogEntry "Starting cleanup process..."

    $totalFreedOverall = 0; $anyErrorsOverall = $false
    
    $selectedItems = $checkboxes.Values | Where-Object { $_.Checked }
    if ($selectedItems.Count -eq 0) {
        Add-LogEntry "No items selected for cleaning." "WARN"
        [System.Windows.Forms.MessageBox]::Show("No items selected for cleaning.", "Nothing to Do", "OK", "Information")
        $startButton.Enabled = $true; $selectAllButton.Enabled = $true; $deselectAllButton.Enabled = $true
        $statusLabel.Text = "Status: Idle"; return
    }

    $progressBar.Value = 0; $progressBar.Maximum = $selectedItems.Count

    foreach ($key in $checkboxes.Keys) {
        if ($checkboxes[$key].Checked) {
            $itemText = $checkboxes[$key].Text
            $statusLabel.Text = "Cleaning: $itemText..."; $form.Refresh()
            Add-LogEntry "Processing: $itemText"

            $result = $null; $currentFreed = 0; $currentErrors = $false

            try {
                switch ($key) {
                    "SystemTemp"    { $result = Clean-Path -PathPattern "$env:SystemRoot\Temp\*" -ItemNameForLog "System Temp" }
                    "UserTemp"      { $result = Clean-Path -PathPattern "$env:TEMP\*" -ItemNameForLog "User Temp" }
                    "Prefetch"      { $result = Clean-Path -PathPattern "$env:SystemRoot\Prefetch\*" -ItemNameForLog "Prefetch Data" }
                    "WindowsLogs"   {
                        $resWER = Clean-Path -PathPattern "$env:LOCALAPPDATA\Microsoft\Windows\WER\*" -ItemNameForLog "Windows Error Reporting"
                        $currentFreed += $resWER.FreedSpace
                        if ($resWER.ErrorsEncountered) { $currentErrors = $true }
                        
                        Add-LogEntry "Clearing Windows Event Logs..."
                        $eventLogs = Get-EventLog -List -ErrorAction SilentlyContinue
                        $clearedCount = 0
                        $errorCount = 0
                        for