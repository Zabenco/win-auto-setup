# Custom Windows Auto-Setup

Created this to aid with setting up computers for primarily business settings, but can also set up for residential settings, as I started on it while I ran Ethan's Computer Repair

## Purpose

I honestly was tired of installing things individually, and I found I was installing the same couple of programs when setting up customer's computers, so I created this to automate the process.

-UPDATE- (12/03/2024) With me working at Essential Network Technologies, I changed up the script to now include business based and productivity programs and features instead of a handful of programs for a residential environment.

## Features

- Single script design, just run one command, or download the ps1 file
- Installs software via Winget
- Applies preferred system settings (e.g., setting dark mode, disabling any distracting features)
- Enables file extensions and hidden folders
- Can set a static IP or DNS (This is optional)
- Logs all actions performed

## Tools I Use

- Powershell
- Winget
- Registry Edits
- Windows built-in utilities

## How to Use

- If on USB Drive: Right-Click => Run with Powershell (as Admin)
- You can run this script on any fresh Windows machine via PowerShell:

```powershell
iwr -useb https://raw.githubusercontent.com/Zabenco/win-auto-setup/main/auto-setup.ps1 | iex
```


## Notes

Make sure you run "Set-ExecutionPolicy Bypass -Scope Process -Force" before running the program