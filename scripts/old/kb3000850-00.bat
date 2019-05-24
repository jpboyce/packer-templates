:: Windows 2012 R2 Update
:: November 2014 update rollup for Windows 8.1 and Windows Server 2012 R2
:: KB3000850

@echo on
set KB3000850="D:\Windows8.1-KB3000850-x64.msu"
set KB3003057="D:\Windows8.1-KB3003057-x64.msu"
set KB3016437="D:\Windows8.1-KB3016437-x64.msu"
set KB3014442="D:\Windows8.1-KB3014442-x64.msu"

:: KB3000850
:: https://download.microsoft.com/download/D/C/6/DC69B595-9C62-4B31-B154-B3722250D296/Windows8.1-KB3000850-x64.msu
IF NOT EXIST %KB3000850% @powershell -NoProfile -ExecutionPolicy Bypass -Command "((new-object net.webclient).DownloadFile('https://download.microsoft.com/download/D/C/6/DC69B595-9C62-4B31-B154-B3722250D296/Windows8.1-KB3000850-x64.msu', 'C:\Windows\Temp\Windows8.1-KB3000850-x64.msu'))"

:: KB3003057
:: https://download.microsoft.com/download/D/C/6/DC69B595-9C62-4B31-B154-B3722250D296/Windows8.1-KB3003057-x64.msu
IF NOT EXIST %KB3003057% @powershell -NoProfile -ExecutionPolicy Bypass -Command "((new-object net.webclient).DownloadFile('https://download.microsoft.com/download/D/C/6/DC69B595-9C62-4B31-B154-B3722250D296/Windows8.1-KB3003057-x64.msu', 'C:\Windows\Temp\Windows8.1-KB3003057-x64.msu'))"

:: KB3016437
:: https://download.microsoft.com/download/D/C/6/DC69B595-9C62-4B31-B154-B3722250D296/Windows8.1-KB3016437-x64.msu
IF NOT EXIST %KB3016437% @powershell -NoProfile -ExecutionPolicy Bypass -Command "((new-object net.webclient).DownloadFile('https://download.microsoft.com/download/D/C/6/DC69B595-9C62-4B31-B154-B3722250D296/Windows8.1-KB3016437-x64.msu', 'C:\Windows\Temp\Windows8.1-KB3016437-x64.msu'))"

:: KB3014442
:: https://download.microsoft.com/download/D/C/6/DC69B595-9C62-4B31-B154-B3722250D296/Windows8.1-KB3014442-x64.msu
IF NOT EXIST %KB3014442% @powershell -NoProfile -ExecutionPolicy Bypass -Command "((new-object net.webclient).DownloadFile('https://download.microsoft.com/download/D/C/6/DC69B595-9C62-4B31-B154-B3722250D296/Windows8.1-KB3014442-x64.msu', 'C:\Windows\Temp\Windows8.1-KB3014442-x64.msu'))"
