# راهنمای سریع رفع مشکلات

## مشکل فعلی شما

### 1. Warning: Module "zip" is already loaded
**این فقط یک هشدار است و مشکلی ایجاد نمی‌کند.** می‌توانید آن را نادیده بگیرید.

اگر می‌خواهید آن را برطرف کنید:
1. فایل `C:\xampp\php\php.ini` را باز کنید
2. خط `extension=zip` را پیدا کنید
3. اگر دو بار وجود دارد، یکی را حذف کنید
4. Apache را restart کنید

### 2. bootstrap/cache directory must be present and writable
**این مشکل حل شد!** پوشه‌های لازم ایجاد شدند.

## مراحل بعدی

حالا می‌توانید دستورات Laravel را اجرا کنید:

```bash
cd backend
php artisan key:generate
php artisan jwt:secret
php artisan migrate
php artisan db:seed
php artisan storage:link
```

یا از اسکریپت استفاده کنید:
```bash
fix_permissions.bat
```

## بررسی

برای اطمینان از اینکه همه چیز درست است:

```bash
php artisan --version
```

اگر خطایی دریافت کردید، فایل `TROUBLESHOOTING.md` را بررسی کنید.

