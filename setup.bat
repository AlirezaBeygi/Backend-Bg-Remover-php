@echo off
echo ====================================
echo Background Remover API Setup
echo ====================================
echo.

echo Checking for Composer...
where composer >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo WARNING: Composer is not installed or not in PATH!
    echo.
    echo Please install Composer first:
    echo   1. Download from: https://getcomposer.org/download/
    echo   2. Run Composer-Setup.exe
    echo   3. Select PHP path: C:\xampp\php\php.exe
    echo.
    echo OR use Composer PHAR:
    echo   1. Download composer.phar to this folder
    echo   2. Run: php composer.phar install
    echo.
    pause
    exit /b 1
)

echo [1/7] Installing Composer dependencies...
call composer install
if errorlevel 1 (
    echo.
    echo Trying with php composer.phar...
    if exist composer.phar (
        call php composer.phar install
        if errorlevel 1 (
            echo ERROR: Composer install failed!
            pause
            exit /b 1
        )
    ) else (
        echo ERROR: Composer install failed!
        echo Please check INSTALL_COMPOSER.md for help
        pause
        exit /b 1
    )
)
echo.

echo [2/7] Creating .env file...
if not exist .env.example (
    echo .env.example not found, creating it...
    (
    echo APP_NAME="Background Remover API"
    echo APP_ENV=local
    echo APP_KEY=
    echo APP_DEBUG=true
    echo APP_TIMEZONE=UTC
    echo APP_URL=http://localhost/backend/public
    echo.
    echo APP_LOCALE=en
    echo APP_FALLBACK_LOCALE=en
    echo APP_FAKER_LOCALE=en_US
    echo.
    echo APP_MAINTENANCE_DRIVER=file
    echo APP_MAINTENANCE_STORE=database
    echo.
    echo BCRYPT_ROUNDS=12
    echo.
    echo LOG_CHANNEL=stack
    echo LOG_STACK=single
    echo LOG_DEPRECATIONS_CHANNEL=null
    echo LOG_LEVEL=debug
    echo.
    echo DB_CONNECTION=mysql
    echo DB_HOST=127.0.0.1
    echo DB_PORT=3306
    echo DB_DATABASE=bgremover_db
    echo DB_USERNAME=root
    echo DB_PASSWORD=
    echo.
    echo SESSION_DRIVER=database
    echo SESSION_LIFETIME=120
    echo SESSION_ENCRYPT=false
    echo SESSION_PATH=/
    echo SESSION_DOMAIN=null
    echo.
    echo BROADCAST_CONNECTION=log
    echo FILESYSTEM_DISK=local
    echo QUEUE_CONNECTION=database
    echo.
    echo CACHE_STORE=database
    echo CACHE_PREFIX=
    echo.
    echo MEMCACHED_HOST=127.0.0.1
    echo.
    echo REDIS_CLIENT=phpredis
    echo REDIS_HOST=127.0.0.1
    echo REDIS_PASSWORD=null
    echo REDIS_PORT=6379
    echo.
    echo MAIL_MAILER=log
    echo MAIL_HOST=127.0.0.1
    echo MAIL_PORT=2525
    echo MAIL_USERNAME=null
    echo MAIL_PASSWORD=null
    echo MAIL_ENCRYPTION=null
    echo MAIL_FROM_ADDRESS="hello@example.com"
    echo MAIL_FROM_NAME="${APP_NAME}"
    echo.
    echo JWT_SECRET=
    echo JWT_TTL=60
    ) > .env.example
    echo .env.example created.
)
if not exist .env (
    copy .env.example .env >nul
    echo .env file created from .env.example
    echo.
    echo IMPORTANT: Please edit .env file and set your database credentials!
    echo   DB_DATABASE=bgremover_db
    echo   DB_USERNAME=root
    echo   DB_PASSWORD=
    echo.
) else (
    echo .env file already exists, skipping...
)
echo.

echo [3/7] Generating Application Key...
call php artisan key:generate
if errorlevel 1 (
    echo ERROR: Failed to generate application key!
    pause
    exit /b 1
)
echo.

echo [4/7] Generating JWT Secret...
call php artisan jwt:secret
if errorlevel 1 (
    echo ERROR: Failed to generate JWT secret!
    pause
    exit /b 1
)
echo.

echo [5/7] Running migrations...
call php artisan migrate
if errorlevel 1 (
    echo ERROR: Migration failed! Make sure database is created and configured in .env
    pause
    exit /b 1
)
echo.

echo [6/7] Seeding database...
call php artisan db:seed
if errorlevel 1 (
    echo.
    echo WARNING: Seeding failed! This might be because user already exists.
    echo You can ignore this if testuser already exists in database.
    echo.
    echo To fix: Delete testuser from database and run: php artisan db:seed
    echo.
)
echo.

echo [7/7] Creating storage link...
if exist "public\storage" (
    echo Storage link already exists, skipping...
) else (
    call php artisan storage:link
    if errorlevel 1 (
        echo WARNING: Storage link creation failed
    )
)
echo.

echo ====================================
echo Setup completed successfully!
echo ====================================
echo.
echo Test user credentials:
echo   Username: testuser
echo   Password: password123
echo.
echo API URL: http://localhost/backend/public/api
echo.
echo Don't forget to:
echo   1. Create database 'bgremover_db' in phpMyAdmin
echo   2. Update .env file with your database credentials
echo   3. Update Android app Base URL to your local IP
echo.
pause

