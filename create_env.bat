@echo off
echo ====================================
echo Creating .env file
echo ====================================
echo.

if exist .env (
    echo .env file already exists!
    echo.
    choice /C YN /M "Do you want to overwrite it"
    if errorlevel 2 goto :end
    if errorlevel 1 goto :create
)

:create
echo Creating .env file...
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
) > .env

echo.
echo .env file created successfully!
echo.
echo IMPORTANT: Please edit .env file and verify:
echo   - DB_DATABASE=bgremover_db
echo   - DB_USERNAME=root
echo   - DB_PASSWORD= (leave empty if no password)
echo.
:end
pause

