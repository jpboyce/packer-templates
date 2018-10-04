:: Windows 2012 R2 Update
:: November 2014 update rollup for Windows 8.1 and Windows Server 2012 R2
:: KB3000850

@ echo off

set KB3000850="C:\Windows\Temp\Windows8.1-KB3000850-x64.msu"
set KB3003057="C:\Windows\Temp\Windows8.1-KB3003057-x64.msu"
set KB3016437="C:\Windows\Temp\Windows8.1-KB3016437-x64.msu"
set KB3014442="C:\Windows\Temp\Windows8.1-KB3014442-x64.msu"

@echo on

start /wait wusa "%KB3000850%" /quiet /log
