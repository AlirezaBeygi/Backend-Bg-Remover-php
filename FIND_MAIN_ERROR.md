# پیدا کردن خطای اصلی در لاگ Laravel

## مشکل

Stack trace را می‌بینید اما خطای اصلی را نمی‌بینید.

## راه حل

### روش 1: استفاده از اسکریپت

```bash
cd backend
find_error.bat
```

این اسکریپت خطاهای اصلی را پیدا می‌کند.

### روش 2: بررسی دستی

فایل `storage/logs/laravel.log` را باز کنید و به دنبال این موارد بگردید:

1. **خطوط با `local.ERROR`:**
   ```
   [2025-11-29 02:58:07] local.ERROR: ...
   ```

2. **خطوط با `Exception`:**
   ```
   Exception: ...
   ```

3. **خطوط با `Fatal error`:**
   ```
   Fatal error: ...
   ```

### روش 3: آخرین خطا

```bash
# در PowerShell
Get-Content 'storage\logs\laravel.log' | Select-String -Pattern "ERROR|Exception|Fatal" | Select-Object -Last 5
```

## خطاهای رایج

### 1. JWT Secret not set

```
local.ERROR: JWT secret not set
```

**راه حل:**
```bash
php artisan jwt:secret
```

### 2. Database Connection Failed

```
SQLSTATE[HY000] [2002] No connection could be made
```

**راه حل:**
- MySQL را در Xampp راه‌اندازی کنید
- دیتابیس را ایجاد کنید

### 3. Class not found

```
Class 'Tymon\JWTAuth\...' not found
```

**راه حل:**
```bash
composer install
composer dump-autoload
```

### 4. APP_KEY not set

```
No application encryption key has been specified
```

**راه حل:**
```bash
php artisan key:generate
```

## اگر خطا را پیدا کردید

خطای کامل را کپی کنید و بفرستید تا بتوانم کمک کنم.

## نکته

خطای اصلی معمولاً **قبل از** stack trace است. به ابتدای لاگ نگاه کنید.

