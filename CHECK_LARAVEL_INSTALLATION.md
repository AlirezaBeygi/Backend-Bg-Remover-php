# بررسی نصب Laravel

## چگونه بفهمیم Laravel نصب است یا نه؟

### بررسی سریع

```bash
cd E:\xampp\htdocs\backend

# بررسی vendor directory
dir vendor

# بررسی artisan
dir artisan

# بررسی composer.json
dir composer.json
```

### فایل‌های ضروری Laravel

اگر Laravel نصب باشد، باید این فایل‌ها وجود داشته باشند:

1. ✅ `vendor/` - پوشه dependencies
2. ✅ `artisan` - فایل command line Laravel
3. ✅ `composer.json` - فایل dependencies
4. ✅ `composer.lock` - فایل lock dependencies
5. ✅ `app/` - پوشه application
6. ✅ `bootstrap/` - پوشه bootstrap
7. ✅ `config/` - پوشه configuration
8. ✅ `routes/` - پوشه routes

## اگر Laravel نصب نیست

### روش 1: نصب با Composer (توصیه می‌شود)

```bash
cd E:\xampp\htdocs\backend
composer install
```

یا اگر Composer در PATH نیست:

```bash
cd E:\xampp\htdocs\backend
C:\xampp\php\php.exe composer.phar install
```

### روش 2: بررسی نصب

بعد از `composer install`، بررسی کنید:

```bash
# بررسی vendor
dir vendor

# تست Laravel
php artisan --version
```

اگر خطای "vendor not found" می‌بینید، Laravel نصب نیست.

## مراحل کامل نصب Laravel

### 1. بررسی Composer

```bash
composer --version
```

یا:

```bash
C:\xampp\php\php.exe composer.phar --version
```

### 2. نصب Dependencies

```bash
cd E:\xampp\htdocs\backend
composer install
```

### 3. بررسی نصب

```bash
php artisan --version
```

باید چیزی شبیه این ببینید:
```
Laravel Framework 10.x.x
```

### 4. اگر خطا داد

```bash
# پاک کردن vendor و نصب مجدد
rmdir /s /q vendor
composer install
```

## مشکلات رایج

### مشکل 1: vendor directory وجود ندارد

**راه حل:**
```bash
composer install
```

### مشکل 2: Composer install fails

**راه حل:**
- مطمئن شوید Composer نصب است
- یا از `composer.phar` استفاده کنید

### مشکل 3: Memory limit error

**راه حل:**
در `php.ini`:
```ini
memory_limit = 512M
```

## تست نصب

```bash
cd E:\xampp\htdocs\backend

# تست 1: بررسی version
php artisan --version

# تست 2: لیست command ها
php artisan list

# تست 3: بررسی route ها
php artisan route:list
```

اگر این دستورات کار کردند، Laravel نصب است.

## خلاصه

✅ **Laravel نصب است اگر:**
- پوشه `vendor` وجود دارد
- فایل `artisan` وجود دارد
- دستور `php artisan --version` کار می‌کند

❌ **Laravel نصب نیست اگر:**
- پوشه `vendor` وجود ندارد
- خطای "vendor not found" می‌بینید
- دستور `php artisan` کار نمی‌کند

## اگر Laravel نصب نیست

```bash
cd E:\xampp\htdocs\backend
composer install
```

این دستور تمام dependencies را نصب می‌کند.

