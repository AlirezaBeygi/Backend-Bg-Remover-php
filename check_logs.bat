@echo off
echo ====================================
echo Checking Laravel Logs
echo ====================================
echo.

if exist "storage\logs\laravel.log" (
    echo Last 30 lines of Laravel log:
    echo.
    powershell -Command "Get-Content 'storage\logs\laravel.log' -Tail 30"
    echo.
    echo ====================================
    echo.
    echo To see full log, open: storage\logs\laravel.log
) else (
    echo ERROR: Laravel log file not found!
    echo.
    echo Make sure:
    echo   1. Storage\logs directory exists
    echo   2. Laravel has write permission
    echo.
    echo Creating logs directory...
    if not exist "storage\logs" mkdir "storage\logs"
    echo Directory created. Try your request again.
)
echo.
pause

