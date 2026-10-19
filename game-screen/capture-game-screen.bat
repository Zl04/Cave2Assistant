@echo off
setlocal EnableExtensions EnableDelayedExpansion

where adb >nul 2>&1
if errorlevel 1 (
    echo Error: adb was not found in PATH.
    pause
    exit /b 1
)

set "count=0"
for /f "skip=1 tokens=1,2" %%A in ('adb devices') do (
    if "%%B"=="device" (
        set /a count+=1
        set "device[!count!]=%%A"
    )
)

if !count! equ 0 (
    echo No connected and authorized Android device was found.
    pause
    exit /b 1
)

if !count! equ 1 (
    set "serial=!device[1]!"
    echo Using device: !serial!
    goto capture
)

echo Connected devices:
for /l %%I in (1,1,!count!) do echo   %%I. !device[%%I]!

:choose_device
set "choice="
set /p "choice=Select a device number (1-!count!): "
set "serial="
for /l %%I in (1,1,!count!) do if "!choice!"=="%%I" set "serial=!device[%%I]!"
if not defined serial (
    echo Invalid selection.
    goto choose_device
)

:capture
for /f %%T in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd_HH-mm-ss-fff"') do set "timestamp=%%T"
if not defined timestamp (
    echo Error: could not get the current time.
    pause
    exit /b 1
)

set "output=%~dp0!timestamp!.png"
adb -s "!serial!" exec-out screencap -p > "!output!"
if errorlevel 1 goto capture_failed
for %%F in ("!output!") do if %%~zF equ 0 goto capture_failed

echo Screenshot saved: !output!
exit /b 0

:capture_failed
del /q "!output!" >nul 2>&1
echo Error: screenshot failed.
pause
exit /b 1
