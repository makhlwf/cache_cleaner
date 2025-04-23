### CACHE CLEANER
A very simple cash cleaner script to clean some cash and leftover files that it's not important at all and just taking a system space

###TO USE

open powershell and Paste this command

```
Start-Process powershell -ArgumentList "Set-ExecutionPolicy RemoteSigned -Scope Process -Force; Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/makhlwf/cache_cleaner/refs/heads/main/cache_cleaner_by_makhlwf.ps1' -OutFile 'cache_cleaner.ps1'; .\cache_cleaner.ps1" -Verb RunAs
```
