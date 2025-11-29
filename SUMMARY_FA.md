# خلاصه پروژه Backend - Background Remover API

## ساختار پروژه

این پروژه یک API backend با Laravel 10 و MySQL برای اپلیکیشن Android Background Remover است.

### فایل‌های اصلی

#### Controllers
- **`app/Http/Controllers/AuthController.php`**: مدیریت احراز هویت و ورود
- **`app/Http/Controllers/BackgroundRemovalController.php`**: مدیریت آپلود و پردازش تصویر

#### Models
- **`app/Models/User.php`**: مدل کاربر با پشتیبانی از JWT
- **`app/Models/Job.php`**: مدل Job برای پیگیری وضعیت پردازش

#### Services
- **`app/Services/BackgroundRemovalService.php`**: سرویس پردازش تصویر (قابل توسعه)

#### Routes
- **`routes/api.php`**: تعریف تمام endpoint های API

#### Migrations
- **`database/migrations/2024_01_01_000001_create_users_table.php`**: ایجاد جدول users
- **`database/migrations/2024_01_01_000002_create_jobs_table.php`**: ایجاد جدول jobs

#### Seeders
- **`database/seeders/DatabaseSeeder.php`**: ایجاد کاربر تست

## API Endpoints

### 1. POST `/api/auth/login`
ورود کاربر و دریافت JWT Token

**Request:**
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

### 2. POST `/api/remove-background`
آپلود تصویر و حذف پس‌زمینه

**Headers:**
```
Authorization: Bearer {token}
```

**Request:**
- Multipart form data
- Field: `image` (فایل تصویر)

**Response:**
```json
{
    "result_url": "http://localhost/backend/public/storage/processed/...",
    "job_id": "1",
    "status": "completed"
}
```

### 3. GET `/api/job/{jobId}/status`
بررسی وضعیت Job

**Headers:**
```
Authorization: Bearer {token}
```

**Response:**
```json
{
    "status": "completed",
    "progress": 100,
    "result_url": "http://localhost/backend/public/storage/processed/..."
}
```

## دیتابیس

### جدول users
- `id`: شناسه کاربر
- `username`: نام کاربری (unique)
- `email`: ایمیل (unique, nullable)
- `password`: رمز عبور (hashed)
- `created_at`, `updated_at`

### جدول jobs
- `id`: شناسه Job
- `user_id`: شناسه کاربر (foreign key)
- `original_image_path`: مسیر تصویر اصلی
- `result_image_path`: مسیر تصویر پردازش شده
- `status`: وضعیت (processing, completed, failed)
- `progress`: پیشرفت (0-100)
- `created_at`, `updated_at`

## امنیت

- استفاده از JWT برای احراز هویت
- Hash کردن رمزهای عبور با bcrypt
- Validation برای تمام ورودی‌ها
- CORS پیکربندی شده

## نکات توسعه

### پردازش تصویر

در حال حاضر، `BackgroundRemovalService` فقط تصویر را کپی می‌کند. برای استفاده واقعی، می‌توانید:

1. **استفاده از remove.bg API:**
   - ثبت‌نام در https://www.remove.bg/api
   - دریافت API Key
   - یکپارچه‌سازی در `BackgroundRemovalService`

2. **استفاده از ClipDrop API:**
   - ثبت‌نام در https://clipdrop.co/api
   - یکپارچه‌سازی API

3. **استفاده از مدل ML:**
   - استفاده از Python script با exec()
   - یا استفاده از Queue برای پردازش async

### بهینه‌سازی

- استفاده از Queue برای پردازش async
- Cache کردن نتایج
- Rate Limiting
- Image compression

## فایل‌های راهنما

- **`README.md`**: راهنمای کامل به انگلیسی
- **`INSTALLATION_GUIDE_FA.md`**: راهنمای نصب به فارسی
- **`setup.bat`**: اسکریپت نصب خودکار برای Windows

## مراحل بعدی

1. ✅ نصب و راه‌اندازی پروژه
2. ✅ تست API با Postman
3. ⏳ یکپارچه‌سازی با سرویس واقعی حذف پس‌زمینه
4. ⏳ بهینه‌سازی و بهبود عملکرد
5. ⏳ اضافه کردن تست‌های واحد

