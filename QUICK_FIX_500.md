# رفع سریع خطای 500 Internal Server Error

## مراحل سریع

### 1. بررسی JWT Secret

```bash
php artisan jwt:secret
```

### 2. بررسی APP_KEY

```bash
php artisan key:generate
```

### 3. بررسی Database Connection

```bash
php artisan tinker
```

سپس در Tinker:
```php
DB::connection()->getPdo();
```

اگر خطا داد، دیتابیس را بررسی کنید.

### 4. بررسی لاگ‌ها

```bash
# در Windows
type storage\logs\laravel.log
```

یا آخرین خطوط:
```bash
powershell -Command "Get-Content 'storage\logs\laravel.log' -Tail 20"
```

### 5. پاک کردن Cache

```bash
php artisan cache:clear
php artisan config:clear
php artisan route:clear
```

### 6. استفاده از اسکریپت

```bash
check_status.bat
```

این اسکریپت تمام موارد بالا را بررسی می‌کند.

## مشکلات رایج

### مشکل 1: JWT Secret تنظیم نشده

**خطا در لاگ:**
```
JWT secret not set
```

**راه حل:**
```bash
php artisan jwt:secret
```

### مشکل 2: Database Connection Failed

**خطا در لاگ:**
```
SQLSTATE[HY000] [2002] No connection could be made
```

**راه حل:**
1. MySQL را در Xampp راه‌اندازی کنید
2. دیتابیس `bgremover_db` را ایجاد کنید
3. فایل `.env` را بررسی کنید

### مشکل 3: APP_KEY تنظیم نشده

**خطا در لاگ:**
```
No application encryption key has been specified
```

**راه حل:**
```bash
php artisan key:generate
```

## تست مستقیم

با Postman یا مرورگر تست کنید:

```
POST http://localhost/backend/public/api/auth/login
Content-Type: application/json

{
    "username": "testuser",
    "password": "password123"
}
```

اگر از `10.0.2.2` استفاده می‌کنید (Android Emulator)، مطمئن شوید که:
- Apache در Xampp راه‌اندازی شده است
- Backend در `http://localhost/backend/public/api` در دسترس است

