:: Windows 2012 R2 Update
:: Windows Server 2012 R2 update: April 2014
:: KB2919355
:: Prereqs: KB2919442
@echo on

set compflag="C:\Windows\Temp\clearcompressionflag.exe"
set KB2919355="C:\Windows\Temp\Windows8.1-KB2919355-x64.msu"
set KB2932046="C:\Windows\Temp\Windows8.1-KB2932046-x64.msu"
set KB2959977="C:\Windows\Temp\Windows8.1-KB2959977-x64.msu"
set KB2937592="C:\Windows\Temp\Windows8.1-KB2937592-x64.msu"
set KB2938439="C:\Windows\Temp\Windows8.1-KB2938439-x64.msu"
set KB2934018="C:\Windows\Temp\Windows8.1-KB2934018-x64.msu"

:: Do Downloads
:: Clear Compression Flag
:: https://download.microsoft.com/download/2/5/6/256CCCFB-5341-4A8D-A277-8A81B21A1E35/clearcompressionflag.exe
IF NOT EXIST %compflag% @powershell -NoProfile -ExecutionPolicy Bypass -Command "((new-object net.webclient).DownloadFile('https://download.microsoft.com/download/2/5/6/256CCCFB-5341-4A8D-A277-8A81B21A1E35/clearcompressionflag.exe', 'C:\Windows\Temp\clearcompressionflag.exe'))"
:: KB2919355
:: https://download.microsoft.com/download/2/5/6/256CCCFB-5341-4A8D-A277-8A81B21A1E35/Windows8.1-KB2919355-x64.msu
IF NOT EXIST %KB2919355% @powershell -NoProfile -ExecutionPolicy Bypass -Command "((new-object net.webclient).DownloadFile('https://download.microsoft.com/download/2/5/6/256CCCFB-5341-4A8D-A277-8A81B21A1E35/Windows8.1-KB2919355-x64.msu', 'C:\Windows\Temp\Windows8.1-KB2919355-x64.msu'))"
:: KB2932046 (Feature Pack)
:: https://download.microsoft.com/download/2/5/6/256CCCFB-5341-4A8D-A277-8A81B21A1E35/Windows8.1-KB2932046-x64.msu
IF NOT EXIST %KB2932046% @powershell -NoProfile -ExecutionPolicy Bypass -Command "((new-object net.webclient).DownloadFile('https://download.microsoft.com/download/2/5/6/256CCCFB-5341-4A8D-A277-8A81B21A1E35/Windows8.1-KB2932046-x64.msu', 'C:\Windows\Temp\Windows8.1-KB2932046-x64.msu'))"
:: KB2959977
:: https://download.microsoft.com/download/2/5/6/256CCCFB-5341-4A8D-A277-8A81B21A1E35/Windows8.1-KB2959977-x64.msu
:: Requires a restart
IF NOT EXIST %KB2959977% @powershell -NoProfile -ExecutionPolicy Bypass -Command "((new-object net.webclient).DownloadFile('https://download.microsoft.com/download/2/5/6/256CCCFB-5341-4A8D-A277-8A81B21A1E35/Windows8.1-KB2959977-x64.msu', 'C:\Windows\Temp\Windows8.1-KB2959977-x64.msu'))"
:: KB2937592
:: https://download.microsoft.com/download/2/5/6/256CCCFB-5341-4A8D-A277-8A81B21A1E35/Windows8.1-KB2937592-x64.msu
IF NOT EXIST %KB2937592% @powershell -NoProfile -ExecutionPolicy Bypass -Command "((new-object net.webclient).DownloadFile('https://download.microsoft.com/download/2/5/6/256CCCFB-5341-4A8D-A277-8A81B21A1E35/Windows8.1-KB2937592-x64.msu', 'C:\Windows\Temp\Windows8.1-KB2937592-x64.msu'))"
:: KB2938439
:: https://download.microsoft.com/download/2/5/6/256CCCFB-5341-4A8D-A277-8A81B21A1E35/Windows8.1-KB2938439-x64.msu
IF NOT EXIST %KB2938439% @powershell -NoProfile -ExecutionPolicy Bypass -Command "((new-object net.webclient).DownloadFile('https://download.microsoft.com/download/2/5/6/256CCCFB-5341-4A8D-A277-8A81B21A1E35/Windows8.1-KB2938439-x64.msu', 'C:\Windows\Temp\Windows8.1-KB2938439-x64.msu'))"
:: KB2934018
:: https://download.microsoft.com/download/2/5/6/256CCCFB-5341-4A8D-A277-8A81B21A1E35/Windows8.1-KB2934018-x64.msu
IF NOT EXIST %KB2934018% @powershell -NoProfile -ExecutionPolicy Bypass -Command "((new-object net.webclient).DownloadFile('https://download.microsoft.com/download/2/5/6/256CCCFB-5341-4A8D-A277-8A81B21A1E35/Windows8.1-KB2934018-x64.msu', 'C:\Windows\Temp\Windows8.1-KB2934018-x64.msu'))"
