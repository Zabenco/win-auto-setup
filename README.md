# Windows Auto-Setup Script

A single-script PowerShell automation for setting up Windows 10/11 systems — ideal for IT professionals, field technicians, and sysadmins who want to streamline software installs, apply user preferences, and optionally configure network settings.

---

## Features

- Installs common software silently using `winget`:
  - Google Chrome
  - Notepad++
  - 7-Zip
  - Adobe Acrobat Reader
  - Zoom
  - Microsoft Office (manual step)
  - Microsoft Teams

- Applies system preferences:
  - Enables dark mode for system + apps
  - Shows file extensions
  - Shows hidden files
  - Uses small taskbar icons
  - Disables Windows tips

- Optional network configuration:
  - Static IP, gateway, subnet, and DNS setup
  - Adapter selection from available interfaces

- Creates a timestamped log of everything done
- Fully self-contained — **no dependencies, no downloads**

---

## Usage

**Run from PowerShell as Administrator:**

```powershell
iwr -useb https://raw.githubusercontent.com/Zabenco/win-auto-setup/main/auto-setup.ps1 | iex
```
Or bypass execution policy:
```powershell
powershell -ExecutionPolicy Bypass -Command "iwr -useb https://raw.githubusercontent.com/Zabenco/win-auto-setup/main/auto-setup.ps1 | iex"
```

## What Happens
1. Script starts with a friendly prompt and begins logging all activity to .\logs\setup-log-[timestamp].txt.
2. Installs all predefined software using winget.
3. Asks if you’d like to configure network settings:
* If yes, prompts for adapter, IP, subnet, gateway, DNS
* If no, skips and continues
4. Applies system-wide preferences for a better user experience.
5. Script ends with a friendly message and saves the log.

## Why Did I Create This
As someone who has worked in the field and from office with tech and desktop support, I created this script to save time during the provisioning and settinmg up of post-imaging setups and personal system refreshes. It reflects real workload that I use, just automated in one easy to use file.

## About Me
My name is Ethan Zabenco

I am an IT Support Technician and aspiring Cybersecurity professional.

LinkedIn: https://www.linkedin.com/in/ezabenco


