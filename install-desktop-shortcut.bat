@echo off
chcp 65001 >nul
cd /d "%~dp0"

set "TARGET=%~dp0start-gbf.bat"
set "DESKTOP=%USERPROFILE%\Desktop"
set "LINK=%DESKTOP%\GBFレビュー返信.lnk"

powershell -NoProfile -Command ^
  "$ws = New-Object -ComObject WScript.Shell; ^
   $sc = $ws.CreateShortcut('%LINK%'); ^
   $sc.TargetPath = '%TARGET%'; ^
   $sc.WorkingDirectory = '%~dp0'; ^
   $sc.WindowStyle = 7; ^
   $sc.Description = 'Goodbeer faucets レビュー返信を起動'; ^
   $sc.Save()"

if exist "%LINK%" (
  echo デスクトップにショートカットを作成しました:
  echo   %LINK%
) else (
  echo ショートカットの作成に失敗しました。
  pause
  exit /b 1
)

timeout /t 3 >nul
