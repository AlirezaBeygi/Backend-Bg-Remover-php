# راهنمای عیب‌یابی

## مشکل 1: Module "zip" is already loaded

این یک هشدار است و معمولاً مشکلی ایجاد نمی‌کند. اما اگر می‌خواهید آن را برطرف کنید:

### راه حل:

1. فایل `php.ini` را باز کنید (معمولاً در `C:\xampp\php\php.ini`)

2. خطوط زیر را پیدا کنید:
   ```ini
   extension=zip
   ```

3. اگر دو بار این خط وجود دارد، یکی را حذف کنید یا comment کنید:
   ```ini
   ;extension=zip
   ```

4. Apache را در Xampp restart کنید

**نکته:** این فقط یک warning است و معمولاً مشکلی ایجاد نمی‌کند. می‌توانید آن را نادیده بگیرید.

## مشکل 2: bootstrap/cache directory must be present and writable

### راه حل:

1. **استفاده از اسکریپت خودکار:**
   ```bash
   fix_permissions.bat
   ```

2. **یا به صورت دستی:**
   ```bash
   mkdir bootstrap\cache
   mkdir storage\app\public
   mkdir storage\app\public\images
   mkdir storage\app\public\processed
   mkdir storage\framework\cache
   mkdir storage\framework\sessions
   mkdir storage\framework\views
   mkdir storage\logs
   ```

3. **بررسی دسترسی:**
   - روی پوشه `bootstrap\cache` راست کلیک کنید
   - Properties > Security
   - مطمئن شوید که Users یا Everyone دسترسی Write دارند

## مشکل 3: Storage directory not writable

### راه حل:

```bash
php artisan storage:link
```

اگر خطا داد:
```bash
C:\xampp\php\php.exe artisan storage:link
```

## مشکل 4: Permission denied errors

### راه حل Windows:

1. روی پوشه `storage` و `bootstrap\cache` راست کلیک کنید
2. Properties را انتخاب کنید
3. تب Security را باز کنید
4. روی Edit کلیک کنید
5. Users را انتخاب کرده و Full Control را فعال کنید
6. Apply و OK را بزنید

یا از Command Prompt به عنوان Administrator:

```bash
icacls "storage" /grant Users:F /T
icacls "bootstrap\cache" /grant Users:F /T
```

## مشکل 5: Composer install fails

### راه حل:

1. مطمئن شوید Composer نصب است:
   ```bash
   composer --version
   ```

2. یا از Composer PHAR استفاده کنید:
   ```bash
   php composer.phar install
   ```

3. اگر خطای memory limit دریافت کردید:
   - فایل `php.ini` را باز کنید
   - خط زیر را پیدا کنید:
     ```ini
     memory_limit = 128M
     ```
   - مقدار را افزایش دهید:
     ```ini
     memory_limit = 512M
     ```
   - Apache را restart کنید

## مشکل 6: Database connection failed

### راه حل:

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

3. دیتابیس را در phpMyAdmin ایجاد کنید:
   - به `http://localhost/phpmyadmin` بروید
   - New Database > نام: `bgremover_db` > Collation: `utf8mb4_unicode_ci`

## مشکل 7: JWT Secret not set

### راه حل:

```bash
php artisan jwt:secret
```

یا:

```bash
C:\xampp\php\php.exe artisan jwt:secret
```

## مشکل 8: Class not found errors

### راه حل:

```bash
composer dump-autoload
```

یا:

```bash
php composer.phar dump-autoload
```

## مشکل 9: 500 Internal Server Error

### راه حل:

1. فایل `.env` را بررسی کنید:
   ```env
   APP_DEBUG=true
   ```

2. لاگ‌ها را بررسی کنید:
   - `storage\logs\laravel.log`

3. مطمئن شوید تمام پوشه‌ها ایجاد شده‌اند:
   ```bash
   fix_permissions.bat
   ```

## مشکل 10: CORS errors در Android App

### راه حل:

1. در فایل `config/cors.php` مطمئن شوید:
   ```php
   'allowed_origins' => ['*'],
   ```

2. در Android App، از IP محلی استفاده کنید نه localhost:
   ```kotlin
   .baseUrl("http://192.168.1.100/backend/public/api/")
   ```

## دستورات مفید

```bash
# پاک کردن cache
php artisan cache:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear

# بهینه‌سازی
php artisan optimize
composer dump-autoload -o
```

## تماس برای کمک

اگر مشکل شما حل نشد:
1. لاگ‌ها را بررسی کنید: `storage\logs\laravel.log`
2. خطای دقیق را کپی کنید
3. فایل `.env` را بررسی کنید (بدون نمایش اطلاعات حساس)

