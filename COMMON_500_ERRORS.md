# خطاهای رایج 500 و راه حل‌ها

## خطاهای احتمالی

### 1. JWT Secret not set

**خطا:**
```
JWT secret not set. Please run: php artisan jwt:secret
```

**راه حل:**
```bash
cd E:\xampp\htdocs\backend
php artisan jwt:secret
```

### 2. Database Connection Failed

**خطا:**
```
SQLSTATE[HY000] [2002] No connection could be made because the target machine actively refused it
```

**راه حل:**
1. MySQL را در Xampp راه‌اندازی کنید
2. دیتابیس `bgremover_db` را ایجاد کنید
3. فایل `.env` را بررسی کنید

### 3. APP_KEY not set

**خطا:**
```
RuntimeException: No application encryption key has been specified
```

**راه حل:**
```bash
cd E:\xampp\htdocs\backend
php artisan key:generate
```

### 4. Class not found (JWT)

**خطا:**
```
Class 'Tymon\JWTAuth\Facades\JWTAuth' not found
```

**راه حل:**
```bash
cd E:\xampp\htdocs\backend
composer install
composer dump-autoload
```

### 5. Cache Driver Issue

**خطا:**
```
Cache store [database] is not defined
```

**راه حل:**
```bash
php artisan cache:table
php artisan migrate
```

## دستورات سریع برای رفع مشکل

```bash
cd E:\xampp\htdocs\backend

# 1. بررسی و تنظیم APP_KEY
php artisan key:generate

# 2. تنظیم JWT Secret
php artisan jwt:secret

# 3. پاک کردن cache
php artisan cache:clear
php artisan config:clear
php artisan route:clear

# 4. بررسی database
php artisan migrate:status

# 5. اگر مشکل از composer است
composer dump-autoload
```

## بررسی سریع

```bash
cd E:\xampp\htdocs\backend

# بررسی APP_KEY
php artisan tinker --execute="echo config('app.key');"

# بررسی JWT_SECRET
php artisan tinker --execute="echo config('jwt.secret');"

# تست database
php artisan tinker --execute="DB::connection()->getPdo();"
```

## نکات مهم

1. **مسیر:** اگر backend در `E:\xampp\htdocs\backend` است، باید از آن مسیر دستورات را اجرا کنید
2. **Environment:** مطمئن شوید که فایل `.env` در مسیر صحیح است
3. **Permissions:** مطمئن شوید که پوشه `storage` قابل نوشتن است

