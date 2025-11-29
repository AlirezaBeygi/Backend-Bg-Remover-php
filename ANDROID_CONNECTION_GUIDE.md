# راهنمای اتصال اپلیکیشن Android به Backend

## اطلاعات ورود (Login)

### کاربر تست
- **Username:** `testuser`
- **Password:** `password123`

این کاربر به صورت خودکار در هنگام اجرای `php artisan db:seed` ایجاد شده است.

## مراحل اتصال Android App به Backend

### مرحله 1: پیدا کردن IP محلی سیستم

برای تست از دستگاه Android، باید از IP محلی سیستم استفاده کنید نه `localhost`.

#### در Windows:
```bash
ipconfig
```

به دنبال `IPv4 Address` بگردید (مثلاً `192.168.1.100`)

#### در Mac/Linux:
```bash
ifconfig
```

### مرحله 2: به‌روزرسانی Base URL در Android App

فایل `NetworkModule.kt` را باز کنید و Base URL را تغییر دهید:

**قبل:**
```kotlin
.baseUrl("https://your-wp-plugin-api.example/")
```

**بعد:**
```kotlin
.baseUrl("http://YOUR_LOCAL_IP/backend/public/api/")
```

**مثال:**
```kotlin
.baseUrl("http://192.168.1.100/backend/public/api/")
```

**نکته مهم:**
- از `http` استفاده کنید نه `https` (برای localhost)
- IP محلی سیستم خود را جایگزین کنید
- مسیر `/backend/public/api/` را حفظ کنید
- در انتهای URL حتماً `/` بگذارید

### مرحله 3: تست اتصال

1. **تست Login:**
   - اپلیکیشن را اجرا کنید
   - Username: `testuser`
   - Password: `password123`
   - روی دکمه Login کلیک کنید

2. **تست آپلود تصویر:**
   - بعد از ورود موفق
   - یک تصویر انتخاب کنید
   - روی دکمه پردازش کلیک کنید

## عیب‌یابی

### خطای "Connection refused" یا "Failed to connect"

**راه حل:**
1. مطمئن شوید Apache در Xampp راه‌اندازی شده است
2. IP محلی را درست وارد کرده‌اید
3. دستگاه Android و کامپیوتر در یک شبکه WiFi هستند
4. Firewall Windows را بررسی کنید (ممکن است نیاز به اجازه دادن باشد)

### خطای "401 Unauthorized"

**راه حل:**
1. مطمئن شوید که Login موفق بوده است
2. Token به درستی ذخیره شده است
3. در Header درخواست، `Bearer` را فراموش نکنید

### خطای "404 Not Found"

**راه حل:**
1. مسیر Base URL را بررسی کنید
2. مطمئن شوید که `/api/` در انتهای URL است
3. فایل `.htaccess` در پوشه `public` وجود دارد

### خطای CORS

اگر خطای CORS دریافت کردید، فایل `config/cors.php` را بررسی کنید:

```php
'allowed_origins' => ['*'],
```

## تست با Postman

قبل از تست در Android، می‌توانید با Postman تست کنید:

### 1. Login
```
POST http://localhost/backend/public/api/auth/login
Content-Type: application/json

{
    "username": "testuser",
    "password": "password123"
}
```

### 2. Remove Background
```
POST http://localhost/backend/public/api/remove-background
Authorization: Bearer YOUR_TOKEN_HERE
Content-Type: multipart/form-data

image: [انتخاب فایل تصویر]
```

## نکات مهم

1. **برای تست از Emulator:**
   - از `10.0.2.2` به جای `localhost` استفاده کنید
   - Base URL: `http://10.0.2.2/backend/public/api/`

2. **برای تست از دستگاه واقعی:**
   - از IP محلی سیستم استفاده کنید
   - مطمئن شوید دستگاه و کامپیوتر در یک شبکه هستند

3. **امنیت:**
   - در production، حتماً از HTTPS استفاده کنید
   - Token را به صورت امن ذخیره کنید (که در کد شما انجام شده)

## ایجاد کاربر جدید

اگر می‌خواهید کاربر جدید ایجاد کنید:

### روش 1: از طریق phpMyAdmin
1. به `http://localhost/phpmyadmin` بروید
2. دیتابیس `bgremover_db` را انتخاب کنید
3. جدول `users` را باز کنید
4. روی "Insert" کلیک کنید
5. اطلاعات را وارد کنید:
   - `username`: نام کاربری
   - `password`: رمز عبور (باید hash شده باشد)
   - برای hash کردن رمز عبور:
     ```bash
     php artisan tinker
     >>> Hash::make('your_password')
     ```

### روش 2: از طریق Seeder
فایل `database/seeders/DatabaseSeeder.php` را ویرایش کنید و کاربر جدید اضافه کنید.

