:: Windows 2012 R2 Update
:: Windows Server 2012 R2 update: April 2014
:: KB2919355
:: Prereqs: KB2919442

@ echo off

set compflag="D:\clearcompressionflag.exe"
set KB2919355="D:\Windows8.1-KB2919355-x64.msu"
set KB2932046="D:\Windows8.1-KB2932046-x64.msu"
set KB2959977="D:\Windows8.1-KB2959977-x64.msu"
set KB2937592="D:\Windows8.1-KB2937592-x64.msu"
set KB2938439="D:\Windows8.1-KB2938439-x64.msu"
set KB2934018="D:\Windows8.1-KB2934018-x64.msu"

@echo on

:: start /wait "%compflag%"
start /wait wusa "%KB2938439%" /quiet /log
