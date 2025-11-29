@echo off
echo ====================================
echo Finding Main Error in Laravel Log
echo ====================================
echo.

if exist "storage\logs\laravel.log" (
    echo Searching for error messages...
    echo.
    echo === ERROR MESSAGES ===
    findstr /i "error exception fatal" "storage\logs\laravel.log" | findstr /v "^#" | findstr /v "^Stack trace"
    echo.
    echo === LAST ERROR (Full) ===
    powershell -Command "$content = Get-Content 'storage\logs\laravel.log' -Raw; $errors = $content -split '(?=\[.*\] local\.ERROR|Exception|Fatal)'; $lastError = $errors[-1]; if ($lastError.Length -gt 5000) { $lastError.Substring(0, 5000) } else { $lastError }"
    echo.
    echo ====================================
    echo.
    echo To see full log, open: storage\logs\laravel.log
    echo.
    echo Tip: Look for lines starting with:
    echo   [timestamp] local.ERROR
    echo   Exception:
    echo   Fatal error:
) else (
    echo ERROR: Laravel log file not found!
)
echo.
pause

