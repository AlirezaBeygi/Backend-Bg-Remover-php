# راهنمای نصب Composer در Windows

## روش 1: نصب Composer (توصیه می‌شود)

### مرحله 1: دانلود Composer

1. به آدرس زیر بروید:
   ```
   https://getcomposer.org/download/
   ```

2. فایل `Composer-Setup.exe` را دانلود کنید

### مرحله 2: نصب

1. فایل `Composer-Setup.exe` را اجرا کنید
2. در مراحل نصب، مسیر PHP را انتخاب کنید (معمولاً در Xampp):
   ```
   C:\xampp\php\php.exe
   ```
3. نصب را تکمیل کنید

### مرحله 3: بررسی نصب

یک Command Prompt یا PowerShell جدید باز کنید و دستور زیر را اجرا کنید:

```bash
composer --version
```

اگر نسخه Composer نمایش داده شد، نصب موفق بوده است.

## روش 2: استفاده از Composer PHAR (بدون نصب)

اگر نمی‌خواهید Composer را نصب کنید، می‌توانید از فایل PHAR استفاده کنید:

### مرحله 1: دانلود Composer PHAR

1. به آدرس زیر بروید:
   ```
   https://getcomposer.org/download/
   ```

2. روی "Manual Download" کلیک کنید
3. فایل `composer.phar` را دانلود کنید
4. فایل را در پوشه `backend` قرار دهید

### مرحله 2: استفاده از Composer PHAR

به جای `composer` از `php composer.phar` استفاده کنید:

```bash
php composer.phar install
php composer.phar update
```

## روش 3: استفاده از Xampp Shell

Xampp یک Shell مخصوص دارد که می‌توانید از آن استفاده کنید:

1. Xampp Control Panel را باز کنید
2. روی دکمه "Shell" کلیک کنید
3. به پوشه پروژه بروید:
   ```bash
   cd C:\xampp\htdocs\backend
   ```
4. دستورات Composer را اجرا کنید

## راهنمای سریع نصب Dependencies

بعد از نصب Composer، دستورات زیر را در پوشه `backend` اجرا کنید:

```bash
composer install
```

یا اگر از PHAR استفاده می‌کنید:

```bash
php composer.phar install
```

## عیب‌یابی

### خطای "php is not recognized"

اگر این خطا را دریافت کردید:

1. مسیر PHP را به PATH اضافه کنید:
   - به System Properties > Environment Variables بروید
   - در System Variables، `Path` را پیدا کنید
   - روی Edit کلیک کنید
   - مسیر `C:\xampp\php` را اضافه کنید

2. یا از مسیر کامل استفاده کنید:
   ```bash
   C:\xampp\php\php.exe composer.phar install
   ```

### خطای "openssl extension is missing"

در فایل `php.ini` (معمولاً در `C:\xampp\php\php.ini`) خط زیر را پیدا کرده و uncomment کنید:

```ini
extension=openssl
```

سپس Apache را در Xampp restart کنید.

