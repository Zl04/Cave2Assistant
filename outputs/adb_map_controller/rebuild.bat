@echo off
setlocal EnableExtensions

set "PROJECT_DIR=%~dp0"
set "PROJECT_FILE=%PROJECT_DIR%AdbMapController.csproj"
set "PUBLISH_DIR=%PROJECT_DIR%publish"
set "BUILD_TEMP=%PUBLISH_DIR%\.build"

cd /d "%PROJECT_DIR%"

if not exist "%PROJECT_FILE%" (
    echo Project file not found: "%PROJECT_FILE%"
    exit /b 1
)

echo Stopping running project processes...
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command ^
  "$publishDir = [IO.Path]::GetFullPath('%PUBLISH_DIR%'); foreach ($p in (Get-CimInstance Win32_Process)) { if ($p.ExecutablePath -and $p.ExecutablePath.StartsWith($publishDir, [StringComparison]::OrdinalIgnoreCase)) { Stop-Process -Id $p.ProcessId -Force -ErrorAction SilentlyContinue } }"
if errorlevel 1 goto :stop_failed

echo Publishing Release build...
dotnet publish "%PROJECT_FILE%" -c Release
if errorlevel 1 goto :publish_failed

if exist "%BUILD_TEMP%" (
    echo Cleaning intermediate files...
    rmdir /s /q "%BUILD_TEMP%"
)
if exist "%BUILD_TEMP%" goto :cleanup_failed

if not exist "%PUBLISH_DIR%\*.runtimeconfig.json" goto :artifact_missing

echo Build succeeded.
echo Output directory: "%PUBLISH_DIR%"
exit /b 0

:stop_failed
echo Failed to stop running project processes.
exit /b 1

:publish_failed
echo Publish failed.
exit /b 1

:cleanup_failed
echo Failed to remove "%BUILD_TEMP%".
exit /b 1

:artifact_missing
echo Published runtime configuration was not found in: "%PUBLISH_DIR%"
exit /b 1
