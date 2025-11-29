# راهنمای سریع اتصال Android به Backend

## اطلاعات ورود

- **Username:** `testuser`
- **Password:** `password123`

## مراحل سریع

### 1. پیدا کردن IP محلی

در Command Prompt یا PowerShell:
```bash
ipconfig
```

به دنبال `IPv4 Address` بگردید (مثلاً `192.168.1.100`)

### 2. تغییر Base URL در Android

فایل: `android-bg-remover/app/src/main/java/com/example/bgremover/di/NetworkModule.kt`

خط 64 را پیدا کنید و تغییر دهید:

```kotlin
.baseUrl("http://YOUR_IP_HERE/backend/public/api/")
```

**مثال:**
```kotlin
.baseUrl("http://192.168.1.100/backend/public/api/")
```

### 3. تست

1. اپلیکیشن را Build و Run کنید
2. Username: `testuser`
3. Password: `password123`
4. Login کنید

## نکات

- برای Emulator: از `10.0.2.2` استفاده کنید
- برای دستگاه واقعی: از IP محلی سیستم استفاده کنید
- مطمئن شوید Apache در Xampp راه‌اندازی شده است
- دستگاه Android و کامپیوتر باید در یک شبکه WiFi باشند

## عیب‌یابی سریع

| خطا | راه حل |
|-----|--------|
| Connection refused | Apache را در Xampp راه‌اندازی کنید |
| 401 Unauthorized | Username/Password را بررسی کنید |
| 404 Not Found | Base URL را بررسی کنید (باید `/api/` در انتها باشد) |

