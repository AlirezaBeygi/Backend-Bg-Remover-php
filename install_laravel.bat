@echo off
echo ====================================
echo Checking Laravel Installation
echo ====================================
echo.

cd /d "%~dp0"

echo [1] Checking vendor directory...
if exist "vendor" (
    echo ✅ vendor directory exists
) else (
    echo ❌ vendor directory NOT found
    echo.
    echo Laravel dependencies are not installed!
    echo.
    goto :install
)

echo.
echo [2] Checking artisan file...
if exist "artisan" (
    echo ✅ artisan file exists
) else (
    echo ❌ artisan file NOT found
    goto :install
)

echo.
echo [3] Checking Laravel framework...
if exist "vendor\laravel" (
    echo ✅ Laravel framework found
) else (
    echo ❌ Laravel framework NOT found
    goto :install
)

echo.
echo [4] Testing Laravel...
where php >nul 2>&1
if %errorlevel% equ 0 (
    php artisan --version >nul 2>&1
    if %errorlevel% equ 0 (
        echo ✅ Laravel is installed and working
        php artisan --version
    ) else (
        echo ⚠️ Laravel files exist but may have issues
        goto :install
    )
) else (
    echo ⚠️ PHP not in PATH, using full path...
    C:\xampp\php\php.exe artisan --version >nul 2>&1
    if %errorlevel% equ 0 (
        echo ✅ Laravel is installed and working
        C:\xampp\php\php.exe artisan --version
    ) else (
        echo ⚠️ Laravel files exist but may have issues
        goto :install
    )
)

echo.
echo ====================================
echo Laravel is properly installed!
echo ====================================
goto :end

:install
echo.
echo ====================================
echo Installing Laravel Dependencies
echo ====================================
echo.

echo Checking for Composer...
where composer >nul 2>&1
if %errorlevel% equ 0 (
    echo Composer found, installing dependencies...
    composer install
    if %errorlevel% equ 0 (
        echo.
        echo ✅ Installation completed!
    ) else (
        echo.
        echo ❌ Installation failed!
        echo.
        echo Trying with composer.phar...
        if exist "composer.phar" (
            C:\xampp\php\php.exe composer.phar install
        ) else (
            echo.
            echo ERROR: Composer not found!
            echo Please install Composer or download composer.phar
            echo.
            echo See: INSTALL_COMPOSER.md
        )
    )
) else (
    echo Composer not in PATH, trying composer.phar...
    if exist "composer.phar" (
        C:\xampp\php\php.exe composer.phar install
    ) else (
        echo.
        echo ERROR: Composer not found!
        echo Please install Composer or download composer.phar
        echo.
        echo See: INSTALL_COMPOSER.md
    )
)

:end
echo.
pause

