# عیب‌یابی خطای 500 Internal Server Error

## مراحل عیب‌یابی

### 1. بررسی لاگ‌های Laravel

لاگ‌های Laravel در فایل زیر ذخیره می‌شوند:
```
storage/logs/laravel.log
```

برای مشاهده خطا:
```bash
# در پوشه backend
tail -f storage/logs/laravel.log
```

یا در Windows:
```bash
type storage\logs\laravel.log
```

### 2. بررسی مشکلات رایج

#### مشکل 1: JWT Secret تنظیم نشده

**خطا:**
```
JWT secret not set
```

**راه حل:**
```bash
php artisan jwt:secret
```

#### مشکل 2: Database Connection Failed

**خطا:**
```
SQLSTATE[HY000] [2002] No connection could be made
```

**راه حل:**
1. مطمئن شوید MySQL در Xampp راه‌اندازی شده است
2. فایل `.env` را بررسی کنید:
   ```env
   DB_CONNECTION=mysql
   DB_HOST=127.0.0.1
   DB_PORT=3306
   DB_DATABASE=bgremover_db
   DB_USERNAME=root
   DB_PASSWORD=
   ```

#### مشکل 3: APP_KEY تنظیم نشده

**خطا:**
```
No application encryption key has been specified
```

**راه حل:**
```bash
php artisan key:generate
```

#### مشکل 4: Permission Issues

**خطا:**
```
The stream or file could not be opened
```

**راه حل:**
```bash
# در Windows معمولاً مشکلی نیست
# اما اگر خطا دادید:
icacls "storage" /grant Users:F /T
icacls "bootstrap\cache" /grant Users:F /T
```

### 3. فعال کردن Debug Mode

در فایل `.env`:
```env
APP_DEBUG=true
```

این باعث می‌شود که خطاها به صورت کامل نمایش داده شوند.

### 4. تست مستقیم API

با Postman یا cURL تست کنید:

```bash
curl -X POST http://localhost/backend/public/api/auth/login \
  -H "Content-Type: application/json" \
  -d "{\"username\":\"testuser\",\"password\":\"password123\"}"
```

### 5. بررسی Apache Error Log

در Xampp، لاگ‌های Apache در:
```
C:\xampp\apache\logs\error.log
```

### 6. بررسی PHP Error Log

در Xampp، لاگ‌های PHP در:
```
C:\xampp\php\logs\php_error_log
```

## دستورات مفید

```bash
# پاک کردن cache
php artisan cache:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear

# بررسی route ها
php artisan route:list

# تست database connection
php artisan tinker
>>> DB::connection()->getPdo();
```

## اگر مشکل حل نشد

1. لاگ `storage/logs/laravel.log` را بررسی کنید
2. خطای دقیق را کپی کنید
3. فایل `.env` را بررسی کنید (بدون نمایش اطلاعات حساس)

