@echo off
:: Check for admin rights
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Relaunching with administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: Run PowerShell and keep the window open
powershell -NoExit -NoProfile -ExecutionPolicy Bypass -File "%~dp0run_pktmon.ps1"