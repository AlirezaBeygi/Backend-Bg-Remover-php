@echo off
echo ====================================
echo Checking Backend Status
echo ====================================
echo.

echo [1] Checking .env file...
if exist .env (
    echo .env file exists
) else (
    echo ERROR: .env file not found!
    echo Please run: create_env.bat
    pause
    exit /b 1
)
echo.

echo [2] Checking APP_KEY...
findstr /C:"APP_KEY=" .env | findstr /V "APP_KEY=$" >nul
if %errorlevel% equ 0 (
    echo APP_KEY is set
) else (
    echo WARNING: APP_KEY is not set!
    echo Please run: php artisan key:generate
)
echo.

echo [3] Checking JWT_SECRET...
findstr /C:"JWT_SECRET=" .env | findstr /V "JWT_SECRET=$" >nul
if %errorlevel% equ 0 (
    echo JWT_SECRET is set
) else (
    echo WARNING: JWT_SECRET is not set!
    echo Please run: php artisan jwt:secret
)
echo.

echo [4] Checking database connection...
php artisan tinker --execute="DB::connection()->getPdo(); echo 'Database connection OK';" 2>nul
if %errorlevel% equ 0 (
    echo Database connection OK
) else (
    echo ERROR: Database connection failed!
    echo Please check:
    echo   1. MySQL is running in Xampp
    echo   2. Database 'bgremover_db' exists
    echo   3. .env file has correct database credentials
)
echo.

echo [5] Checking storage/logs directory...
if exist "storage\logs\laravel.log" (
    echo Laravel log file exists
    echo.
    echo Last 10 lines of log:
    powershell -Command "Get-Content 'storage\logs\laravel.log' -Tail 10"
) else (
    echo WARNING: Laravel log file not found
)
echo.

echo ====================================
echo Status check completed!
echo ====================================
echo.
pause

