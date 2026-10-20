@echo off
setlocal EnableExtensions

set "PROJECT_DIR=%~dp0"
set "PROJECT_FILE=%PROJECT_DIR%AdbMapController.csproj"
set "PUBLISH_DIR=%PROJECT_DIR%publish"

cd /d "%PROJECT_DIR%"

if not exist "%PROJECT_FILE%" (
    echo Project file not found: "%PROJECT_FILE%"
    exit /b 1
)

echo Stopping running project processes...
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command ^
  "$publishDir = [IO.Path]::GetFullPath('%PUBLISH_DIR%').TrimEnd([IO.Path]::DirectorySeparatorChar) + [IO.Path]::DirectorySeparatorChar; foreach ($p in (Get-Process -ErrorAction Stop)) { try { $exe = $p.Path } catch { continue }; if ($exe -and $exe.StartsWith($publishDir, [StringComparison]::OrdinalIgnoreCase)) { Stop-Process -Id $p.Id -Force -ErrorAction Stop } }"
if errorlevel 1 goto :stop_failed

echo Publishing Release build...
dotnet publish "%PROJECT_FILE%" -c Release
if errorlevel 1 goto :publish_failed

if not exist "%PUBLISH_DIR%\*.exe" goto :artifact_missing
if not exist "%PUBLISH_DIR%\*.runtimeconfig.json" goto :artifact_missing

echo Cleaning intermediate files...
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command ^
  "$root = [IO.Path]::GetFullPath('%PUBLISH_DIR%').TrimEnd([IO.Path]::DirectorySeparatorChar); foreach ($name in @('.build', 'bin', 'obj')) { $target = [IO.Path]::GetFullPath([IO.Path]::Combine($root, $name)); if (-not $target.StartsWith($root + [IO.Path]::DirectorySeparatorChar, [StringComparison]::OrdinalIgnoreCase)) { throw 'Unsafe cleanup path' }; if (Test-Path -LiteralPath $target) { $item = Get-Item -LiteralPath $target -Force; if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) { throw 'Refusing to remove a reparse point' }; Remove-Item -LiteralPath $target -Recurse -Force -ErrorAction Stop } }"
if errorlevel 1 goto :cleanup_failed

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
echo Failed to remove intermediate files from "%PUBLISH_DIR%".
exit /b 1

:artifact_missing
echo Published application files were not found in: "%PUBLISH_DIR%"
exit /b 1
