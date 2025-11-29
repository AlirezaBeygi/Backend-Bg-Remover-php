# رفع سریع خطای Composer

## مشکل
خطای `hourly does not exist` در هنگام `composer install`

## راه حل سریع

### گزینه 1: نصب بدون Scripts (توصیه می‌شود)

```bash
composer install --no-scripts
```

سپس:

```bash
composer dump-autoload
php artisan package:discover
```

### گزینه 2: استفاده از Composer PHAR

```bash
php composer.phar install --no-scripts
php composer.phar dump-autoload
```

### گزینه 3: پاک کردن Cache و نصب مجدد

```bash
# پاک کردن cache
del bootstrap\cache\*.php
rmdir /s /q vendor 2>nul

# نصب مجدد
composer install --no-scripts
composer dump-autoload
```

## بعد از نصب

```bash
php artisan key:generate
php artisan jwt:secret
php artisan migrate
php artisan db:seed
php artisan storage:link
```

## نکته

فایل `composer.json` به‌روزرسانی شده و script مشکل‌دار حذف شده است. حالا می‌توانید `composer install` را بدون `--no-scripts` اجرا کنید.

