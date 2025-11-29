# راهنمای APP_KEY در Laravel

## APP_KEY چیست؟

`APP_KEY` یک کلید رمزنگاری است که Laravel برای:
- رمزنگاری session data
- رمزنگاری cookies
- و سایر عملیات رمزنگاری استفاده می‌کند

## چگونه تولید می‌شود؟

**APP_KEY به صورت خودکار با دستور Laravel تولید می‌شود.**

### دستور تولید:

```bash
cd backend
php artisan key:generate
```

این دستور:
1. یک کلید رمزنگاری تصادفی و امن تولید می‌کند
2. به صورت خودکار در فایل `.env` قرار می‌دهد
3. فرمت آن به این صورت است: `base64:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`

### مثال:

بعد از اجرای `php artisan key:generate`، فایل `.env` به این صورت به‌روزرسانی می‌شود:

```env
APP_KEY=base64:y0uRrAnDoMkEyHeRe1234567890abcdefghijklmnopqrstuvwxyz==
```

## آیا باید دستی وارد کنم؟

**خیر!** نباید دستی وارد کنید. دلایل:

1. **امنیت:** کلید باید تصادفی و منحصر به فرد باشد
2. **طول:** کلید باید 32 کاراکتر باشد (بعد از base64 encoding)
3. **فرمت:** باید با `base64:` شروع شود

## مراحل نصب

### 1. ایجاد فایل .env

```bash
copy .env.example .env
```

یا از اسکریپت:
```bash
create_env.bat
```

### 2. تولید APP_KEY

```bash
php artisan key:generate
```

این دستور:
- کلید را تولید می‌کند
- در فایل `.env` قرار می‌دهد
- پیام موفقیت نمایش می‌دهد

### 3. بررسی

بعد از اجرای دستور، فایل `.env` را باز کنید و مطمئن شوید:

```env
APP_KEY=base64:...
```

**نکته:** اگر `APP_KEY=` خالی است، یعنی دستور اجرا نشده است.

## اگر APP_KEY تنظیم نشده باشد چه می‌شود؟

Laravel خطا می‌دهد:
```
RuntimeException: No application encryption key has been specified.
```

## آیا می‌توانم از کلید دیگری استفاده کنم؟

**بهتر است خیر!** اما اگر می‌خواهید:

```bash
php artisan key:generate --show
```

این دستور فقط کلید را نمایش می‌دهد (در `.env` قرار نمی‌دهد) و می‌توانید دستی کپی کنید.

## نکات مهم

1. **هر پروژه یک کلید منحصر به فرد:**
   - هر Laravel project باید کلید مخصوص خودش را داشته باشد
   - کلید یک پروژه را در پروژه دیگر استفاده نکنید

2. **در Production:**
   - حتماً کلید را در `.env` قرار دهید
   - هرگز کلید را در Git commit نکنید
   - `.env` در `.gitignore` است

3. **اگر کلید را گم کردید:**
   - می‌توانید دوباره `php artisan key:generate` را اجرا کنید
   - اما داده‌های رمزنگاری شده قبلی (مثل session) دیگر قابل استفاده نیستند

## خلاصه

✅ **درست:**
```bash
php artisan key:generate
```

❌ **غلط:**
```env
APP_KEY=my-secret-key-123  # ❌ این کار را نکنید!
```

## دستورات کامل نصب

```bash
cd backend
composer install
copy .env.example .env
php artisan key:generate      # ← اینجا APP_KEY تولید می‌شود
php artisan jwt:secret
php artisan migrate
php artisan db:seed
php artisan storage:link
```

یا از اسکریپت:
```bash
setup.bat
```

