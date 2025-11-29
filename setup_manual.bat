@echo off
echo ====================================
echo Background Remover API - Manual Setup
echo ====================================
echo.
echo This script will guide you through manual setup steps.
echo.

echo Step 1: Install Composer Dependencies
echo ----------------------------------------
echo Please run ONE of the following commands:
echo.
echo   Option A (if Composer is installed):
echo     composer install
echo.
echo   Option B (using Composer PHAR):
echo     php composer.phar install
echo.
echo   Option C (using full PHP path):
echo     C:\xampp\php\php.exe composer.phar install
echo.
pause
echo.

echo Step 2: Create .env file
echo ----------------------------------------
if not exist .env (
    copy .env.example .env
    echo .env file created from .env.example
    echo Please edit .env and set your database credentials
) else (
    echo .env file already exists
)
echo.
pause
echo.

echo Step 3: Generate Application Key
echo ----------------------------------------
echo Please run:
echo   php artisan key:generate
echo   OR
echo   C:\xampp\php\php.exe artisan key:generate
echo.
pause
echo.

echo Step 4: Generate JWT Secret
echo ----------------------------------------
echo Please run:
echo   php artisan jwt:secret
echo   OR
echo   C:\xampp\php\php.exe artisan jwt:secret
echo.
pause
echo.

echo Step 5: Run Migrations
echo ----------------------------------------
echo Make sure you have created the database 'bgremover_db' in phpMyAdmin
echo Then run:
echo   php artisan migrate
echo   OR
echo   C:\xampp\php\php.exe artisan migrate
echo.
pause
echo.

echo Step 6: Seed Database
echo ----------------------------------------
echo Please run:
echo   php artisan db:seed
echo   OR
echo   C:\xampp\php\php.exe artisan db:seed
echo.
pause
echo.

echo Step 7: Create Storage Link
echo ----------------------------------------
echo Please run:
echo   php artisan storage:link
echo   OR
echo   C:\xampp\php\php.exe artisan storage:link
echo.
pause
echo.

echo ====================================
echo Setup instructions completed!
echo ====================================
echo.
echo Test user credentials:
echo   Username: testuser
echo   Password: password123
echo.
echo API URL: http://localhost/backend/public/api
echo.
pause

