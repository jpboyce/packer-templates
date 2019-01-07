:: Sets Windows Updates Behaviour

:: Set behaviour to Notify of download and install
:: Reference: https://support.microsoft.com/en-au/help/328010/how-to-configure-automatic-updates-by-using-group-policy-or-registry-s
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v AUOptions /t REG_DWORD /d 1 /f
