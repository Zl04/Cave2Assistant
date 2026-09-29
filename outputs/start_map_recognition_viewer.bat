@echo off
setlocal
set "APP_DIR=%~dp0"
set "CODEX_PY=C:\Users\Warrior.zeng\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe"
if exist "%CODEX_PY%" (
  "%CODEX_PY%" "%APP_DIR%map_recognition_viewer.py"
) else (
  py "%APP_DIR%map_recognition_viewer.py"
)
if errorlevel 1 pause
