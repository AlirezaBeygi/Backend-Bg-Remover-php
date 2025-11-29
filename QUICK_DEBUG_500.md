# عیب‌یابی سریع خطای 500

## مشکل

درخواست به درستی ارسال می‌شود اما سرور خطای 500 برمی‌گرداند.

## مراحل عیب‌یابی

### 1. بررسی لاگ‌های Laravel

```bash
cd backend
check_logs.bat
```

یا دستی:
```bash
powershell -Command "Get-Content 'storage\logs\laravel.log' -Tail 30"
```

### 2. بررسی مشکلات رایج

#### مشکل 1: JWT Secret تنظیم نشده

**خطا در لاگ:**
```
JWT secret not set
```

**راه حل:**
```bash
php artisan jwt:secret
```

#### مشکل 2: Database Connection Failed

**خطا در لاگ:**
```
SQLSTATE[HY000] [2002] No connection could be made
```

**راه حل:**
1. MySQL را در Xampp راه‌اندازی کنید
2. دیتابیس `bgremover_db` را ایجاد کنید
3. فایل `.env` را بررسی کنید

#### مشکل 3: APP_KEY تنظیم نشده

**خطا در لاگ:**
```
No application encryption key has been specified
```

**راه حل:**
```bash
php artisan key:generate
```

#### مشکل 4: Class not found

**خطا در لاگ:**
```
Class 'Tymon\JWTAuth\...' not found
```

**راه حل:**
```bash
composer install
composer dump-autoload
```

### 3. تست مستقیم با Postman

برای اطمینان از اینکه مشکل از Android نیست:

```
POST http://localhost/backend/public/api/auth/login
Content-Type: application/json

{
    "username": "testuser",
    "password": "password123"
}
```

### 4. بررسی Apache Error Log

در Xampp:
```
C:\xampp\apache\logs\error.log
```

### 5. بررسی PHP Error Log

در Xampp:
```
C:\xampp\php\logs\php_error_log
```

## دستورات مفید

```bash
# پاک کردن cache
php artisan cache:clear
php artisan config:clear
php artisan route:clear

# بررسی route ها
php artisan route:list

# تست database
php artisan tinker
>>> DB::connection()->getPdo();
```

## اگر مشکل حل نشد

1. لاگ `storage/logs/laravel.log` را کامل بررسی کنید
2. خطای دقیق را کپی کنید
3. فایل `.env` را بررسی کنید (بدون نمایش اطلاعات حساس)

## نکات مهم

- مطمئن شوید `APP_DEBUG=true` در `.env` است
- لاگ‌ها معمولاً در `storage/logs/laravel.log` هستند
- خطای 500 معمولاً به دلیل مشکل در backend است نه Android

