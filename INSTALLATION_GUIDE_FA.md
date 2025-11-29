# راهنمای نصب و راه‌اندازی - فارسی

## پیش‌نیازها

1. **Xampp** (یا هر سرور محلی دیگر)
2. **Composer** (مدیر بسته‌های PHP)
3. **PHP >= 8.1**
4. **MySQL** (از طریق Xampp)

## مراحل نصب

### مرحله 1: نصب Composer Dependencies

در پوشه `backend` دستور زیر را اجرا کنید:

```bash
composer install
```

### مرحله 2: تنظیم فایل .env

1. فایل `.env.example` را کپی کرده و به `.env` تغییر نام دهید
2. فایل `.env` را باز کرده و اطلاعات زیر را تنظیم کنید:

```env
APP_NAME="Background Remover API"
APP_ENV=local
APP_DEBUG=true
APP_URL=http://localhost/backend/public

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=bgremover_db
DB_USERNAME=root
DB_PASSWORD=
```

### مرحله 3: ایجاد دیتابیس

1. Xampp را راه‌اندازی کنید
2. به `http://localhost/phpmyadmin` بروید
3. یک دیتابیس جدید با نام `bgremover_db` ایجاد کنید
4. Collation را روی `utf8mb4_unicode_ci` تنظیم کنید

### مرحله 4: تولید Application Key

```bash
php artisan key:generate
```

### مرحله 5: تولید JWT Secret

```bash
php artisan jwt:secret
```

### مرحله 6: اجرای Migration ها

```bash
php artisan migrate
```

این دستور جداول `users` و `jobs` را در دیتابیس ایجاد می‌کند.

### مرحله 7: ایجاد کاربر تست

```bash
php artisan db:seed
```

این دستور یک کاربر تست با مشخصات زیر ایجاد می‌کند:
- **نام کاربری:** `testuser`
- **رمز عبور:** `password123`

### مرحله 8: ایجاد لینک Storage

```bash
php artisan storage:link
```

این دستور لینک `public/storage` را ایجاد می‌کند تا تصاویر قابل دسترسی باشند.

### مرحله 9: کپی پروژه به htdocs

پوشه `backend` را به `C:\xampp\htdocs\backend` کپی کنید.

یا اگر می‌خواهید در مسیر فعلی بماند، Virtual Host تنظیم کنید.

### مرحله 10: تست API

1. Apache و MySQL را در Xampp Control Panel راه‌اندازی کنید
2. به آدرس زیر بروید:

```
http://localhost/backend/public/api
```

باید پیام زیر را ببینید:

```json
{
    "message": "Background Remover API",
    "version": "1.0.0"
}
```

## تست با Postman

### 1. ورود و دریافت Token

**Method:** POST  
**URL:** `http://localhost/backend/public/api/auth/login`  
**Headers:**
```
Content-Type: application/json
```

**Body (JSON):**
```json
{
    "username": "testuser",
    "password": "password123"
}
```

**Response:**
```json
{
    "token": "eyJ0eXAiOiJKV1QiLCJhbGc..."
}
```

### 2. آپلود تصویر

**Method:** POST  
**URL:** `http://localhost/backend/public/api/remove-background`  
**Headers:**
```
Authorization: Bearer YOUR_TOKEN_HERE
```

**Body (form-data):**
- Key: `image`
- Type: File
- Value: انتخاب فایل تصویر

**Response:**
```json
{
    "result_url": "http://localhost/backend/public/storage/processed/...",
    "job_id": "1",
    "status": "completed"
}
```

## تنظیمات اپلیکیشن Android

در فایل `NetworkModule.kt` آدرس Base URL را تغییر دهید:

```kotlin
.baseUrl("http://YOUR_LOCAL_IP/backend/public/api/")
```

**نکته مهم:** برای تست از دستگاه Android، به جای `localhost` از IP محلی سیستم خود استفاده کنید.

برای پیدا کردن IP محلی در Windows:
```bash
ipconfig
```

به دنبال `IPv4 Address` بگردید (مثلاً `192.168.1.100`).

## مشکلات رایج

### خطای "Class not found"
```bash
composer install
```

### خطای "Database connection failed"
- مطمئن شوید MySQL در Xampp راه‌اندازی شده است
- اطلاعات دیتابیس در `.env` را بررسی کنید
- دیتابیس `bgremover_db` را ایجاد کرده باشید

### خطای "Storage link not found"
```bash
php artisan storage:link
```

### خطای "JWT Secret not set"
```bash
php artisan jwt:secret
```

## نکات مهم

1. **پردازش تصویر:** در حال حاضر، سرویس فقط تصویر را کپی می‌کند. برای استفاده واقعی، باید با یک سرویس حذف پس‌زمینه (مثل remove.bg) یکپارچه شود.

2. **امنیت:** در production، حتماً HTTPS را فعال کنید.

3. **IP محلی:** برای تست از دستگاه Android، از IP محلی سیستم استفاده کنید نه localhost.

