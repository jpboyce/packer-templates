:: Windows 2012 R2 Update
:: November 2014 update rollup for Windows 8.1 and Windows Server 2012 R2
:: KB3000850

@ echo off

set KB3000850="D:\Windows8.1-KB3000850-x64.msu"
set KB3003057="D:\Windows8.1-KB3003057-x64.msu"
set KB3016437="D:\Windows8.1-KB3016437-x64.msu"
set KB3014442="D:\Windows8.1-KB3014442-x64.msu"

@echo on

start /wait wusa "%KB3016437%" /quiet /log
