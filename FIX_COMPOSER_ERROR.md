# رفع خطای Composer install

## مشکل

خطای `Method Illuminate\Foundation\Console\ClosureCommand::hourly does not exist` در هنگام اجرای `composer install`

## راه حل

### مرحله 1: پاک کردن Cache

```bash
# در پوشه backend
del bootstrap\cache\*.php
```

یا از اسکریپت استفاده کنید:
```bash
clear_cache.bat
```

### مرحله 2: بررسی فایل routes/console.php

مطمئن شوید که فایل `routes/console.php` به این صورت است:

```php
<?php

use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote');
```

**نکته:** نباید `->hourly()` در انتهای خط 8 باشد.

### مرحله 3: اجرای مجدد Composer

```bash
composer install --no-scripts
```

سپس:

```bash
composer dump-autoload
```

### مرحله 4: اگر هنوز خطا دارد

فایل `routes/console.php` را به صورت کامل حذف کرده و دوباره ایجاد کنید:

```bash
# حذف فایل
del routes\console.php

# ایجاد فایل جدید
echo. > routes\console.php
```

سپس محتوای زیر را در فایل قرار دهید:

```php
<?php

use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote');
```

### راه حل جایگزین: غیرفعال کردن post-autoload-dump

اگر مشکل ادامه داشت، می‌توانید موقتاً script را غیرفعال کنید:

در `composer.json`، بخش `scripts` را به این صورت تغییر دهید:

```json
"scripts": {
    "post-autoload-dump": [
        "Illuminate\\Foundation\\ComposerScripts::postAutoloadDump"
    ]
}
```

یعنی خط `"@php artisan package:discover --ansi"` را حذف کنید.

سپس:

```bash
composer install
php artisan package:discover
```

## بررسی نهایی

بعد از رفع مشکل، دستورات زیر را اجرا کنید:

```bash
php artisan key:generate
php artisan jwt:secret
php artisan migrate
php artisan db:seed
php artisan storage:link
```

