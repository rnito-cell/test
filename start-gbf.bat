@echo off
chcp 65001 >nul
cd /d "%~dp0"

where node >nul 2>&1
if errorlevel 1 (
  echo Node.js が見つかりません。https://nodejs.org/ からインストールしてください。
  pause
  exit /b 1
)

if not exist "node_modules\" (
  echo 初回セットアップ: npm install を実行します...
  call npm.cmd install
  if errorlevel 1 (
    echo npm install に失敗しました。
    pause
    exit /b 1
  )
)

echo GBF レビュー返信を起動しています...
start "GBF Review Reply" cmd /c "npm.cmd run dev"

echo サーバー起動を待っています...
set /a tries=0
:waitloop
set /a tries+=1
if %tries% gtr 60 (
  echo 起動がタイムアウトしました。ターミナルのエラーを確認してください。
  pause
  exit /b 1
)
powershell -NoProfile -Command "try { (Invoke-WebRequest -UseBasicParsing http://localhost:5173/ -TimeoutSec 2).StatusCode | Out-Null; exit 0 } catch { exit 1 }" >nul 2>&1
if errorlevel 1 (
  timeout /t 1 /nobreak >nul
  goto waitloop
)

start "" "http://localhost:5173/"
echo ブラウザを開きました。このウィンドウは閉じても構いません。
timeout /t 3 >nul
