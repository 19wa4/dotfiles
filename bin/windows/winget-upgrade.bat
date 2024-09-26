@REM @echo off
@echo on
@REM Run as administrator.

call :main
exit /b

:main
    chcp 65001>nul
    cd /d %~dp0

    @REM winget settings --enable InstallerHashOverride

    winget install --ignore-security-hash Alacritty.Alacritty
    winget install --ignore-security-hash Amazon.Kindle
    winget install --ignore-security-hash LINE.LINE
    winget install --ignore-security-hash Microsoft.VisualStudioCode
    winget install --ignore-security-hash Mozilla.Firefox
    winget install --ignore-security-hash Zoom.Zoom.EXE
    winget upgrade --ignore-security-hash --all

    pause
exit /b
