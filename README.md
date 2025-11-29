# Background Remover API - Laravel Backend

این یک API backend برای اپلیکیشن Android Background Remover است که با Laravel و MySQL ساخته شده است.

## ویژگی‌ها

- ✅ احراز هویت با JWT Token
- ✅ آپلود و پردازش تصویر برای حذف پس‌زمینه
- ✅ سیستم Job Tracking برای پیگیری وضعیت پردازش
- ✅ پشتیبانی از MySQL (سازگار با Xampp)
- ✅ API RESTful

## پیش‌نیازها

- PHP >= 8.1
- Composer
- MySQL (از طریق Xampp)
- Xampp (یا هر سرور محلی دیگر)

## نصب و راه‌اندازی

### 1. نصب Composer Dependencies

```bash
cd backend
composer install
```

### 2. تنظیم فایل .env

فایل `.env.example` را کپی کرده و به `.env` تغییر نام دهید:

```bash
copy .env.example .env
```

سپس فایل `.env` را ویرایش کرده و اطلاعات دیتابیس را تنظیم کنید:

```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=bgremover_db
DB_USERNAME=root
DB_PASSWORD=
```

### 3. ایجاد دیتابیس

در phpMyAdmin (از طریق Xampp) یک دیتابیس با نام `bgremover_db` ایجاد کنید.

یا از طریق خط فرمان MySQL:

```sql
CREATE DATABASE bgremover_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### 4. تولید Application Key

```bash
php artisan key:generate
```

### 5. تولید JWT Secret

```bash
php artisan jwt:secret
```

این دستور به صورت خودکار `JWT_SECRET` را در فایل `.env` تنظیم می‌کند.

### 6. اجرای Migration ها

```bash
php artisan migrate
```

### 7. Seed کردن دیتابیس (ایجاد کاربر تست)

```bash
php artisan db:seed
```

این دستور یک کاربر تست با مشخصات زیر ایجاد می‌کند:
- **Username:** `testuser`
- **Password:** `password123`

### 8. ایجاد لینک Symbolic برای Storage

```bash
php artisan storage:link
```

این دستور لینک `public/storage` را به `storage/app/public` ایجاد می‌کند تا تصاویر قابل دسترسی باشند.

### 9. تنظیم Xampp

1. پروژه را در پوشه `htdocs` Xampp کپی کنید:
   ```
   C:\xampp\htdocs\backend
   ```

2. یا اگر پروژه در جای دیگری است، Virtual Host تنظیم کنید.

3. Apache و MySQL را در Xampp Control Panel راه‌اندازی کنید.

### 10. تست API

API در آدرس زیر در دسترس است:
```
http://localhost/backend/public/api
```

یا اگر Virtual Host تنظیم کرده‌اید:
```
http://bgremover-api.test/api
```

## ساختار API

### Base URL
```
http://localhost/backend/public/api
```

### Endpoints

#### 1. ورود (Login)
```
POST /auth/login
```

**Request Body:**
```json
{
    "username": "testuser",
    "password": "password123"
}
```

**Response (Success):**
```json
{
    "token": "eyJ0eXAiOiJKV1QiLCJhbGc..."
}
```

**Response (Error):**
```json
{
    "error": "Invalid credentials"
}
```

#### 2. حذف پس‌زمینه (Remove Background)
```
POST /remove-background
```

**Headers:**
```
Authorization: Bearer {token}
Content-Type: multipart/form-data
```

**Request Body:**
- `image`: فایل تصویر (jpeg, jpg, png - حداکثر 10MB)

**Response (Success):**
```json
{
    "result_url": "http://localhost/backend/public/storage/processed/image.png",
    "job_id": "1",
    "status": "completed"
}
```

**Response (Error):**
```json
{
    "error": "Validation failed",
    "messages": {
        "image": ["The image field is required."]
    }
}
```

#### 3. بررسی وضعیت Job
```
GET /job/{jobId}/status
```

**Headers:**
```
Authorization: Bearer {token}
```

**Response:**
```json
{
    "status": "completed",
    "progress": 100,
    "result_url": "http://localhost/backend/public/storage/processed/image.png"
}
```

**Status Values:**
- `processing`: در حال پردازش
- `completed`: تکمیل شده
- `failed`: ناموفق

## تست API با Postman یا cURL

### 1. ورود و دریافت Token

```bash
curl -X POST http://localhost/backend/public/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"testuser","password":"password123"}'
```

### 2. آپلود تصویر

```bash
curl -X POST http://localhost/backend/public/api/remove-background \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -F "image=@/path/to/your/image.jpg"
```

### 3. بررسی وضعیت Job

```bash
curl -X GET http://localhost/backend/public/api/job/1/status \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

## تنظیمات اپلیکیشن Android

در فایل `NetworkModule.kt` آدرس Base URL را تغییر دهید:

```kotlin
.baseUrl("http://YOUR_LOCAL_IP/backend/public/api/")
```

**نکته:** برای تست از دستگاه Android، به جای `localhost` از IP محلی سیستم خود استفاده کنید (مثلاً `192.168.1.100`).

برای پیدا کردن IP محلی:
- Windows: `ipconfig` در Command Prompt
- Mac/Linux: `ifconfig` در Terminal

## ساختار دیتابیس

### جدول users
- `id`: شناسه کاربر
- `username`: نام کاربری (منحصر به فرد)
- `email`: ایمیل (منحصر به فرد، اختیاری)
- `password`: رمز عبور (hash شده)
- `created_at`, `updated_at`: زمان‌های ایجاد و به‌روزرسانی

### جدول jobs
- `id`: شناسه Job
- `user_id`: شناسه کاربر (Foreign Key)
- `original_image_path`: مسیر تصویر اصلی
- `result_image_path`: مسیر تصویر پردازش شده
- `status`: وضعیت (processing, completed, failed)
- `progress`: پیشرفت (0-100)
- `created_at`, `updated_at`: زمان‌های ایجاد و به‌روزرسانی

## نکات مهم

1. **پردازش تصویر:** در حال حاضر، `BackgroundRemovalService` یک پیاده‌سازی ساده دارد. برای استفاده در production، باید با یک سرویس واقعی حذف پس‌زمینه (مثل remove.bg API یا ClipDrop API) یا یک مدل ML یکپارچه شود.

2. **امنیت:** در production، حتماً:
   - HTTPS را فعال کنید
   - Rate Limiting را تنظیم کنید
   - CORS را به درستی پیکربندی کنید
   - Validation را تقویت کنید

3. **بهینه‌سازی:** برای پردازش تصاویر بزرگ، می‌توانید از Queue و Job های Laravel استفاده کنید.

## عیب‌یابی

### خطای "Class 'Tymon\JWTAuth\Providers\LaravelServiceProvider' not found"
```bash
composer require tymon/jwt-auth
php artisan vendor:publish --provider="Tymon\JWTAuth\Providers\LaravelServiceProvider"
php artisan jwt:secret
```

### خطای "Storage link not found"
```bash
php artisan storage:link
```

### خطای "Database connection failed"
- مطمئن شوید MySQL در Xampp راه‌اندازی شده است
- اطلاعات دیتابیس در `.env` را بررسی کنید
- دیتابیس `bgremover_db` را ایجاد کرده باشید

## پشتیبانی

برای سوالات و مشکلات، لطفاً Issue ایجاد کنید.

