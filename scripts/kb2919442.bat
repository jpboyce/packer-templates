:: Windows 2012 R2 Update
:: March 2014 servicing stack update for Windows 8.1 and Windows Server 2012 R2
:: KB2919442

@echo on
set KB2919442="D:\Windows8.1-KB2919442-x64.msu"

:: IF NOT EXIST %KB2919442% @powershell -NoProfile -ExecutionPolicy Bypass -Command "((new-object net.webclient).DownloadFile('https://download.microsoft.com/download/D/6/0/D60ED3E0-93A5-4505-8F6A-8D0A5DA16C8A/Windows8.1-KB2919442-x64.msu', 'C:\Windows\Temp\Windows8.1-KB2919442-x64.msu'))"

start /wait wusa "%KB2919442%" /quiet /log
