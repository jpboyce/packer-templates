:: Windows 2012 R2 Update
:: Windows Server 2012 R2 update: April 2014
:: KB2919355
:: Prereqs: KB2919442

@ echo off

set compflag="C:\Windows\Temp\clearcompressionflag.exe"
set KB2919355="C:\Windows\Temp\Windows8.1-KB2919355-x64.msu"
set KB2932046="C:\Windows\Temp\Windows8.1-KB2932046-x64.msu"
set KB2959977="C:\Windows\Temp\Windows8.1-KB2959977-x64.msu"
set KB2937592="C:\Windows\Temp\Windows8.1-KB2937592-x64.msu"
set KB2938439="C:\Windows\Temp\Windows8.1-KB2938439-x64.msu"
set KB2934018="C:\Windows\Temp\Windows8.1-KB2934018-x64.msu"

@echo on

:: start /wait "%compflag%"
start /wait wusa "%KB2932046%" /quiet /log
